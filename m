Received:  by oss.sgi.com id <S305193AbQC1Ahc>;
	Mon, 27 Mar 2000 16:37:32 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:45324 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQC1AhG>;
	Mon, 27 Mar 2000 16:37:06 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA27561; Mon, 27 Mar 2000 16:32:26 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA88978
	for linux-list;
	Mon, 27 Mar 2000 16:30:09 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA92476
	for <linux@engr.sgi.com>;
	Mon, 27 Mar 2000 16:30:08 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05561
	for <linux@engr.sgi.com>; Mon, 27 Mar 2000 16:30:07 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-29.uni-koblenz.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id CAA12635;
	Tue, 28 Mar 2000 02:30:05 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQC1A33>;
	Tue, 28 Mar 2000 02:29:29 +0200
Date:   Tue, 28 Mar 2000 02:29:29 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ulf Carlsson <ulfc@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: CVS Update@oss.sgi.com: linux
Message-ID: <20000328022929.J3669@uni-koblenz.de>
References: <20000327210518Z305163-3992+178@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000327210518Z305163-3992+178@oss.sgi.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Mar 27, 2000 at 01:05:04PM -0800, Ulf Carlsson wrote:

> Modified files:
> 	arch/mips64/kernel: head.S 
> 
> Log message:
> 	Use 16 FP registers as default.

Please leave this flag set since 32 fpr is the default for the ABI64
code model.  The right place to set this flag is in
include/asm-mips64/processor.h:start_thread().

  Ralf
