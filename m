Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2003 16:22:02 +0100 (BST)
Received: from emma.patton.com ([IPv6:::ffff:209.49.110.2]:39184 "EHLO
	emma.patton.com") by linux-mips.org with ESMTP id <S8225236AbTE3PV6>;
	Fri, 30 May 2003 16:21:58 +0100
Received: from barrett ([209.49.110.172])
	by emma.patton.com (8.9.0/8.9.0) with SMTP id LAA24915;
	Fri, 30 May 2003 11:22:10 -0400 (EDT)
From: "Brad Barrett" <brad@patton.com>
To: "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "'Linux-Mips@Linux-Mips. Org'" <linux-mips@linux-mips.org>
Subject: RE: "relocation truncated to fit" -- SOLVED!
Date: Fri, 30 May 2003 11:21:53 -0400
Message-ID: <BBEBJGNKIDPPHNAJKDFHEEFDCJAA.brad@patton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <20030527192643.GH18653@rembrandt.csv.ica.uni-stuttgart.de>
Importance: Normal
Return-Path: <brad@patton.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@patton.com
Precedence: bulk
X-list: linux-mips

I wanted to make sure I reported back my results...

I updated only binutils to the latest version (2.14.90.0.4), cleaned the source
trees, and rebuilt with success.  This saved me much time that might have been
spent on the -GN or -Wa,xgot workarounds (which might not even have worked).

So thanks a lot Thiemo!

Brad

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Thiemo Seufer
Sent: Tuesday, May 27, 2003 3:27 PM
To: Brad Barrett
Cc: 'Linux-Mips@Linux-Mips. Org'
Subject: Re: "relocation truncated to fit"


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
> Googling hasn't turn up much, with the exception of an intriguing exchange
from
> Sept 2001  on this mailing list:

The GOT overflow problem is quite well known, it hits every largish
executable for O32 MIPS. Most notably Mozilla and parts of KDE were
affected, too.

> Petter Reinholdtsen reports similar messages when (native) compiling "a huge
C++
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
