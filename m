Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 22:11:19 +0100 (BST)
Received: from [IPv6:::ffff:217.157.19.70] ([IPv6:::ffff:217.157.19.70]:61960
	"EHLO jehova.dsm.dk") by linux-mips.org with ESMTP
	id <S8225470AbTJMVLO>; Mon, 13 Oct 2003 22:11:14 +0100
Received: (qmail 28615 invoked from network); 13 Oct 2003 21:11:13 -0000
Received: from cpc5-cmbg1-3-0-cust166.cmbg.cable.ntl.com (HELO home.horsten.com) (@81.100.89.166)
  by server14.dsm.dk with RC4-MD5 encrypted SMTP; 13 Oct 2003 21:11:13 -0000
From: Thomas Horsten <thomas@horsten.com>
To: Ralf Baechle <ralf@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: need help on unaligned loads,stores!
Date: Mon, 13 Oct 2003 22:15:59 +0100
User-Agent: KMail/1.5.4
Cc: "Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
References: <200310131927.07171.thomas@horsten.com> <Pine.GSO.4.21.0310132132550.26520-100000@starflower.sonytel.be> <20031013204906.GA21100@linux-mips.org>
In-Reply-To: <20031013204906.GA21100@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310132215.59826.thomas@horsten.com>
Return-Path: <thomas@horsten.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

On Monday 13 October 2003 21:49, Ralf Baechle wrote:

> That correct.  Unfortunately emulating of these instructions in exception
> handlers would also be covered by the patents, so rewriting which would
> be rather easy in all cases I can think of is the way to go ...

Surely not in Europe (yet), at least?

- Thomas
