Received:  by oss.sgi.com id <S305166AbPLFMM6>;
	Mon, 6 Dec 1999 04:12:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:26146 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFMMg>;
	Mon, 6 Dec 1999 04:12:36 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id EAA29628; Mon, 6 Dec 1999 04:15:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA20062
	for linux-list;
	Mon, 6 Dec 1999 04:09:33 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA64921
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 04:09:30 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA07367
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:09:26 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFMJA>;
	Mon, 6 Dec 1999 10:09:00 -0200
Date:   Mon, 6 Dec 1999 10:09:00 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Marc Esipovich <marc@mucom.co.il>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
Message-ID: <19991206100900.F765@uni-koblenz.de>
References: <006801bf3fde$cd110ec0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <006801bf3fde$cd110ec0$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 12:41:08PM +0100, Kevin D. Kissell wrote:

> The R10000/R12000 programs are still within SGI,
> and are not supported directly by MIPS Technologies
> Inc.   The MIPS/Linux kernel today does not support
> the R10000 (there's a panic("CPU too expensive");
> somewhere if the Processor ID for R10K is detected),

MIPS64 has R10k support.  I didn't even try to fix it for MIPS32 because
that kernel only supports upto 512mb memory.  And as you say it was
easy to implement.

  Ralf
