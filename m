Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 04:12:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43068 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1491783AbZJ2DMR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 04:12:17 +0100
Date:	Thu, 29 Oct 2009 03:12:17 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Robert Richter <robert.richter@amd.com>, chenj@lemote.com
Subject: Re: [PATCH -sfr.git] MIPS: zboot: indent the nop instruction in
 delay slot
In-Reply-To: <1256782252-2240-1-git-send-email-wuzhangjin@gmail.com>
Message-ID: <alpine.LFD.2.00.0910290306490.9323@eddie.linux-mips.org>
References: <1256782252-2240-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 29 Oct 2009, Wu Zhangjin wrote:

> diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
> index e23f25e..29080f4 100644
> --- a/arch/mips/boot/compressed/head.S
> +++ b/arch/mips/boot/compressed/head.S
> @@ -38,7 +38,7 @@ start:
>  	PTR_LA	ra, 2f
>  	PTR_LA	k0, decompress_kernel
>  	jr	k0
> -	nop
> +	 nop
>  2:
>  	move	a0, s0
>  	move	a1, s1
> @@ -46,7 +46,7 @@ start:
>  	move	a3, s3
>  	PTR_LI	k0, KERNEL_ENTRY
>  	jr	k0
> -	nop
> +	 nop
>  3:
>  	b 3b
>  	END(start)

 This piece of code looks unsafe to me.  I'm not sure which tree this is 
against and certainly I don't have a local copy of the file, but based on 
the manual delay slot scheduling this is built with .set noreorder in 
effect and as such the function lacks a delay slot fill for the trailing 
branch (which is also ill-formatted).

  Maciej
