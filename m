Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 11:30:58 +0200 (CEST)
Received: from firewall.spacetec.no ([192.51.5.5]:46722 "EHLO
	pallas.spacetec.no") by linux-mips.org with ESMTP
	id <S1122958AbSIEJa5>; Thu, 5 Sep 2002 11:30:57 +0200
Received: (from tor@localhost)
	by pallas.spacetec.no (8.9.1a/8.9.1) id LAA30701;
	Thu, 5 Sep 2002 11:30:11 +0200
Message-Id: <200209050930.LAA30701@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Thu, 5 Sep 2002 11:30:11 +0200
In-Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
       "Re: 64-bit and N32 kernel interfaces" (Sep  5, 10:23)
X-Mailer: Mail User's Shell (7.2.6 beta(4) 03/19/98)
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>
Subject: Re: 64-bit and N32 kernel interfaces
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Return-Path: <tor@spacetec.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tor@spacetec.no
Precedence: bulk
X-list: linux-mips

On Sep 5, 10:23, "Maciej W. Rozycki" wrote:
>On Thu, 5 Sep 2002, Carsten Langgaard wrote:
[...]
>> Please notice, that a 'long' is 32-bit for n32, so we need to do the same
>> conversion for a lot of syscalls, as we already do for o32.
>
> Any reference?  AFAIK, long is 64-bit for n32 and only void * is 32-bit. 
>It doesn't make sense otherwise. 

On SGI/Irix n32 long and void* are 32-bit, only long long is 64-bit.
On SGI/Irix n64 long and void* are 64-bit too.

-Tor
