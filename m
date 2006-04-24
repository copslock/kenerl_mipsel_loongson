Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2006 09:32:54 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:65182 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133516AbWDXIcp
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 24 Apr 2006 09:32:45 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k3O8jfPl002911;
	Mon, 24 Apr 2006 01:45:42 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k3O8jeET008993;
	Mon, 24 Apr 2006 01:45:40 -0700 (PDT)
Received: from wapping.mips-uk.com ([172.20.192.98])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FXwhL-0006X0-00; Mon, 24 Apr 2006 09:45:35 +0100
Message-ID: <444C902F.2050402@mips.com>
Date:	Mon, 24 Apr 2006 09:45:35 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: "relocation truncated to fit: R_MIPS_CALL16"
References: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
In-Reply-To: <50c9a2250604222002x37b949fbi585ed5fb31087d5@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



zhuzhenhua wrote:
> i want to write a mini bootloader for my board, so i need jump to c
> code from asm code
> but when i compile and ld, i get "relocation truncated to fit:
> R_MIPS_CALL16" messages for every function call..
> i have try the mips_4KCle-gcc(worked for u-boot),
> mips_fp_le-gcc(worked for mvita linux), and also a
> mipsel-linux-gcc(worked for my linux 2.6 kernel), but they all failed,
> even i add -G0 to gcc.
> and i only compile success by using mips-elf-gcc under cygwin.
> does it be caused by binutils version? or gcc compile CFLAGS?
> thanks for any hints
>   

This is probably because the mips-linux configuration of gcc is 
generating position-independent code by default, whereas the mips-elf 
version doesn't.

Try adding the options "-mno-abicalls -fno-pic" to your mips-liinux-gcc 
options.

HTH

Nigel
