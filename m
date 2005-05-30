Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 May 2005 13:06:17 +0100 (BST)
Received: from natsmtp00.rzone.de ([IPv6:::ffff:81.169.145.165]:58755 "EHLO
	natsmtp00.rzone.de") by linux-mips.org with ESMTP
	id <S8225408AbVE3MGB>; Mon, 30 May 2005 13:06:01 +0100
Received: from [192.168.128.50] (p548DD5D1.dip.t-dialin.net [84.141.213.209])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j4UC5wqX017448
	for <linux-mips@linux-mips.org>; Mon, 30 May 2005 14:05:59 +0200 (MEST)
From:	Hauke Goos-Habermann <haukeh@pc-kiel.de>
To:	linux-mips@linux-mips.org
Subject: Re: CCA4 mapping
Date:	Mon, 30 May 2005 14:05:55 +0200
User-Agent: KMail/1.7.2
References: <200505261520.34985.haukeh@pc-kiel.de> <530c77f53c1c8706d6fd75a07ad091ca@embeddedalley.com>
In-Reply-To: <530c77f53c1c8706d6fd75a07ad091ca@embeddedalley.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200505301405.58180.haukeh@pc-kiel.de>
Return-Path: <haukeh@pc-kiel.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: haukeh@pc-kiel.de
Precedence: bulk
X-list: linux-mips

Am Donnerstag, 26. Mai 2005 21:39 schrieb Dan Malek:
> On May 26, 2005, at 9:20 AM, Hauke Goos-Habermann wrote:
> > Does anybody have an idea how to make the CCA4 mapping?
>
> In the mmap() entry for the driver:
>
> 	pgprot_val(vma->vm_page_prot) |= (4 << 9);	/* CCA4 */
This is what I tried earlier. It doesn't speed up the driver. Enabling the 
caching with setting the CMEM register doesn't help too.

> or, whatever is appropriate.  This will only work from a user
> application (like X-Windows) that mmaps() the driver, you
> aren't going to get a kernel mapped space this way without
> some special VM space hacking.
I think that's what I need. The normal framebuffer driver is very slow and I 
need a faster and direct access to the video memory.

That's why I tried to use the add_wired_entry function. There I can enable the 
CCA4 and make a wired entry. But this doesn't work either:

add_wired_entry((0x00800000 >> 2) | 0x0027, (0x00900000 >> 2) | 0x0027, 
0x30000000 | 0x0027, 0x01ffe000);
add_wired_entry((0x00a00000 >> 2) | 0x0027, (0x00a00000 >> 2) | 0x0027, 
0x32000000 | 0x0027, 0x01ffe000);

The graphic card is a FUJITSU MB86290. Does anybody have experiences with this 
device?

Does anybody have an idea how to make the access to the video memory faster?

> Thanks.
>
> 	-- Dan
Cu Hauke
