Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 22:37:33 +0100 (BST)
Received: from p508B65AB.dip.t-dialin.net ([IPv6:::ffff:80.139.101.171]:2207
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225470AbTJMVha>; Mon, 13 Oct 2003 22:37:30 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9DLbQNK026680;
	Mon, 13 Oct 2003 23:37:26 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9DLbQjO026679;
	Mon, 13 Oct 2003 23:37:26 +0200
Date: Mon, 13 Oct 2003 23:37:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Horsten <thomas@horsten.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: need help on unaligned loads,stores!
Message-ID: <20031013213726.GA25414@linux-mips.org>
References: <200310131927.07171.thomas@horsten.com> <Pine.GSO.4.21.0310132132550.26520-100000@starflower.sonytel.be> <20031013204906.GA21100@linux-mips.org> <200310132215.59826.thomas@horsten.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310132215.59826.thomas@horsten.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2003 at 10:15:59PM +0100, Thomas Horsten wrote:

> > That correct.  Unfortunately emulating of these instructions in exception
> > handlers would also be covered by the patents, so rewriting which would
> > be rather easy in all cases I can think of is the way to go ...
> 
> Surely not in Europe (yet), at least?

The patent itself is a hardware patent and those also cover software
implementations by interpretation of US, European and various national
European patent offices.  Otoh the patent will expire in like a year or
two anyway :-)

  Ralf
