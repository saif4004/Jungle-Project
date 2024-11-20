describe("Add to cart", () => {
  it("should add a product to the cart", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
    cy.get(".products article").should("have.length", 2);
    cy.get(".products article").first().click();
    cy.url().should("include", "/products/");
    cy.get('.btn').click();
    cy.get('.end-0 > .nav-link').should('have.length', 1);
  });
});