Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 16:50:32 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:48395
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225342AbUANQua>; Wed, 14 Jan 2004 16:50:30 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AgoDq-0005LN-00; Wed, 14 Jan 2004 17:50:26 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AgoDp-0007iI-00; Wed, 14 Jan 2004 17:50:25 +0100
Date: Wed, 14 Jan 2004 17:50:25 +0100
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Correct assembler/compiler options for 4KC core?
Message-ID: <20040114165025.GB22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <37A3C2F21006D611995100B0D0F9B73C04F11125@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73C04F11125@tnint11.telogy.design.ti.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Zajerko-McKee, Nick wrote:
> Hi,
> 
> I'm trying to use the following opcodes: movz, movn, clo, clz, madd, msub on
> both a 4KC and 4KeC core. What gas options should I use to get the above
> opcodes to work (mips4?  mips32?)

With a modern toolchain: -march=mips32.

> How would one link against closed source
> libraries that were compiled for mips2?

This will just work if you use a recent binutils version, and if the
libraries are O32 ABI conformant.

> Is there a list of what opcodes
> correspond to the various ISA's and gas flags?  The best reference I saw was
> from fsf that just mentions the -mips1/-mips2/-mips3/-mips4. I did notice
> in the latest gas docs -march option,

-mips32 is retained as an alias for -march=mips32.

> but I don't see that available in my
> toolchain.  I'm running on a development system with gas 2.9.5 and gcc 2.96.

gas 2.9.5 is _very_ old. It might be possible to use "-mips4 -mgp32" for
movn, movz, but I'm not sure if this actually works. For the other opcodes
the toolchain is just too old.


Thiemo
