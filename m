Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 21:53:14 +0000 (GMT)
Received: from p508B5CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.92.197]:21858
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225375AbUBYVxO>; Wed, 25 Feb 2004 21:53:14 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1PLrBex024782;
	Wed, 25 Feb 2004 22:53:11 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1PLrABH024781;
	Wed, 25 Feb 2004 22:53:10 +0100
Date: Wed, 25 Feb 2004 22:53:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: IDE driver problem
Message-ID: <20040225215310.GB24298@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS> <20040225171315.GB17217@linux-mips.org> <Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be> <20040225181645.GA10742@linux-mips.org> <1077745654.26288.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077745654.26288.0.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 25, 2004 at 09:47:35PM +0000, Alan Cox wrote:

> On Mer, 2004-02-25 at 18:16, Ralf Baechle wrote:
> > Oh, those.  I fear every possible way to hookup the IDE bus in a more or
> > particularly less intelligent way to a system has already been found out
> > there ...
> 
> You would be suprised. You can do PIO IDE on just about anything. I
> think the most grotesque I've seen is bitbanged IDE PIO on GPIO ports

And I thought the ISA bus accessible only through an address / data
register pair was gross ;-)

  Ralf
