Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 06:58:14 +0000 (GMT)
Received: from p508B65B9.dip.t-dialin.net ([IPv6:::ffff:80.139.101.185]:47515
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225194AbTA1G6N>; Tue, 28 Jan 2003 06:58:13 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0S6wBm20977;
	Tue, 28 Jan 2003 07:58:11 +0100
Date: Tue, 28 Jan 2003 07:58:11 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ZhouY.external@infineon.com
Cc: linux-mips@linux-mips.org
Subject: Re: A problem about gprof
Message-ID: <20030128075811.C20541@linux-mips.org>
References: <3A5A80BF651115469CA99C8928706CB603D7B2C2@mucse004.eu.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3A5A80BF651115469CA99C8928706CB603D7B2C2@mucse004.eu.infineon.com>; from ZhouY.external@infineon.com on Mon, Jan 27, 2003 at 03:27:16PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 27, 2003 at 03:27:16PM +0100, ZhouY.external@infineon.com wrote:

>   In order to use the gprof in the SDE 5.02 toolchain, I compiled a program
> with '-p' option but the compiler responsed with a error. I have checked the
> startup assembly code crt0.sx. There is an address operation which need the
> address of '_ecode'. Which library has the symbol '_ecode'?  Could you give
> me a clue?

There is no crt0.something in Linux.  Seems your compiler is configured
for some obscure target.  Rebuild your compiler for mips-linux or
mipsel-linux as target.  Zero chance otherwise.

  Ralf
