Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 14:20:25 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:34007 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122978AbSJPMUZ>; Wed, 16 Oct 2002 14:20:25 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA19086;
	Wed, 16 Oct 2002 14:20:42 +0200 (MET DST)
Date: Wed, 16 Oct 2002 14:20:42 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Johannes Stezenbach <js@convergence.de>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
In-Reply-To: <20021015172108.GD21220@convergence.de>
Message-ID: <Pine.GSO.3.96.1021016140828.14774I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 15 Oct 2002, Johannes Stezenbach wrote:

> The ability to choose the implementation at run time sacrifices
> inlining, but has obvious performance benefits for the VR41XX-like
> platforms. It's also not a special MIPS thing,
> e.g. linuxthreads/sysdeps/<platform>/pt-machine.h has the
> HAS_COMPARE_AND_SWAP / TEST_FOR_COMPARE_AND_SWAP hooks,
> used by e.g. i386.

 It also introduces an indirect call (jump?) overhead.  Anyway, you don't
need to sacrifice anything.  We may simply assume the universally
compatible way is the R3k one (be it sysmips() or whatever, if it gets
replaced).  Then there is the branch-likely way, which requires
branch-likely support (thus excludes R3k-class processors).  Then there is
the ll/sc way, which requires ll/sc (thus excludes R3k-class processors
and ones that lack the ll/sc instructions).  And you select the minimum
set of features required at the build time. 

> But all that is of interest only, if VR41XX-like platforms
> would use a glibc from a binary distribution like RedHat or
> Debian (I use Debian for development, but have a custom
> compiled glibc for production use).

 I wouldn't care of distributions -- if one really needs optimized
binaries it may make them be build somehow (either by doing the task
oneself or by convincing someone else).

> Yes, the kernel changes are not difficult. The difficulty was
> to find out the minimal necessary changes.

 You need to spot all kernel exit points.  Until we have R6k support it
means "eret" instructions. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
