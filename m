Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 10:34:27 +0100 (WEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:50290 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022162AbZFEJeV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2009 10:34:21 +0100
Received: from klappe2.localnet (blueice3n1.de.ibm.com [195.212.29.179])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MKv1o-1MCVoI3byS-000jBz; Fri, 05 Jun 2009 11:34:05 +0200
From:	Arnd Bergmann <arnd@arndb.de>
To:	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 4/6] headers_check fix: mips, ioctl.h
Date:	Fri, 5 Jun 2009 10:34:00 +0100
User-Agent: KMail/1.11.90 (Linux/2.6.30-5-generic; KDE/4.2.85; x86_64; ; )
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Jaswinder Singh Rajput <jaswinder@kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-mips" <linux-mips@linux-mips.org>,
	Michael Abbott <michael@araneidae.co.uk>
References: <1244118232.5172.26.camel@ht.satnam> <20090604124631.GB19459@linux-mips.org> <20090604200953.GA13892@uranus.ravnborg.org>
In-Reply-To: <20090604200953.GA13892@uranus.ravnborg.org>
X-Face:	I@=L^?./?$U,EK.)V[4*>`zSqm0>65YtkOe>TFD'!aw?7OVv#~5xd\s,[~w]-J!)|%=]>
 =?utf-8?q?+=0A=09=7EohchhkRGW=3F=7C6=5FqTmkd=5Ft=3FLZC=23Q-=60=2E=60Y=2Ea=5E?=
 =?utf-8?q?3zb?=)
 =?utf-8?q?+U-JVN=5DWT=25cw=23=5BYo0=267C=26bL12wWGlZi=0A=09=7EJ=3B=5Cwg?=
 =?utf-8?q?=3B3zRnz?=,J"CT_)=\H'1/{?SR7GDu?WIopm.HaBG=QYj"NZD_[zrM\Gip^U
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200906051034.01817.arnd@arndb.de>
X-Provags-ID: V01U2FsdGVkX1+NEhiUibnRTOiVbr40IKiyUfDaHvF+LpX6Y5V
 wqz9RmQbrj0OJg1o/ZY5E4rwW/niw7cJBl6oU0XKVmZgHvaJvU
 F5zMSj2VCacTiGKYHBAQQ==
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23294
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips

On Thursday 04 June 2009, Sam Ravnborg wrote:
> Any specific reason why mips does not use include/asm-generic/ioctl.h?
> Had mips done so this would not have been an issue.

The original include/asm-generic/ioctl.h did not allow overriding
the values of _IOC_{SIZEBITS,DIRBITS,NONE,READ,WRITE}, so it
was initially not possible to use it.

Nowadays, you can simply use the same approach as powerpc:

#ifndef _ASM_MIPS_IOCTL_H
#define _ASM_MIPS_IOCTL_H

#define _IOC_SIZEBITS	13
#define _IOC_DIRBITS	3

#define _IOC_NONE	1U
#define _IOC_READ	2U
#define _IOC_WRITE	4U

/*
 * The following are included for compatibility
 */
#define _IOC_VOID	0x20000000
#define _IOC_OUT	0x40000000
#define _IOC_IN		0x80000000
#define _IOC_INOUT	(IOC_IN|IOC_OUT)

#include <asm-generic/ioctl.h>

#endif	/* _ASM_MIPS_IOCTL_H */

This would indeed be a cleaner fix.

	Arnd <><
