Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 18:04:46 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:28687
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225284AbVAKSEl>; Tue, 11 Jan 2005 18:04:41 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CoQNk-0006Ii-00; Tue, 11 Jan 2005 19:04:40 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CoQNk-0002fY-00; Tue, 11 Jan 2005 19:04:40 +0100
Date: Tue, 11 Jan 2005 19:04:40 +0100
To: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
Message-ID: <20050111180440.GB31149@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041224085645.GJ3539@rembrandt.csv.ica.uni-stuttgart.de> <20050107190605.GG31335@rembrandt.csv.ica.uni-stuttgart.de> <41E27A6A.5060204@schenk.isar.de> <20050110140429.GC15344@rembrandt.csv.ica.uni-stuttgart.de> <41E29DF5.6040800@schenk.isar.de> <20050110154246.GH15344@rembrandt.csv.ica.uni-stuttgart.de> <41E38A0A.1010507@schenk.isar.de> <41E394A0.30205@schenk.isar.de> <20050111162646.GA31149@rembrandt.csv.ica.uni-stuttgart.de> <41E40E8D.60600@schenk.isar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E40E8D.60600@schenk.isar.de>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:
[snip]
> >>Well, at least for a 32-bit kernel. If I compile a 64-bit
> >>kernel it still stops when it should start init. Any ideas?
> >
> >Is this really related to my TLB exception handler patch? The 64bit
> >versions of it are pretty well tested now, so it would be most likely
> >some flaw specific to your CPU. The 64bit kernel had no optimized TLB
> >handlers before.
> 
> Don't know. It's just that it worked before. But I might just
> have been lucky then. I just checked again and found that without
> SMP enabled 64 bit is working too. So the problem might indeed
> not be related to your patch.

The pte updates for SMP are tricky but the same for 32 and 64 bit.
The old 32bit SMP code simply ignored the race condition, the 64bit SMP
version had no optimization but called always do_fage_fault.

64bit SMP systems known to work so far are SGI IP27 and Broadcom SB1250.


Thiemo
