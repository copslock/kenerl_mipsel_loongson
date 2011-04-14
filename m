Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 02:32:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41180 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491912Ab1DNAcl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2011 02:32:41 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p3E0VPa9009976;
        Thu, 14 Apr 2011 02:31:25 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p3E0VOTL009971;
        Thu, 14 Apr 2011 02:31:24 +0200
Date:   Thu, 14 Apr 2011 02:31:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg KH <gregkh@suse.de>
Cc:     linux-usb@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] USB: OHCI: Fix build warning on Alchemy
Message-ID: <20110414003124.GA9660@linux-mips.org>
References: <20110413232308.GA22925@linux-mips.org>
 <20110413234317.GB17342@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110413234317.GB17342@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 13, 2011 at 04:43:17PM -0700, Greg KH wrote:

> On Thu, Apr 14, 2011 at 01:23:08AM +0200, Ralf Baechle wrote:
> >   CC      drivers/usb/host/ohci-hcd.o
> > In file included from drivers/usb/host/ohci-hcd.c:1028:0:
> > drivers/usb/host/ohci-au1xxx.c:36:7: warning: "__BIG_ENDIAN" is not defined [-Wundef]
> > 
> > Fix the warning and some other build bullet proofing; let's not rely on
> > other needed header files getting dragged in magically.
> 
> Ick, I just applied the second part of this patch to my "for-linus"
> tree as a patch from someone else.  Are the #include changes really
> needed right now?

No, the include stuff was more for paranoia.

However the warning fixed by the 2nd part of the patch exists back to
at least 2.6.27.

  Ralf
