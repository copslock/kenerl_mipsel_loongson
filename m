Received:  by oss.sgi.com id <S305158AbQBPB6G>;
	Tue, 15 Feb 2000 17:58:06 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14115 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPB5s>;
	Tue, 15 Feb 2000 17:57:48 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA26011; Tue, 15 Feb 2000 17:53:17 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA38960; Tue, 15 Feb 2000 17:57:17 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA82651
	for linux-list;
	Tue, 15 Feb 2000 17:46:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA08518;
	Tue, 15 Feb 2000 17:46:26 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA11942;
	Tue, 15 Feb 2000 17:46:20 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14506.350.713324.113307@liveoak.engr.sgi.com>
Date:   Tue, 15 Feb 2000 17:46:06 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
In-Reply-To: <20000216022334.A1070@uni-koblenz.de>
References: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com>
	<20000216011337.C4633@uni-koblenz.de>
	<14505.64125.564813.333784@liveoak.engr.sgi.com>
	<20000216022334.A1070@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Tue, Feb 15, 2000 at 05:16:45PM -0800, William J. Earl wrote:
...
 > >       There is a need for a workaround on the R5000 for a "bad $badvaddr" 
 > > problem.  The except_vec0_r45k_bvahwbug() variation does not appear to be
 > > enabled for the R5000.  (It should not be needed for the RM7000 or the RM5271.)
 > 
 > I don't have this bug in my erratas documented, can you elaborate on it?

     Sometimes you get a utlbmiss exception when there is already matching
TLB entry.  If you then blindly drop in the TLB entry, you get a duplicate,
which leads to Bad Things (tm).  The workaround is to probe for a duplicate,
and skip the tlbwr if an entry already exists.  It should be enabled on any
real R5000.  

    This is from the R5000 Errata list of 30 October 1997:

----------------------------------------------------------------------
3.  An erroneous JTLB miss exception will be taken under
    these conditions. 

    a) An instruction which does not cause an exception or
       stall is 8 bytes away from the end of a page.
    b) A load or store instruction is the last instruction of that page.
    c) The load/store target address has a matching but invalid
       JTLB entry
    d) The next sequential page is not mapped in the JTLB

    In this situation, when the load/store instruction is executed,
    a JTLB invalid exception should be taken, instead a JTLB miss
    exception is incorrectly taken. If the exception handler
    does a random TLB write to resolve the exception, this will in 
    general insert a duplicate TLB entry for each erroneous exception.
    If the first instruction is a jump or branch, this will cause
    an infinite loop of JTLB miss exceptions to occur upon the return
    from the exception handler.  Otherwise, there will be only one
    erroneous exception, followed by a correct exception, leaving
    one duplicate entry in the TLB.

    A software fix is for the JTLB miss handler to detect this situation,
    by probing for a matching TLB entry (treating a hit as being this case),
    ignore the JTLB miss and treat the exception as an JTLB invalid exception.

    Errata 3 is fixed in Rev 2.0.
----------------------------------------------------------------------

      It is not clear to me that Errata 3 is fixed in all cases in Rev 2.*,
so IRIX has the workaround enabled for all R5000 revisions.

     In Linux, just use except_vec0_r45k_bvahwbug() for any R5000.
