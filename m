Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 20:23:21 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:64274 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225769AbUFATXR>;
	Tue, 1 Jun 2004 20:23:17 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 1 Jun 2004 12:21:54 -0700
Message-ID: <40BCD754.9000803@avtrex.com>
Date: Tue, 01 Jun 2004 12:21:56 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: "Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org,
	debian-toolchain@lists.debian.org
Subject: Re: TLS register
References: <20040531230524.GB2785@bogon.ms20.nix> <20040601121520.GB25718@linux-mips.org> <047701c447d6$28aa9d60$10eca8c0@grendel> <Pine.LNX.4.55.0406011543020.29465@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0406011543020.29465@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2004 19:21:54.0036 (UTC) FILETIME=[B289B340:01C4480D]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>On Tue, 1 Jun 2004, Kevin D. Kissell wrote:
>
>  
>
>>>>Now that gcc 3.4 has incompatible ABI changes (on o32 mostly affecting
>>>>mipsel) I've been discussing with Thiemo if I'd be the right point to
>>>>take this ABI change as a possibility to additionally reserve a TLS
>>>>register. 
>>>>He suggested $24 (t8) another discussed possibility would be $27 (k1)
>>>>which is already abused by the PS/2 folks for ll/sc emulation.
>>>>Another possibility would be to reserve such a register only in the
>>>>n32/n64 ABIs and let o32 stay without __thread and TLS forever.
>>>>        
>>>>
>
> For Linux the n32/n64 ABIs can be considered being in the initial stage
>of deployment, so backwards compatibility is a non-issue.  Whatever is
>found to be the best solution may be accepted.  So the problem of defining
>a TLS pointer exists for the o32 ABI only and given the existence of
>MIPS32 ISA and its implementations ignoring the issue won't only affect
>ancient (but still alive) hardware.
>

There are MIPS32 ISA processors that are used in embedded devices that 
are far from "ancient" as some are only starting to enter the market, 
and are still in production.

For these types of devices it is not so important to maintain backwards 
compatibility with legacy tool chains and/or binary library code.  A new 
ABI very similar to o32 but with a TLS pointer in a register (perhaps 
"o32-tls") might be useful.
.
.
.

> The interesting factor is how much software really needs threading.  
>AFAIK, the majority does not -- I can count threaded software I know of 
>(but not necessarily use) using fingers of one hand.  That does not mean 
>there are no niches that make use of that approach extensively -- they 
>could see a benefit, but why to penalize the rest?
>
>  
>
Almost any non-trivial program written in java could benefit from faster 
TLS.  The java support in GCC-3.4 now allows us to write useful programs 
for MIPS in java.

David Daney.
