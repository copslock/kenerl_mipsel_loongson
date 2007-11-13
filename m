Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 11:49:36 +0000 (GMT)
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:28796 "EHLO
	mtaout02-winn.ispmail.ntl.com") by ftp.linux-mips.org with ESMTP
	id S20026039AbXKMLt1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 11:49:27 +0000
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20071113114904.NWUS25022.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Tue, 13 Nov 2007 11:49:04 +0000
Received: from zebedee.littlepinkcloud.COM ([82.6.106.47])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20071113114904.BWRN29112.aamtaout04-winn.ispmail.ntl.com@zebedee.littlepinkcloud.COM>;
          Tue, 13 Nov 2007 11:49:04 +0000
Received: from littlepinkcloud.COM (localhost.localdomain [127.0.0.1])
	by zebedee.littlepinkcloud.COM (8.13.8/8.13.5) with ESMTP id lADBmtbf001051;
	Tue, 13 Nov 2007 11:48:55 GMT
Received: (from aph@localhost)
	by littlepinkcloud.COM (8.13.8/8.13.5/Submit) id lADBmrBn001047;
	Tue, 13 Nov 2007 11:48:53 GMT
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18233.36645.232058.964652@zebedee.pink>
Date:	Tue, 13 Nov 2007 11:48:53 +0000
From:	Andrew Haley <aph-gcc@littlepinkcloud.COM>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org,
	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
In-Reply-To: <473957B6.3030202@avtrex.com>
References: <473957B6.3030202@avtrex.com>
X-Mailer: VM 7.19 under Emacs 22.0.93.1
Return-Path: <aph@littlepinkcloud.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aph-gcc@littlepinkcloud.COM
Precedence: bulk
X-list: linux-mips

David Daney writes:
 > With the current kernel (2.6.23.1) in my R5000 based O2 it seems 
 > impossible for GCC's exception unwinding machinery to unwind through 
 > signal frames.  The cause of the problems is the 
 > ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost 
 > impossible to determine offset from the signal return trampoline.  The 
 > unwinder depends on being able to find the sigcontext given a known 
 > location of the trampoline.
 > 
 > It seems there are a couple of possible solutions:
 > 
 > 1) The comments in war.h indicate the problem only exists in R7000
 > and E9000 processors.  We could turn off the workaround if the
 > kernel is configured for R5000.  That would help me, but not those
 > with the effected systems.
 > 
 > 2) In the non-workaround case, the siginfo immediately follows the
 > trampoline and the first member is the signal number.  For the
 > workaround case the first word following the trampoline is zero.
 > We could replace this with the offset to the sigcontext which is
 > always a small negative value.  The unwinder could then distinguish
 > the two cases (signal numbers are positive and the offset
 > negative).  If we did this, the change would have to be coordinated
 > with GCC's unwinder (in libgcc_s.so.1).
 > 
 > Thoughts?

The best solution is to put the unwinder info in the kernel.  Does
MIPS use a vDSO ?

Andrew.
