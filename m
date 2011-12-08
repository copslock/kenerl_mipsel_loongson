Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 11:45:39 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49302 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903698Ab1LHKp0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2011 11:45:26 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB8AjNOA009085;
        Thu, 8 Dec 2011 10:45:23 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB8AjNSt009083;
        Thu, 8 Dec 2011 10:45:23 GMT
Date:   Thu, 8 Dec 2011 10:45:23 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Axel Lin <axel.lin@gmail.com>, linux-mips@linux-mips.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] MTD: nand: Convert au1550nd to use
 module_platform_driver()
Message-ID: <20111208104522.GA21777@linux-mips.org>
References: <1322748247.31743.1.camel@phoenix>
 <1323008139.9400.59.camel@sauron.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323008139.9400.59.camel@sauron.fi.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6697

On Sun, Dec 04, 2011 at 04:15:32PM +0200, Artem Bityutskiy wrote:

> > Hi Ralf,
> > This patch converts au1550nd to use module_platform_driver().
> > You have committed a5bd32fd "MTD: nand: make au1550nd.c a platform_driver".
> > Currently this patch can only apply to either your tree or linux-next.
> > Could you help to take it.
> > ( committed a5bd32fd does not exist in l2-mtd-2.6.git,
> > so Artem cannot apply it.)
> 
> Yes, please, merge the au1550nd.c piece via Ralf, thanks!

No point in adding code to change it again first commit so I've folded
this patch into "MTD: nand: make au1550nd.c a platform_driver".

Thanks folks!

  Ralf
