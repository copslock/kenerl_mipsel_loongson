Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 09:44:03 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:474
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225228AbUJTIn6>; Wed, 20 Oct 2004 09:43:58 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP id D165C134034
	for <linux-mips@linux-mips.org>; Wed, 20 Oct 2004 10:42:55 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP id CEAF9134032
	for <linux-mips@linux-mips.org>; Wed, 20 Oct 2004 10:42:55 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPMMDC; Wed, 20 Oct 2004 10:43:31 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: linux-mips@linux-mips.org
Subject: Re: ioremap() and CONFIG_SWAP_IO_SPACE
Date: Wed, 20 Oct 2004 10:47:29 +0200
User-Agent: KMail/1.6.2
References: <200408251130.53865.thomas.koeller@baslerweb.com> <200410191245.59878.thomas.koeller@baslerweb.com> <20041019183105.GB9379@linux-mips.org>
In-Reply-To: <20041019183105.GB9379@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201047.30128.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

On Tuesday 19 October 2004 20:31, Ralf Baechle wrote:
>
> If the standard readX() / writeX() functions don't suffice for some reason
> then a bus specific versions in a separate header file are needed.
>

So I guess I will have to create something like ocd_readl()/ocd_writel().

> An example are the ISA versions.  For compatibility with super old
> versions from before ioremap or where things on i386 at least seemed to
> work without ioremap a special isa_readX() / isa_writeX() is supplied.
> Again for compatibility reasons these macros are defined in <asm/io.h>,
> not in a separate header file.
>

Much confusion could be avoided, then, if readX()/writeX() were name
pci_readX()/pci_writeX(), and, of course, CONFIG_SWAP_IO_SPACE were
named CONFIG_SWAP_PCI_SPACE.

Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
