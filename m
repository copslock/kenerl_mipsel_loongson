Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Dec 2004 00:04:16 +0000 (GMT)
Received: from web201.biz.mail.re2.yahoo.com ([IPv6:::ffff:68.142.224.163]:54938
	"HELO web201.biz.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225230AbULaAEK>; Fri, 31 Dec 2004 00:04:10 +0000
Message-ID: <20041231000354.53760.qmail@web201.biz.mail.re2.yahoo.com>
Received: from [64.164.196.27] by web201.biz.mail.re2.yahoo.com via HTTP; Thu, 30 Dec 2004 16:03:54 PST
Date: Thu, 30 Dec 2004 16:03:54 -0800 (PST)
From: Peter Popov <ppopov@embeddedalley.com>
Subject: Re: Request for new machtype
To: =?ISO-8859-1?Q?"J=F8rg"?= Ulrich Hansen <jh@hansen-telecom.dk>,
	linux-mips@linux-mips.org
In-Reply-To: <000201c4ed88$efdc64b0$040ba8c0@ANNEMETTE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


I'll take care of it.

Pete

--- Jørg Ulrich Hansen <jh@hansen-telecom.dk> wrote:

> Hi
> 
> We are the manufacture of a cpu module based on ADMs
> Alchemy au1100 and
> would like a machtype as defined in bootinfo.h
> 
> I have included a patch that defines MACH_MB1100 as
> 9 but would like to
> have it confirm so we are not running into conflicts
> in the future.
> 
> Index: linux267/include/asm-mips/bootinfo.h
>
===================================================================
> RCS file:
> /home/cvs/linux/include/asm-mips/bootinfo.h,v
> retrieving revision 1.74
> diff -u -p -r1.74 bootinfo.h
> --- linux267/include/asm-mips/bootinfo.h	13 Apr 2004
> 22:07:45
> -0000	1.74
> +++ linux267/include/asm-mips/bootinfo.h	27 Nov 2004
> 16:20:31
> -0000
> @@ -174,6 +174,7 @@
>  #define  MACH_XXS1500		6       /* Au1500-based eval
> board */
>  #define  MACH_MTX1		7       /* 4G MTX-1
> Au1500-based board
> */
>  #define  MACH_PB1550		8       /* Au1550-based eval
> board */
> +#define  MACH_MB1100		9   /* Mechatronic Brick
> mb1100 module
> */
>  
>  /*
>   * Valid machtype for group NEC_VR41XX 
> 
> Kind regards Jorg Hansen
> 
> This is not advertising but more information about
> the module as well as
> crosstool based on buildroot and patches can be
> found at:
> http://www.mechatronicbrick.dk/uk/mb1100.html
> 
> 
>  
> 
> 
> 
