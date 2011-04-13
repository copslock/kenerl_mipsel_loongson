Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2011 01:44:59 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:47924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491824Ab1DMXox (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Apr 2011 01:44:53 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 3E8EC86A2E;
        Thu, 14 Apr 2011 01:44:51 +0200 (CEST)
Date:   Wed, 13 Apr 2011 16:43:17 -0700
From:   Greg KH <gregkh@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-usb@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] USB: OHCI: Fix build warning on Alchemy
Message-ID: <20110413234317.GB17342@suse.de>
References: <20110413232308.GA22925@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110413232308.GA22925@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Thu, Apr 14, 2011 at 01:23:08AM +0200, Ralf Baechle wrote:
>   CC      drivers/usb/host/ohci-hcd.o
> In file included from drivers/usb/host/ohci-hcd.c:1028:0:
> drivers/usb/host/ohci-au1xxx.c:36:7: warning: "__BIG_ENDIAN" is not defined [-Wundef]
> 
> Fix the warning and some other build bullet proofing; let's not rely on
> other needed header files getting dragged in magically.

Ick, I just applied the second part of this patch to my "for-linus"
tree as a patch from someone else.  Are the #include changes really
needed right now?

thanks,

greg k-h
