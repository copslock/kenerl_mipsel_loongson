Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Nov 2002 16:02:45 +0100 (CET)
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:15559 "EHLO
	rwcrmhc53.attbi.com") by linux-mips.org with ESMTP
	id <S1122121AbSKDPCo>; Mon, 4 Nov 2002 16:02:44 +0100
Received: from lucon.org ([12.234.88.146]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20021104150234.PNKH29857.rwcrmhc53.attbi.com@lucon.org>;
          Mon, 4 Nov 2002 15:02:34 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id 850892C4EC; Mon,  4 Nov 2002 07:02:33 -0800 (PST)
Date: Mon, 4 Nov 2002 07:02:33 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Re: Problems generating shared library for MIPS using binutils-2.13...
Message-ID: <20021104070233.C8860@lucon.org>
References: <Pine.GSO.3.96.1021025185639.1121A-100000@delta.ds2.pg.gda.pl> <3DC68907.30708@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC68907.30708@realitydiluted.com>; from sjhill@realitydiluted.com on Mon, Nov 04, 2002 at 08:49:43AM -0600
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 04, 2002 at 08:49:43AM -0600, Steven J. Hill wrote:
> 
> I'm convinced the linker completely ignores '-A' for MIPS. In the 

-A is for assembler, not linker.


H.J.
