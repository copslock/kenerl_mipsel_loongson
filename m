Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 23:27:14 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:19668
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225203AbTCRX1N>; Tue, 18 Mar 2003 23:27:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id CBDB62BC30; Wed, 19 Mar 2003 00:27:08 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 25323-05;
 Wed, 19 Mar 2003 00:27:08 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb543c.pool.mediaWays.net [217.187.84.60])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id CD8B22BC2F; Wed, 19 Mar 2003 00:27:07 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 732071735C; Wed, 19 Mar 2003 00:24:54 +0100 (CET)
Date: Wed, 19 Mar 2003 00:24:54 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030318232454.GA19990@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

Hi Thiemo,
thanks a lot for the explanations!

On Tue, Mar 18, 2003 at 08:08:41PM +0100, Thiemo Seufer wrote:
> This would be nice, but older compilers don't have -march/-mtune.
> IIRC gcc 3.0.X is the first one to employ these. Similiar for -mabi.
I don't care about old compilers at the moment ;)

[..snip..] 
> -mabi=FOO: 
> Produce, hosted on a multi ABI system, a userland binary with the lowest
> possible ISA for the selected ABI.
> 
> Then there are optimizations for different CPUs.
> 
> -march=BAR:
> Allow opcodes for CPU BAR in addition to the ISA ones.
> 
> -mtune=BAZ:
> Optimize opcode scheduling for CPU BAZ.
So to build kernels for say IP22 R5k I'd change the current
	GCCFLAGS += -mcpu=r5000 -mips2 -Wa,--trap
to 
	GCCFLAGS += -mabi=o32 -march=R5000 -mtune=R5000 -Wa,--trap
where as for R4X00 I use
	GCCFLAGS += -mabi=o32 -march=R4600 -mtune=R4600 -Wa,--trap
Correct?
 -- Guido
