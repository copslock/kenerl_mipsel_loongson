Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 16:03:07 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50109
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225203AbTCRQDG>; Tue, 18 Mar 2003 16:03:06 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18vJYO-001y95-00; Tue, 18 Mar 2003 17:03:04 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18vJYN-0003EG-00; Tue, 18 Mar 2003 17:03:03 +0100
Date: Tue, 18 Mar 2003 17:03:03 +0100
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030318154155.GF2613@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030318154155.GF2613@bogon.ms20.nix>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
> Hi,
> it seems newer binutils doen't know about -mcpu anymore. Is it correct
> to simply change:
>  -mcpu=r5000 -mips2 -Wa,--trap
> to
>  -mtune=r5000 -mips2 -Wa,--trap

On newer toolchains this will select r6000 opcodes with r5000 scheduling.

Try
   -mabi=o32 -march=r5000 -Wa,--trap
This may fail if the compiler is very old, though.

> for IP22? -mips2 conflicts with -march=r5000 since this implies -mips4.

This was fixed in very recent gcc. -mips2 should be an alias for -march=r6000
and -mips4 one for -march=r8000.


Thiemo
