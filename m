Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 16:30:27 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59098 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492693AbZLBPaV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 16:30:21 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB2FUIrm010647;
        Wed, 2 Dec 2009 15:30:19 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB2FUHU2010645;
        Wed, 2 Dec 2009 15:30:17 GMT
Date:   Wed, 2 Dec 2009 15:30:16 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     linux-mips@linux-mips.org,
        Thomas Koeller <thomas.koeller@baslerweb.com>
Subject: RFC: Removal of Basler eXcite platform support
Message-ID: <20091202153016.GA9892@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25275
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Support for the Basler eXcite was never fully merged and there seems to be
no push to complete that or any users.  So I'd like to remove the support
for it in the upcoming 2.6.33 cycle.  Any comments?

I'll post the patch which I already have sitting in the queue tree in a
a separate mail.

  Ralf
