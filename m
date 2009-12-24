Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Dec 2009 14:23:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44283 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492020AbZLXNW5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Dec 2009 14:22:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nBODMxE1029743;
        Thu, 24 Dec 2009 14:22:59 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nBODMvS7029741;
        Thu, 24 Dec 2009 14:22:57 +0100
Date:   Thu, 24 Dec 2009 14:22:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Julia Lawall <julia@diku.dk>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/9] arch/mips/alchemy: Correct code taking the size of a
 pointer
Message-ID: <20091224132257.GA29598@linux-mips.org>
References: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0912131240100.24267@ask.diku.dk>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 13, 2009 at 12:40:39PM +0100, Julia Lawall wrote:

> From: Julia Lawall <julia@diku.dk>
> 
> sizeof(dp) is just the size of the pointer.  Change it to the size of the
> referenced structure.

Thanks Julia, applied.

  Ralf
