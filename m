Received:  by oss.sgi.com id <S554217AbRBBDua>;
	Thu, 1 Feb 2001 19:50:30 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:48451 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S554214AbRBBDuC>; Thu, 1 Feb 2001 19:50:02 -0800
Received: from sydney.sydney.sgi.com (sydney.sydney.sgi.com [134.14.48.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id TAA02423
	for <linux-mips@oss.sgi.com>; Thu, 1 Feb 2001 19:59:09 -0800 (PST)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id OAA03192; Fri, 2 Feb 2001 14:49:19 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Jim Freeman <jfree@sovereign.org>
cc:     linux-mips@oss.sgi.com
Subject: Re: mystery files in stock->mips diff 
In-reply-to: Your message of "Thu, 01 Feb 2001 20:21:29 PDT."
             <20010201202129.A1107@sovereign.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 02 Feb 2001 14:48:39 +1100
Message-ID: <3672.981085719@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 1 Feb 2001 20:21:29 -0700, 
Jim Freeman <jfree@sovereign.org> wrote:
>The following files are in the mips tree, and not in stock 2.4.1
>- but they seem not to be mips-related.  Clues?

	arch/ppc/coffboot/main.c		del in 2.4.1-pre9
	arch/ppc/configs/gemini_defconfig	del in 2.4.1-pre9
	arch/ppc/kernel/gemini_pci.c		del in 2.4.1-pre9
	arch/ppc/kernel/gemini_prom.S		del in 2.4.1-pre9
	arch/ppc/kernel/gemini_setup.c		del in 2.4.1-pre9
	arch/ppc/mbxboot/vmlinux.lds		del in 2.4.1-pre9

	drivers/acpi/hardware/hwcpu32.c		del in 2.4.1-pre11
	drivers/acpi/hardware/hwxface.c		del in 2.4.1-pre11
	drivers/acpi/ksyms.c			del in 2.4.1-pre9

	include/asm-ppc/gemini.h		del in 2.4.1-pre9
	include/asm-ppc/gemini_serial.h		del in 2.4.1-pre9

All recently deleted from 2.4.x.
