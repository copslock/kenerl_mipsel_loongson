Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 10:23:09 +0100 (BST)
Received: from firewall.spacetec.no ([IPv6:::ffff:192.51.5.5]:27611 "EHLO
	pallas.spacetec.no") by linux-mips.org with ESMTP
	id <S8225274AbTFEJXH>; Thu, 5 Jun 2003 10:23:07 +0100
Received: from pallas.spacetec.no (localhost [127.0.0.1])
	by pallas.spacetec.no (8.12.3/8.12.3) with ESMTP id h559N4QA009224
	for <linux-mips@linux-mips.org>; Thu, 5 Jun 2003 11:23:04 +0200
Received: (from tor@localhost)
	by pallas.spacetec.no (8.12.3/8.12.3/Debian-6.3) id h559N3dE009222
	for linux-mips@linux-mips.org; Thu, 5 Jun 2003 11:23:03 +0200
Message-Id: <200306050923.h559N3dE009222@pallas.spacetec.no>
From: tor@spacetec.no (Tor Arntsen)
Date: Thu, 5 Jun 2003 11:23:02 +0200
In-Reply-To: Ralf Baechle <ralf@linux-mips.org>
       "Re: [RFC] synchronized CPU count registers on SMP machines" (Jun  5,  0:27)
X-Mailer: Mail User's Shell (7.2.6 beta(4) 03/19/98)
To: linux-mips@linux-mips.org
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Return-Path: <tor@spacetec.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tor@spacetec.no
Precedence: bulk
X-list: linux-mips

On Jun 5,  0:27, Ralf Baechle wrote:
>On Wed, Jun 04, 2003 at 03:39:30PM -0700, Jun Sun wrote:
>
>> 1) clocks on different CPUs don't have the same frequency
>> 2) clocks on different CPUs drift to each other
>> 2) some fancy power saving feature such as frequency scaling
>> 
>> But I think for a foreseeable future most MIPS SMP machines
>> don't have the above issues (true?).  And it is probably worthwile
>> to synchronize count registers for them.
>
>1) and 2) affect most SGI systems.
>
>  Ralf

1) sometimes to the extreme, on SGI Challenge systems:
 
>hinv -c processor
Processor 0: 150 MHZ IP19 
CPU: MIPS R4400 Processor Chip Revision: 5.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
Processor 1: 150 MHZ IP19 
CPU: MIPS R4400 Processor Chip Revision: 5.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
Processor 2: 200 MHZ IP19 
CPU: MIPS R4400 Processor Chip Revision: 6.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
Processor 3: 200 MHZ IP19 
CPU: MIPS R4400 Processor Chip Revision: 6.0
FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0

(and the secondary cache sizes are 1MB and 4MB respectively as well)

-Tor
