Received:  by oss.sgi.com id <S305168AbQEPTyw>;
	Tue, 16 May 2000 19:54:52 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:13069 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQEPTyl>; Tue, 16 May 2000 19:54:41 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA09355; Tue, 16 May 2000 12:59:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA18219
	for linux-list;
	Tue, 16 May 2000 12:48:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA92013
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 May 2000 12:48:35 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA02674
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 May 2000 12:48:33 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-18.uni-koblenz.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id VAA05081
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 May 2000 21:48:35 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403838AbQEPOrm>;
	Tue, 16 May 2000 16:47:42 +0200
Date:   Tue, 16 May 2000 16:47:42 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     SGI-MIPS List <linux@cthulhu.engr.sgi.com>
Subject: Re: 2.3.99-pre8 -> 2.3.99-pre9-1
Message-ID: <20000516164742.B5017@uni-koblenz.de>
References: <20000515001518.B6575@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000515001518.B6575@lug-owl.de>; from jbglaw@lug-owl.de on Mon, May 15, 2000 at 12:15:18AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 15, 2000 at 12:15:18AM +0200, Jan-Benedict Glaw wrote:

> I see quite a lot of mips and mips64 changes in pre9-1 patch... That
> reminds me to ask when there will be a full merge of the CVS repository
> with the mainstream kernel?

Hopefully soon.  Various mostly minor things need to be cleaned out before
they can be sent to Linus but basically we're ready.  Today I've sent
a few more patches to Linus for inclusion into pre9-3 which add various
portability hooks which we need for various MIPS hardware.  Currently
the diff between Linus' kernel and our CVS kernel is pretty small.  Which
is good news.

  Ralf
