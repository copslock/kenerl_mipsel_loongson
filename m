Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 14:06:46 +0000 (GMT)
Received: from mxout1.netvision.net.il ([IPv6:::ffff:194.90.9.20]:20975 "EHLO
	mxout1.netvision.net.il") by linux-mips.org with ESMTP
	id <S8226091AbTAIOG0>; Thu, 9 Jan 2003 14:06:26 +0000
Received: from mail.riverhead.com ([194.90.64.163]) by mxout1.netvision.net.il
 (iPlanet Messaging Server 5.2 HotFix 1.08 (built Dec  6 2002))
 with ESMTP id <0H8G0043N9UBNX@mxout1.netvision.net.il>; Thu,
 09 Jan 2003 16:06:14 +0200 (IST)
Received: from exchange.riverhead.com (exchange.wanwall.com [10.0.0.10])
	by mail.riverhead.com (8.11.0/8.11.0) with ESMTP id h09E6mY17412; Thu,
 09 Jan 2003 16:06:48 +0200
Date: Thu, 09 Jan 2003 16:01:03 +0200
From: Gilad Benjamini <gilad@riverhead.com>
Subject: RE: ksymoops and 64 bit mips
To: Ralf Baechle <ralf@linux-mips.org>,
	Gilad Benjamini <gilad@riverhead.com>
Cc: linux-mips@linux-mips.org
Message-id: <328392AA673C0A49B54DABA457E37DAA458D@exchange.riverhead.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4417.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-class: urn:content-classes:message
Thread-topic: ksymoops and 64 bit mips
Thread-index: AcK354pUgK49iMd+ShSpD+xdCoGTlA==
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host:
 mail.riverhead.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Return-Path: <gilad@riverhead.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@riverhead.com
Precedence: bulk
X-list: linux-mips

Au contraire.
System.map has 32 bit addresses, which I tried to sign extended 
with "ffffffff" (the wonders of sed), but that didn't help.

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org]
> Sent: Thursday, January 09, 2003 3:38 PM
> To: Gilad Benjamini
> Cc: linux-mips@linux-mips.org
> Subject: Re: ksymoops and 64 bit mips
> 
> 
> On Wed, Jan 08, 2003 at 10:15:19PM +0200, Gilad Benjamini wrote:
> 
> > Initially I got a lot of garbage.
> > Upgrdaing to ksymoops 2.4.5 , and using the --truncate=1 and 
> > -t elf32-little reduced 
> > the amount of garbage, but still all the output shown
> > was "No symbol available".
> > 
> > Any additional things I should do ?
> 
> Possibly your ksymoops is get confused by the System.map 
> file.  The vmlinux
> file is a 32-bit ELF file but the System.map file contains 
> the addresses
> sign-extended to 64-bit.  As a bandaid you can just chop off the high
> 32-bits of all addresses in System.map.
> 
>   Ralf
> 
