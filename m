Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 18:16:50 +0000 (GMT)
Received: from p508B5CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.92.197]:14431
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225599AbUBYSQu>; Wed, 25 Feb 2004 18:16:50 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1PIGlex010801;
	Wed, 25 Feb 2004 19:16:47 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1PIGjFE010800;
	Wed, 25 Feb 2004 19:16:45 +0100
Date: Wed, 25 Feb 2004 19:16:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: IDE driver problem
Message-ID: <20040225181645.GA10742@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS> <20040225171315.GB17217@linux-mips.org> <Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4443
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 25, 2004 at 06:38:17PM +0100, Geert Uytterhoeven wrote:

> > I'm not sure what you call endian issue here.  The PC style partition
> > table code we've used for years on big endian systems without problems.
> 
> I guess his hardware has a byteswapped IDE bus, like on Atari, Q40/Q60 and
> Tivo.

Oh, those.  I fear every possible way to hookup the IDE bus in a more or
particularly less intelligent way to a system has already been found out
there ...

  Ralf
