Received:  by oss.sgi.com id <S305158AbQBPB3g>;
	Tue, 15 Feb 2000 17:29:36 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:22037 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBPB3F>;
	Tue, 15 Feb 2000 17:29:05 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA23199; Tue, 15 Feb 2000 17:24:34 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id RAA49854; Tue, 15 Feb 2000 17:29:03 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA01376
	for linux-list;
	Tue, 15 Feb 2000 17:17:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA33395;
	Tue, 15 Feb 2000 17:16:52 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id RAA09994;
	Tue, 15 Feb 2000 17:16:46 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14505.64125.564813.333784@liveoak.engr.sgi.com>
Date:   Tue, 15 Feb 2000 17:16:45 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
In-Reply-To: <20000216011337.C4633@uni-koblenz.de>
References: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com>
	<20000216011337.C4633@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Tue, Feb 15, 2000 at 11:23:49PM +0100, Kevin D. Kissell wrote:
...
 > >         mtc0    k1, CP0_ENTRYLO1                # load it
 > >         b       1f
 > >          tlbwr                                  # write random tlb entry
 > > 1:
 > >         nop
 > >         eret
...
 > Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
 > but as I understood them the above code should also work just perfect
 > for them.

      There is a need for a workaround on the R5000 for a "bad $badvaddr" 
problem.  The except_vec0_r45k_bvahwbug() variation does not appear to be
enabled for the R5000.  (It should not be needed for the RM7000 or the RM5271.)
