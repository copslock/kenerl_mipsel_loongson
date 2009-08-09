Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2009 00:08:27 +0200 (CEST)
Received: from main.gmane.org ([80.91.229.2]:53705 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493204AbZHIWIV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 10 Aug 2009 00:08:21 +0200
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MaGYq-0001fd-6Z
	for linux-mips@linux-mips.org; Sun, 09 Aug 2009 22:08:16 +0000
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 09 Aug 2009 22:08:16 +0000
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 09 Aug 2009 22:08:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH] MIPS: add support for gzip/bzip2/lzma compressed kernel images
Date:	Sun, 9 Aug 2009 22:36:46 +0100
Message-ID:  <e4s3l6-dou.ln1@chipmunk.wormnet.eu>
References:  <1249757707-8876-1-git-send-email-wuzhangjin@gmail.com>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> wrote:
>
> This patch will help to generate smaller kernel images for linux-MIPS,
> 
/me gets giddy and wets himself with excitement

This has made my AR7[1] based Linksys WAG54Gv2 (16MB RAM and 4MB flash, 
limited to a 768kB kernel) useful, finally...thanks!

> $ wc -c vmlinux
> 7465416 vmlinux
> $ wc -c vmlinuz
> 2059691 vmlinuz
> 
> Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
> Mini PC. both of them works well.
> 
I got it working (LZMA kernel) however you have hardcoded a lot of bits 
in there.  It looks to my uneducated eye most of the issues lie in that 
getting a suitable PORT(x), KERNEL_START, KERNEL_SIZE, FREE_MEM_START 
and FREE_MEM_END is non-trivial on the MIPS platform currently; 
probably because of the lack of a generic lzma/gzip/bzip2 framework to 
be used with.

For me I used:
  #define FREE_MEM_START CKSEG0ADDR(0x94a00000)
  #define FREE_MEM_END CKSEG0ADDR(0x94f00000)

I had to replace (you probably should move this from dbg.c to dbg.h):
  #define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))

The load address is awkward, but I replaced your 0x8100000 in the 
Makefile with 0x94400000.

Now, the big question is how to work this all out at compile time. :)

As a side note, I would personally leave the DEBUG non-optional and 
turned on as it all disappears at runtime anyway, but I'm no kernel 
developer :)

Again, thanks for this, it truely is great stuff.

Cheers

[1] http://www.linux-mips.org/wiki/AR7

-- 
Alexander Clouter
.sigmonster says: I will always love the false image I had of you.
