Received:  by oss.sgi.com id <S305158AbQBPBf4>;
	Tue, 15 Feb 2000 17:35:56 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1069 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBPBfq>; Tue, 15 Feb 2000 17:35:46 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA00627; Tue, 15 Feb 2000 17:38:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA42390
	for linux-list;
	Tue, 15 Feb 2000 17:24:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA58709;
	Tue, 15 Feb 2000 17:24:15 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA08204; Tue, 15 Feb 2000 17:24:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-22.uni-koblenz.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA06438;
	Wed, 16 Feb 2000 02:24:04 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBPBXe>;
	Wed, 16 Feb 2000 02:23:34 +0100
Date:   Wed, 16 Feb 2000 02:23:34 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        "Kevin D. Kissell" <kevink@mips.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000216022334.A1070@uni-koblenz.de>
References: <006501bf7803$59855ad0$0ceca8c0@satanas.mips.com> <20000216011337.C4633@uni-koblenz.de> <14505.64125.564813.333784@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <14505.64125.564813.333784@liveoak.engr.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Feb 15, 2000 at 05:16:45PM -0800, William J. Earl wrote:

> Ralf Baechle writes:
>  > On Tue, Feb 15, 2000 at 11:23:49PM +0100, Kevin D. Kissell wrote:
> ...
>  > >         mtc0    k1, CP0_ENTRYLO1                # load it
>  > >         b       1f
>  > >          tlbwr                                  # write random tlb entry
>  > > 1:
>  > >         nop
>  > >         eret
> ...
>  > Funky trick, isn't it?  I don't have the the R4600 / R5000 docs at hand
>  > but as I understood them the above code should also work just perfect
>  > for them.
> 
>       There is a need for a workaround on the R5000 for a "bad $badvaddr" 
> problem.  The except_vec0_r45k_bvahwbug() variation does not appear to be
> enabled for the R5000.  (It should not be needed for the RM7000 or the RM5271.)

I don't have this bug in my erratas documented, can you elaborate on it?

  Ralf
