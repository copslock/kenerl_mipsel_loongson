Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2004 21:28:03 +0100 (BST)
Received: from p508B6474.dip.t-dialin.net ([IPv6:::ffff:80.139.100.116]:11307
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225787AbUFJU17>; Thu, 10 Jun 2004 21:27:59 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i5AKRrZu011305;
	Thu, 10 Jun 2004 22:27:54 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i5AKRpRR011304;
	Thu, 10 Jun 2004 22:27:51 +0200
Date: Thu, 10 Jun 2004 22:27:51 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Haley <aph@redhat.com>
Cc: David Daney <ddaney@avtrex.com>, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, java@gcc.gnu.org
Subject: Re: [RFC] MIPS division by zero and libgcj...
Message-ID: <20040610202751.GA5816@linux-mips.org>
References: <40C8B29B.3090501@avtrex.com> <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16584.46883.332620.513805@cuddles.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 10, 2004 at 08:31:47PM +0100, Andrew Haley wrote:

> I thought that the MIPS never generated a hardware trap for division,
> but instead there was an assembler macro that did the test for
> overflow, and the "div" instruction actually generates this test
> inline.  Maybe do a disassembly to check.

Linux/MIPS's behaviour is consistent with all MIPS UNIX flavours I know
of both those following the SysV ABI and others such as Ultrix.

  Ralf
