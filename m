Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 04:24:49 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:50747 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490969Ab1DNCYp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2011 04:24:45 +0200
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 7585D867E2;
        Thu, 14 Apr 2011 04:24:45 +0200 (CEST)
Date:   Wed, 13 Apr 2011 19:16:56 -0700
From:   Greg KH <gregkh@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-usb@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] USB: OHCI: Fix build warning on Alchemy
Message-ID: <20110414021656.GB13169@suse.de>
References: <20110413232308.GA22925@linux-mips.org>
 <20110413234317.GB17342@suse.de>
 <20110414003124.GA9660@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110414003124.GA9660@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 14, 2011 at 02:31:24AM +0200, Ralf Baechle wrote:
> On Wed, Apr 13, 2011 at 04:43:17PM -0700, Greg KH wrote:
> 
> > On Thu, Apr 14, 2011 at 01:23:08AM +0200, Ralf Baechle wrote:
> > >   CC      drivers/usb/host/ohci-hcd.o
> > > In file included from drivers/usb/host/ohci-hcd.c:1028:0:
> > > drivers/usb/host/ohci-au1xxx.c:36:7: warning: "__BIG_ENDIAN" is not defined [-Wundef]
> > > 
> > > Fix the warning and some other build bullet proofing; let's not rely on
> > > other needed header files getting dragged in magically.
> > 
> > Ick, I just applied the second part of this patch to my "for-linus"
> > tree as a patch from someone else.  Are the #include changes really
> > needed right now?
> 
> No, the include stuff was more for paranoia.
> 
> However the warning fixed by the 2nd part of the patch exists back to
> at least 2.6.27.

Ah, it's not that much of a rush then :)

thanks,

greg k-h
