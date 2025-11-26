import logging
import azure.functions as func
import os
from analyze import run_clustering_analysis

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('ML clustering function triggered.')
    
    try:
        # Get parameters from request
        n_clusters = int(req.params.get('n_clusters', 3))
        output_format = req.params.get('format', 'html')
        
        # Get Trino connection from environment
        trino_host = os.environ['TRINO_HOST']
        trino_port = int(os.environ['TRINO_PORT'])
        
        # Call your core logic
        result = run_clustering_analysis(
            trino_host=trino_host,
            trino_port=trino_port,
            n_clusters=n_clusters,
            output_format=output_format
        )
        
        # Return appropriate response
        if output_format == 'json':
            import json
            return func.HttpResponse(
                json.dumps(result),
                mimetype="application/json",
                status_code=200
            )
        elif output_format == 'png':
            return func.HttpResponse(
                result,
                mimetype="image/png",
                status_code=200
            )
        else:
            return func.HttpResponse(
                result,
                mimetype="text/html",
                status_code=200
            )
            
    except Exception as e:
        logging.error(f"Error in ML clustering function: {str(e)}")
        return func.HttpResponse(f"Error: {str(e)}", status_code=500)
 