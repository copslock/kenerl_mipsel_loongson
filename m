Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Apr 2003 02:59:06 +0100 (BST)
Received: from p508B5C1F.dip.t-dialin.net ([IPv6:::ffff:80.139.92.31]:56210
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225220AbTDZB7E>; Sat, 26 Apr 2003 02:59:04 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3Q1wGi20311;
	Sat, 26 Apr 2003 03:58:16 +0200
Date: Sat, 26 Apr 2003 03:58:16 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: patch: mm/init.c warning
Message-ID: <20030426035815.A20288@linux-mips.org>
References: <3EA80713.268F0CD6@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA80713.268F0CD6@broadcom.com>; from kwalker@broadcom.com on Thu, Apr 24, 2003 at 08:47:31AM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 24, 2003 at 08:47:31AM -0700, Kip Walker wrote:

> I know I'm not the first to send something like this... can we please
> apply this warning fix for arch/mips/mm/init.c in the non-HIGHMEM case?

I've applied the patch now - I just never liked it because it's an ugly
#ifdef-o-manis ...

  Ralf
