Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 17:44:57 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:64463
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225203AbTCRRo5>; Tue, 18 Mar 2003 17:44:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 92D592BC30
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 18:44:54 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 23757-01
 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 18:44:53 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb543c.pool.mediaWays.net [217.187.84.60])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 8C9652BC2F
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 18:44:53 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 83B4E1735C; Tue, 18 Mar 2003 18:42:41 +0100 (CET)
Date: Tue, 18 Mar 2003 18:42:41 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030318174241.GG2613@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 18, 2003 at 05:03:03PM +0100, Thiemo Seufer wrote:
> Try
>    -mabi=o32 -march=r5000 -Wa,--trap
> This may fail if the compiler is very old, though.
> 
> > for IP22? -mips2 conflicts with -march=r5000 since this implies -mips4.
> 
> This was fixed in very recent gcc. -mips2 should be an alias for -march=r6000
> and -mips4 one for -march=r8000.
Is it correct that -mipsX in contrast to -march=rXXXX has the difference
of not only selecting a specific CPU instruction set but also an abi
(o32 or n64)? If so wouldn't it be cleaner to remove -mipsX altogether
and use -march=rXXXX and -mabi=o32, etc? The different meanings of these
options in different toolchain versions confuse me a lot. What is the
final intended usage of these options?
 -- Guido
