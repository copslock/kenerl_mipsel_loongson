Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g140Til20174
	for linux-mips-outgoing; Sun, 3 Feb 2002 16:29:44 -0800
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g140TXA20000
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 16:29:33 -0800
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Sun, 03 Feb 2002 15:29:13 -0800
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.2/8.12.2) with ESMTP id
 g13NTSKf006263; Sun, 3 Feb 2002 15:29:28 -0800 (PST)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id PAA19089; Sun, 3 Feb 2002 15:29:28 -0800 (PST)
To: hjl@lucon.org
cc: "Justin Carlson" <justinca@ri.cmu.edu>,
   "Daniel Jacobowitz" <dan@debian.org>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Hiroyuki Machida" <machida@sm.sony.co.jp>, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com, gcc@gcc.gnu.org
Subject: Re: PATCH: Fix ll/sc for mips (take 3)
References: <20020131231714.E32690@lucon.org>
 <Pine.GSO.3.96.1020201124328.26449A-100000@delta.ds2.pg.gda.pl>
 <20020201102943.A11146@lucon.org>
 <20020201180126.A23740@nevyn.them.org>
 <20020201151513.A15913@lucon.org>
 <20020201222657.A13339@nevyn.them.org>
 <1012676003.1563.6.camel@xyzzy.stargate.net>
 <20020202120354.A1522@lucon.org> <mailpost.1012680250.7159@news-sj1-1>
From: cgd@broadcom.com
Date: 03 Feb 2002 15:29:28 -0800
In-Reply-To: hjl@lucon.org's message of
 "Sat, 2 Feb 2002 20:04:10 +0000 (UTC)"
Message-ID: <yov5ofj65elj.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 104318431312682-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[ Hi Justin, enjoying winter in pgh?  8-]

At Sat, 2 Feb 2002 20:04:10 +0000 (UTC), "H . J . Lu" wrote:
> Does everyone agree with this? If yes, I can make a patch not to use
> branch likely. But on the other hand, "gcc -mips2" will generate code
> using branch likely. If branch likely doesn't buy you anything, 
> shouldn't we change gcc not to generate branch likely instructions?

Branch-likely instructions probably _do_ buy you something (at least,
slightly less code size) on some CPUs, probably even some CPUs which
are still being produced.

FYI, somebody, i think it was Mike Stump, submitted a patch to add a
flag to disable branch-likely instructions N months ago.  It was
discussed a little bit, not AFAIK nothing was ever done with it.


To quote the MIPS32 instruction set document from the MIPS web site:

> Programming Notes:
> 
> [ ... ]
>
> Software is strongly encouraged to avoid the use of the Branch
> Likely instructions, as they will be removed from a future revision
> of the MIPS Architecture.
>
> Some implementations always predict the branch will be taken, so
> there is a significant penalty if the branch is not taken. Software
> should only use this instruction when there is a very high
> probability (98% or more) that the branch will be taken. If the
> branch is not likely to be taken or if the probability of a taken
> branch is unknown, software is encouraged to use the BGEZAL
> instruction instead.

If you have a sufficiently high static likelyhood of branch-taken, it
may well be worthwhile to use branch-likely even on MIPS32/MIPS64 if
it'll save you code space, or if you can determine that not clogging
up your branch history / predictor buffers makes your code run
faster.  However, it should definitely not be the default.



Anyway, from where I sit, this should be resolved like:

* -mips1 - -mips5 should generate them by default (for
  strongly-predicted branches), -mips32 & -mips64 should not.  (modify
  that for your favorite flag names, -march or whatever.  8-)

* There should be flags to override the defaults either way, so you
  could say -mips2 -mno-branch-likely, or -mips32 -mbranch-likely.


cgd
