Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2002 18:30:49 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:38662 "EHLO
	hell") by linux-mips.org with ESMTP id <S1123253AbSJPQat>;
	Wed, 16 Oct 2002 18:30:49 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 181r4A-0006uy-00; Wed, 16 Oct 2002 18:30:38 +0200
Date: Wed, 16 Oct 2002 18:30:38 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Once again: test_and_set for CPUs w/o LL/SC
Message-ID: <20021016163038.GA26585@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
References: <20021015172108.GD21220@convergence.de> <Pine.GSO.3.96.1021016140828.14774I-100000@delta.ds2.pg.gda.pl> <20021016125233.GA25227@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016125233.GA25227@convergence.de>
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

I wrote:

> sysmips is history with current glibc since the Linux kernel emulates
> LL/SC for CPUs that don't have it. This emulation is actually faster than
> sysmips. (You'd think it's slower because it's one syscall vs. two
> emulated instructions. But with LL/SC glibc can use test-and-set
                                                      ^^^^^^^^^^^^
> which enables a more efficient linux-threads mutex implementation.)

Oops, I meant compare-and-swap.


Johannes
