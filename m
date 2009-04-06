Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 15:21:48 +0100 (BST)
Received: from skerikoff.satca.net ([81.90.243.194]:37559 "EHLO smtp.satca.net")
	by ftp.linux-mips.org with ESMTP id S20024561AbZDFOVe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 15:21:34 +0100
Received: from localhost (unknown [127.0.0.1])
	by smtp.satca.net (Postfix) with ESMTP id 953D815902D;
	Mon,  6 Apr 2009 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at satca.net
Received: from smtp.satca.net ([127.0.0.1])
	by localhost (skerikoff.satca.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuhXqs1XL9O2; Mon,  6 Apr 2009 16:21:15 +0200 (CEST)
Received: from [192.168.51.254] (unknown [192.168.51.254])
	by smtp.satca.net (Postfix) with ESMTP id C038E15902C;
	Mon,  6 Apr 2009 14:21:15 +0000 (UTC)
Message-ID: <49DA0FE3.1070400@satca.net>
Date:	Mon, 06 Apr 2009 16:21:23 +0200
From:	Marian Jancar <m.jancar@satca.net>
User-Agent: Thunderbird 2.0.0.12 (X11/20071114)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: gcc: mips32 vs mips3
References: <49B1556E.3030903@satca.net> <20090309193902.GA993@linux-mips.org>
In-Reply-To: <20090309193902.GA993@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <m.jancar@satca.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.jancar@satca.net
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Mar 06, 2009 at 05:55:10PM +0100, Marian Jancar wrote:
> 
>> which option is supposed to compile faster code, -mips3 or -mips32?
> 
> That question doesn't quite make sense.   A MIPS32 processor can't execute
> MIPS III code and a MIPS III processor can't execute MIPS32 code.  Only a
> MIPS64 processor could execute code compiled for either MIPS32 or MIPS III.
> So choose the option to match the architecture of your processor.

The processor in question is the processos in the Atheros 802.11 SoC 
AR5312, 4Kc AFAIK.
OpenWRT uses -mips32 for this target but the GPL SDK for NanoStation
uses -march=r4600. Both options produce code that runs without oops
or any other immediately manifested issues.
So you are right, the correct question is "-mips32 vs -march=r4600".
I got confused because I left some bits compiled with -march=4600 when
recompiling with -mips32 and gcc complained about it being compiled
for MIPS III when linking.

Marian

# cat /proc/cpuinfo
system type             : Atheros AR2313
processor               : 0
cpu model               : MIPS 4Kc V0.10
BogoMIPS                : 179.40
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 16
extra interrupt vector  : yes
hardware watchpoint     : yes
ASEs implemented        :
VCED exceptions         : not available
VCEI exceptions         : not available
