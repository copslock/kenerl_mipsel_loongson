Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 12:37:20 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:41695
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225204AbTEMLhQ>; Tue, 13 May 2003 12:37:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id F091B2BC36; Tue, 13 May 2003 13:37:08 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 13361-09;
 Tue, 13 May 2003 13:37:02 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 7713C2BC35; Tue, 13 May 2003 13:36:57 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id EA5A81737F; Tue, 13 May 2003 13:33:16 +0200 (CEST)
Date: Tue, 13 May 2003 13:33:16 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513113316.GU3889@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 19, 2003 at 01:16:52AM +0100, Thiemo Seufer wrote:
> Guido Guenther wrote:
> [snip]
> > > -march=BAR:
> > > Allow opcodes for CPU BAR in addition to the ISA ones.
> > > 
> > > -mtune=BAZ:
> > > Optimize opcode scheduling for CPU BAZ.
> > So to build kernels for say IP22 R5k I'd change the current
> > 	GCCFLAGS += -mcpu=r5000 -mips2 -Wa,--trap
> > to 
> > 	GCCFLAGS += -mabi=o32 -march=R5000 -mtune=R5000 -Wa,--trap
> > where as for R4X00 I use
> > 	GCCFLAGS += -mabi=o32 -march=R4600 -mtune=R4600 -Wa,--trap
> > Correct?
> 
> Yes, this should work. You can leave the -mtune out, since it defaults
> to the value of -march anyway.
Just for completeness: I had to use:
	GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
to make gcc-3.3 happy (note the 32 instead of o32). gcc-3.2 doesn't seem
to handle these options correctly at all.
 -- Guido
