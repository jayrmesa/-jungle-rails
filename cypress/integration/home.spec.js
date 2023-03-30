describe("Testing Home Page", () => {
  before(() => {
    cy.visit("0.0.0.0:3000"); // Visits the Home Page
  })

  it("products are on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
});