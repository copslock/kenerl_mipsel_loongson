Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 16:35:40 +0000 (GMT)
Received: from p508B6259.dip.t-dialin.net ([IPv6:::ffff:80.139.98.89]:51540
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225225AbUAQQfk>; Sat, 17 Jan 2004 16:35:40 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0HGZc4P027240;
	Sat, 17 Jan 2004 17:35:38 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0HGZcn1027239;
	Sat, 17 Jan 2004 17:35:38 +0100
Date: Sat, 17 Jan 2004 17:35:38 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Trouble compiling MIPS cross-compiler
Message-ID: <20040117163538.GF5288@linux-mips.org>
References: <200401171711.34964@korath> <200401171736.49803@korath> <20040117162753.GC22218@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040117162753.GC22218@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 17, 2004 at 05:27:53PM +0100, Thiemo Seufer wrote:

> > No idea what's going on, but at least it works and hopefully it won't 
> > overwrite my existing compiler when I install it ;-)
> 
> IIRC you need to configure with AS=mips-linux-as.

gcc uses as from the tools by default, then falls back to as in $PATH if
that fails.  So if you have to set the AS variable that's kludging around
the real problem.

  Ralf
