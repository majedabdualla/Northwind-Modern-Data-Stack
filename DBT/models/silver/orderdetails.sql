select 

                    orderid as order_id ,
                    productid as product_id,
                    unitprice,
                    quantity,
                    discount,
                    current_timestamp as ingestion_timestamp

FROM  {{source('bronze','orderdetails')}}            