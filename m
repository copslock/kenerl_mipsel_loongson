Received:  by oss.sgi.com id <S305254AbQD2Wwv>;
	Sat, 29 Apr 2000 15:52:51 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:50765 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQD2Ww3>;
	Sat, 29 Apr 2000 15:52:29 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA16218; Sat, 29 Apr 2000 15:47:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA54496
	for linux-list;
	Sat, 29 Apr 2000 15:46:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA60406
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 Apr 2000 15:46:37 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA02148
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Apr 2000 15:46:35 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id AAA12337;
	Sun, 30 Apr 2000 00:46:31 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403826AbQD2Wp6>;
	Sun, 30 Apr 2000 00:45:58 +0200
Date:   Sun, 30 Apr 2000 00:45:58 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     nick@ns.snowman.net
Cc:     Ralf Baechle <ralf@oss.sgi.com>, Florian Lohoff <flo@rfc822.org>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: VC exceptions
Message-ID: <20000430004557.A1972@uni-koblenz.de>
References: <20000429071807.A491@uni-koblenz.de> <Pine.LNX.4.05.10004291833360.3830-100000@ns.snowman.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.05.10004291833360.3830-100000@ns.snowman.net>; from nick@ns.snowman.net on Sat, Apr 29, 2000 at 06:33:54PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Apr 29, 2000 at 06:33:54PM -0400, nick@ns.snowman.net wrote:

> What is a r7000?  I've heard of the r8000, is that the same?

Stupid answer: No, otherwise they'd have the same name :-)

The R8000 was some kind of CPU hack which SGI came up with when the R4400
performance was begining to look bad in comparison to the Alphas and the
R10000 project still would have taken quite some time.  It was featuring
roughly the integer performance and twice or trice the fp performance of
a 250MHz R4400 while running at just 75 - 90 MHz.  It was used only by
SGI.

The R7000 is kind of a successor to the R5000 featuring roughly R10000
performance but at a much lower price.  This was developed by either
IDT or QED mostly for embedded purposes.

  Ralf
