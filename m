Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2009 14:33:29 +0200 (CEST)
Received: from chipmunk.wormnet.eu ([195.195.131.226]:52288 "EHLO
	chipmunk.wormnet.eu" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492559AbZIZMdV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2009 14:33:21 +0200
Received: by chipmunk.wormnet.eu (Postfix, from userid 1000)
	id 356108063D; Sat, 26 Sep 2009 13:33:20 +0100 (BST)
Date:	Sat, 26 Sep 2009 13:33:20 +0100
From:	Alexander Clouter <alex@digriz.org.uk>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -v1] MIPS: add support for gzip/bzip2/lzma compressed
	kernel images
Message-ID: <20090926123320.GJ6085@chipmunk>
References: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1249894154-10982-1-git-send-email-wuzhangjin@gmail.com>
Organization: diGriz
X-URL:	http://www.digriz.org.uk/
X-JabberID: alex@digriz.org.uk
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <alex@digriz.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Hi,

* Wu Zhangjin <wuzhangjin@gmail.com> [2009-08-10 16:49:14+0800]:
>
> This patch will help to generate smaller kernel images for linux-MIPS,
> 
> Here is the effect when using lzma:
> 
> $ ls -sh vmlinux
> 7.1M vmlinux
> $ ls -sh arch/mips/boot/compressed/vmlinuz
> 1.5M arch/mips/boot/compressed/vmlinuz
> 
> Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
> Mini PC. both of them work well.
> 
> and this revision incorporates the feedback from Alexander Clouter
> <alex@digriz.org.uk>, he helped to test it on AR7[1] based Linksys
> WAG54Gv2 and gave good suggestion on board-independence.
> 
> NOTE: this should work for the other MIPS-based machines, but I have
> used the command bc in the Makefile to calculate the load address of the
> compressed kernel. I'm not sure this is suitable.  perhaps I need to
> rewrite this part in C program or somebody help to simplify the current
> implementation.
> 
Finally Fleabay'ed a replacement WAG54Gv2 to replace the one I 
bricked to try this new patch.

Works perfectly....I finally can cooked more or less vanilla kernels on 
my board now :)

> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
>
Tested-by: Alexander Clouter <alex@digriz.org.uk>

Cheers

-- 
Alexander Clouter
.sigmonster says: My computer can beat up your computer.
                  		-- Karl Lehenbauer
