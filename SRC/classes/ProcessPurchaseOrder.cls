public class ProcessPurchaseOrder {
        public ProcessPurchaseOrder() {
            PurchaseOrder order1 =new CustomerPurchaseOrderController();
            PurchaseOrder order2 =new EmployeePurchaseOrderController();
    
            processOrder(order1);
            processOrder(order2);
        }
        public void processOrder(PurchaseOrder order){
            System.debug('Check discount : '+order.discount());
        }
}