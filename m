Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jul 2005 16:31:01 +0100 (BST)
Received: from [IPv6:::ffff:213.189.19.80] ([IPv6:::ffff:213.189.19.80]:21511
	"EHLO mail.kpsws.com") by linux-mips.org with ESMTP
	id <S8225539AbVG0Pal>; Wed, 27 Jul 2005 16:30:41 +0100
Received: (qmail 27051 invoked by uid 89); 27 Jul 2005 15:33:06 -0000
Received: from unknown (HELO mail.kpsws.com) (127.0.0.1)
  by localhost with SMTP; 27 Jul 2005 15:33:06 -0000
Received: from 194.171.252.100
        (SquirrelMail authenticated user pulsar@kpsws.com)
        by mail.kpsws.com with HTTP;
        Wed, 27 Jul 2005 17:33:06 +0200 (CEST)
Message-ID: <57480.194.171.252.100.1122478386.squirrel@mail.kpsws.com>
In-Reply-To: <20050725213607Z8225534-3678+4335@linux-mips.org>
References: <20050725213607Z8225534-3678+4335@linux-mips.org>
Date:	Wed, 27 Jul 2005 17:33:06 +0200 (CEST)
Subject: Re: CVS Update@linux-mips.org: linux
From:	"Niels Sterrenburg" <pulsar@kpsws.com>
To:	linux-mips@linux-mips.org
Reply-To: pulsar@kpsws.com
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Return-Path: <pulsar@kpsws.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pulsar@kpsws.com
Precedence: bulk
X-list: linux-mips

Hi Ralf and or others,

Do you detect and fix these trailing whitespaces with a script ?
If so can you tell me where I can find it (or send it)?

Thanks in advance,

Niels Sterrenburg

>
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	05/07/25 22:36:00
>
> Modified files:
> 	include/asm-mips/mach-generic: kernel-entry-init.h
> 	include/asm-mips/mach-ip27: kernel-entry-init.h
> 	include/asm-mips/mach-pnx8550: glb.h kernel-entry-init.h nand.h
> 	                               pci.h usb.h
> 	arch/mips/au1000/common: irq.c
> 	arch/mips/pci  : ops-pnx8550.c
> 	arch/mips/philips/pnx8550/common: gdb_hook.c int.c pci.c proc.c
> 	                                  prom.c setup.c
> 	arch/mips/philips/pnx8550/jbs: board_setup.c init.c
>
> Log message:
> 	Fixup the trailing whitespace mess.
>
>
>
