Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 18:11:17 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:35989 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20021541AbXJJRLI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 18:11:08 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	by relay01.mx.bawue.net (Postfix) with ESMTP id DE3E448BCA;
	Wed, 10 Oct 2007 19:10:19 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Iff4p-00034U-9g; Wed, 10 Oct 2007 18:10:31 +0100
Date:	Wed, 10 Oct 2007 18:10:31 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	kaka <share.kt@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Unknown symbol errors in insmod <driver name>
Message-ID: <20071010171030.GB3379@networkno.de>
References: <eea8a9c90710100545y35d69e0ck96787609a935a889@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eea8a9c90710100545y35d69e0ck96787609a935a889@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

kaka wrote:
> Hi All,
> 
> WHile installing framebuffer driver for BCM chip in MIPS platform(cross
> compiled in intel 86).
> I am getting the following error.
> Can somebody help in this regard?
> Thanks in Advance.
> 
> # insmod brcmstfb.ko
> brcmstfb: Unknown symbol unregister_framebuffer
> brcmstfb: Unknown symbol printf
> brcmstfb: Unknown symbol __make_dp
> brcmstfb: Unknown symbol malloc
> brcmstfb: Unknown symbol framebuffer_alloc
> brcmstfb: Unknown symbol fb_find_mode
> brcmstfb: Unknown symbol fb_dealloc_cmap
> brcmstfb: Unknown symbol brcm_dir_entry
> brcmstfb: Unknown symbol register_framebuffer
> brcmstfb: Unknown symbol fb_alloc_cmap
> brcmstfb: Unknown symbol framebuffer_release
> brcmstfb: Unknown symbol free

Ask the supplier of "brcmstfb.ko" what they did there. printf/malloc/free
aren't functions which are normally available from kernel proper.


Thiemo
