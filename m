Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 21:15:33 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:61411
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225221AbTEMUP3>; Tue, 13 May 2003 21:15:29 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 5A2CD2BC37
	for <linux-mips@linux-mips.org>; Tue, 13 May 2003 22:15:25 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 16299-06
 for <linux-mips@linux-mips.org>; Tue, 13 May 2003 22:15:24 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 6FE722BC35
	for <linux-mips@linux-mips.org>; Tue, 13 May 2003 22:15:24 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id D58631737F; Tue, 13 May 2003 22:11:44 +0200 (CEST)
Date: Tue, 13 May 2003 22:11:44 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513201144.GY3889@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 09:27:35PM +0200, Thiemo Seufer wrote:
> Guido Guenther wrote:
[..snip..] 
> > to make gcc-3.3 happy (note the 32 instead of o32).
> 
> Yes, IIRC 64 vs. n64 has the same problem.
I think 64 is o64 not n64.

> > gcc-3.2 doesn't seem
> > to handle these options correctly at all.
> 
> AFAICS you can still drop the -mtune part.
Yes, thanks for pointing this out. I'm just leaving this in the Makefile
to know what to change if I want to tune for another cpu.
 -- Guido
