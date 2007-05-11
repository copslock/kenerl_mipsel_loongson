Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 08:19:26 +0100 (BST)
Received: from mail.cybits.de ([213.139.144.204]:48142 "EHLO mail.cybits.de")
	by ftp.linux-mips.org with ESMTP id S20022240AbXEKHTV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 08:19:21 +0100
Received: from localhost (unknown [127.0.0.1])
	by mail.cybits.de (Postfix) with ESMTP id 842542D6BB5;
	Fri, 11 May 2007 07:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cybits.de
Received: from mail.cybits.de ([127.0.0.1])
	by localhost (mail.cybits.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pn5QRPsWRkB; Fri, 11 May 2007 09:21:26 +0200 (CEST)
Received: from CYBIEX01.mz.ads.cybits.de (unknown [192.168.1.213])
	by mail.cybits.de (Postfix) with ESMTP id 46FAF2D6BB1;
	Fri, 11 May 2007 09:21:26 +0200 (CEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: AW: Building a cross kernel for the IP27/Origin System
Date:	Fri, 11 May 2007 09:19:14 +0200
Message-ID: <3713978C68303748B17B273D85768CD208E68C@CYBIEX01.mz.ads.cybits.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Building a cross kernel for the IP27/Origin System
Thread-Index: AceTNVCpeSWFNNVHTn+dBWOW8zxEogAZEynQ
References: <4640911A.4080801@cybits.de> <1178823635.2740.6.camel@localhost.localdomain>
From:	"Claus Herrmann" <che@cybits.de>
To:	"Jim Wilson" <wilson@specifix.com>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <che@cybits.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: che@cybits.de
Precedence: bulk
X-list: linux-mips

Hi Jim,

thanks for your response. To be honest, the Dwarf Error I ignored. I did nothing special in the configuration. I just selected the IP27 as Machine and off I went.
And there the first Problems occured. When oyu select the IP27 many options in the ConfigMenu have tob e taken by hand (is this normal?). The Pci Module is not selected (brings linker errors of course (cant find PCI_Probe..), the option for Multi CPU is not selected (same linkererror with "cant find CPU_IRQ or something like this).

I am at the point that I found every packet which the compilation needs and what he doesnt need. But the "multiple definitions"-Error I am at my end. For what it looks to me, it looks like there is a wrong architecture configurations file in the archive. First of all it doesnt make sense, when you select the arcitecture IP27, all required modules (Pci, MultiCpu...) have to be selected by hand. What it seems to me, the automated build scripts seem to compile the general "arch/mips" and the specific "arch/mips/ip27" thus creating the error.

Brgds

Claus




-----Ursprüngliche Nachricht-----
Von: Jim Wilson [mailto:wilson@specifix.com] 
Gesendet: Donnerstag, 10. Mai 2007 21:01
An: Claus Herrmann
Cc: linux-mips@linux-mips.org
Betreff: Re: Building a cross kernel for the IP27/Origin System

On Tue, 2007-05-08 at 17:02 +0200, Claus Herrmann wrote:
> mips-linux-ld: Dwarf Error: found dwarf version '0', this reader only handles version 2 information.

When GNU ld prints an error message, it first looks to see if you
compiled with debug info, and if you did, it tries to read and parse the
debug info so it can pretty-print the error message with source file and
source line number info.  This makes it easier to figure out where the
problem is.  Unfortunately, this code sometimes fails.  The linker must
modify the debug info during the linking process by applying
relocations.  If we try to read the debug info at the wrong time, we may
get an inconsistent view of it, and may fail to read it correctly.  The
code is fail soft, so this is harmless, except that you get annoying
messages that make no sense to you.  Newer GNU ld versions handle this
much better than older GNU ld versions.  I suspect this is what is
happening in your case.

Just edit out the annoying and useless dwarf error messages, and you get

> arch/mips/mm/built-in.o: In function `mem_init':
> : multiple definition of `mem_init'
> arch/mips/sgi-ip27/built-in.o:: first defined here
> arch/mips/mm/built-in.o: In function `paging_init':
> : multiple definition of `paging_init'
> arch/mips/sgi-ip27/built-in.o:: first defined here

which is your real problem.  Looks like a problem with your mips kernel
configuration.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
