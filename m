Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jul 2007 14:43:47 +0100 (BST)
Received: from terminus.zytor.com ([198.137.202.10]:22755 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20022775AbXG2Nnp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Jul 2007 14:43:45 +0100
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6TDhY1X021925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Jul 2007 06:43:36 -0700
Received: from titan.hos.anvin.org (hpa-laptop.hos.anvin.org [172.27.60.1])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6TDhTAV031149;
	Sun, 29 Jul 2007 06:43:33 -0700
Message-ID: <46AC997B.2030706@zytor.com>
Date:	Sun, 29 Jul 2007 06:43:23 -0700
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	maximilian attems <max@stro.at>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org, klibc@zytor.com
Subject: Re: [klibc] klibc kernelheaders build failure on mips/mipsel
References: <20070729095217.GE7448@stro.at>
In-Reply-To: <20070729095217.GE7448@stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.7/3804/Sat Jul 28 21:09:31 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

maximilian attems wrote:
>  switching to newer linux-libc-dev linux-2.6 provided kernel
>  headers worked fine beside on mips mipsel:
> 
>   In file included from usr/klibc/arch/mips/crt0.S:11:
>   usr/include/arch/mips/machine/asm.h:8:24: error: asm/regdef.h: No such
>   file or directory
>   usr/include/arch/mips/machine/asm.h:9:21: error: asm/asm.h: No such file
>   or directory
> 
>   i'm not sure if you want to export both headers in the make
>   kernelheaders target or if it is the fault of klibc to assume
>   that those are available?
> 

If I remember correctly (sorry, I'm on the road at the moment), those 
files should be exportable.  They wouldn't be all that hard to replicate 
in klibc, though.

	-hpa
