Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 14:52:49 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:15878 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122978AbSJPMwt>;
	Wed, 16 Oct 2002 14:52:49 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181nf7-0006Zh-00; Wed, 16 Oct 2002 14:52:33 +0200
Date: Wed, 16 Oct 2002 14:52:33 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021016125233.GA25227@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021015172108.GD21220@convergence.de> <Pine.GSO.3.96.1021016140828.14774I-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021016140828.14774I-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 16, 2002 at 02:20:42PM +0200, Maciej W. Rozycki wrote:
> 
>  It also introduces an indirect call (jump?) overhead.  Anyway, you don't
> need to sacrifice anything.  We may simply assume the universally
> compatible way is the R3k one (be it sysmips() or whatever, if it gets
> replaced).  Then there is the branch-likely way, which requires
> branch-likely support (thus excludes R3k-class processors).  Then there is
> the ll/sc way, which requires ll/sc (thus excludes R3k-class processors
> and ones that lack the ll/sc instructions).  And you select the minimum
> set of features required at the build time. 

sysmips is history with current glibc since the Linux kernel emulates
LL/SC for CPUs that don't have it. This emulation is actually faster than
sysmips. (You'd think it's slower because it's one syscall vs. two
emulated instructions. But with LL/SC glibc can use test-and-set
which enables a more efficient linux-threads mutex implementation.)

AFAIK, current Linux distributions based on glibc-2.2.5 were built for
R3K be default and thus used sysmips even on platforms which have
LL/SC.

> > But all that is of interest only, if VR41XX-like platforms
> > would use a glibc from a binary distribution like RedHat or
> > Debian (I use Debian for development, but have a custom
> > compiled glibc for production use).
> 
>  I wouldn't care of distributions -- if one really needs optimized
> binaries it may make them be build somehow (either by doing the task
> oneself or by convincing someone else).

OK, that simplifies the issue. I will prepare a patches for
Linux and glibc.


Regards,
Johannes
