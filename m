Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 20:27:32 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24786
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225073AbTE0T13>; Tue, 27 May 2003 20:27:29 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19Kk5w-001avu-00; Tue, 27 May 2003 21:26:48 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19Kk5s-0000yn-00; Tue, 27 May 2003 21:26:44 +0200
Date: Tue, 27 May 2003 21:26:44 +0200
To: Brad Barrett <brad@patton.com>
Cc: "'Linux-Mips@Linux-Mips. Org'" <linux-mips@linux-mips.org>
Subject: Re: "relocation truncated to fit"
Message-ID: <20030527192643.GH18653@rembrandt.csv.ica.uni-stuttgart.de>
Mail-Followup-To: ica2_ts, Brad Barrett <brad@patton.com>,
	"'Linux-Mips@Linux-Mips. Org'" <linux-mips@linux-mips.org>
References: <BBEBJGNKIDPPHNAJKDFHAECPCJAA.brad@patton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBEBJGNKIDPPHNAJKDFHAECPCJAA.brad@patton.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Brad Barrett wrote:
> Preface:
> --------
> I have a userspace toolchain issue.  I'm not sure where to post it, so I'll
> start here.

binutils@sources.redhat.com is probably the better place for this.

[snip]
> I built the cross-tools myself.  They are now about 6-8 months old.  They
> consist of:
> - gcc version 3.2.1 20020903 (prerelease)
> - GNU ld version 2.13.90.0.10 20021010  [from H.J. Lu]
> - glibc version 2.2.5

An upgrade is IMHO the best solution:
gcc 3.3 will fix some "branch out of range" issues, and binutils
newer than 2.13.90.0.18 implement multigot. Both together should
solve the problem.

> What I know:
> ------------
> Googling hasn't turn up much, with the exception of an intriguing exchange from
> Sept 2001  on this mailing list:

The GOT overflow problem is quite well known, it hits every largish
executable for O32 MIPS. Most notably Mozilla and parts of KDE were
affected, too.

> Petter Reinholdtsen reports similar messages when (native) compiling "a huge C++
> program" (actually Opera) on an Indy:
> http://www.spinics.net/lists/mips/msg04568.html
> 
> Wilbern Cobb suggests using -G4, -G2, or -G1, which Petter reports reduces the
> messages but does not eliminate them.

These reduce GOT usage at the expense of speed and size, so they
help a bit as workaround.

> Then Ryan Murray says that every static
> library used in the link, including libc_noshared.a and libgcc.a, must be
> compiled with -Wa,xgot.

Would also work, but is binary incompatible then.


Thiemo
