Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 17:13:45 +0000 (GMT)
Received: from amsfep12-int.chello.nl ([IPv6:::ffff:213.46.243.17]:47656 "EHLO
	amsfep12-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225275AbVBHRNZ>; Tue, 8 Feb 2005 17:13:25 +0000
Received: from [127.0.0.1] (really [62.195.248.222])
          by amsfep12-int.chello.nl
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050208171318.JKET21348.amsfep12-int.chello.nl@[127.0.0.1]>;
          Tue, 8 Feb 2005 18:13:18 +0100
Message-ID: <4208F347.4050304@amsat.org>
Date:	Tue, 08 Feb 2005 18:13:43 +0100
From:	Jeroen Vreeken <pe1rxq@amsat.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	=?ISO-8859-2?Q?Tom_Vr=E1na?= <tom@voda.cz>,
	linux-mips@linux-mips.org
Subject: Re: ADM5120: time.c issues ?
References: <4207C71F.7050204@voda.cz>
In-Reply-To: <4207C71F.7050204@voda.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <pe1rxq@amsat.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pe1rxq@amsat.org
Precedence: bulk
X-list: linux-mips

Tom Vrána wrote:

> Using jeroens time.c the system boots painfully slow, sort of loops 
> int the beginning and the finally freezes on the FPU emulator... any 
> suggestions ?
>
The 2.6.10 kernels I compiled don't seem slow to me.. So there is some 
difference between those two... (Is there a reason you need a 2.4 kernel 
instead of 2.6?)

>
> ttyS28 at 0x03f8 (irq = 4) is a 16450
> ttyS29 at 0x02f8 (irq = 3) is a 16450
> ttyS30 at 0x03e8 (irq = 4) is a 16450

This might have something to do with it... I don't think this serial 
driver should be used. There might be more unneeded stuff in your kernel 
that might do funny things.

Jeroen
