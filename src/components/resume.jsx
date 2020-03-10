import React, { Component } from 'react';
import { Document, Page } from 'react-pdf';


export default class Resume extends Component {

    state = {
        numPages: null,
        pageNumber: 1,
      }
    
      onDocumentLoadSuccess = ({ numPages }) => {
        this.setState({ numPages });
      }


    render() {
        const { pageNumber, numPages } = this.state;
    
        return (
          <div>
            <Document
              file="url(files/resume_leehangwee.pdf)"
              onLoadSuccess={this.onDocumentLoadSuccess}
            >
              <Page pageNumber={pageNumber} />
            </Document>
            <p>Page {pageNumber} of {numPages}</p>
          </div>
        );
      }
}
