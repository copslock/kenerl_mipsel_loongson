Received:  by oss.sgi.com id <S305166AbPLFNBI>;
	Mon, 6 Dec 1999 05:01:08 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:24662 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbPLFNAt>;
	Mon, 6 Dec 1999 05:00:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA04545; Mon, 6 Dec 1999 05:08:05 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA64257
	for linux-list;
	Mon, 6 Dec 1999 05:00:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA79314
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 04:59:59 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA01456
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 04:59:53 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFM72>;
	Mon, 6 Dec 1999 10:59:28 -0200
Date:   Mon, 6 Dec 1999 10:59:28 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Nomenclature: "MIPS32", "MIPS64"
Message-ID: <19991206105928.I765@uni-koblenz.de>
References: <008301bf3fe7$b5fbb330$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <008301bf3fe7$b5fbb330$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 01:44:55PM +0100, Kevin D. Kissell wrote:

> "MIPS32" and "MIPS64" have a very specific
> meaning now, and for all I know are already
> trademarked/brandmarked/whatever by
> MIPS Technologies Inc. to describe the new
> baseline ISA and privileged resource architecture
> (CP0, in other words) standards for 32-bit
> and 64-bit MIPS devices.   It's no big deal
> for informal discussion, but *please* do not
> use the strings "MIPS32" or "MIPS64" in the
> code or documentation unless you are really
> and truly referring to MIPS32 and MIPS64
> as defined by MIPS.   If you want to refer to
> the 64-bit versus 32-bit Linux ports, please
> express it otherwise, e.g. MIPS64bit,
> MIPS_64_bit, 64bitMIPS, etc.   Otherwise
> there is going to be a lot of needless confusion
> and a further source schism.

The use of these terms is pretty coherent with their meaning as given by
Mips, Inc.  Linux/MIPS32 is a implementation of Linux (mostly) for MIPS32
processors, Linux/MIPS64 for MIPS64 processors, so I don't see the problem.

  Ralf
