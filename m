Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 14:33:23 +0000 (GMT)
Received: from p508B7B53.dip.t-dialin.net ([IPv6:::ffff:80.139.123.83]:16415
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225263AbUCYOdX>; Thu, 25 Mar 2004 14:33:23 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2PEXLoM001949;
	Thu, 25 Mar 2004 15:33:21 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2PEXJsn001948;
	Thu, 25 Mar 2004 15:33:19 +0100
Date: Thu, 25 Mar 2004 15:33:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: missing flush_dcache_page call in 2.4 kernel
Message-ID: <20040325143319.GA873@linux-mips.org>
References: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325.224229.112629304.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 25, 2004 at 10:42:29PM +0900, Atsushi Nemoto wrote:

> I noticed that reading from file with mmap sometimes return wrong data
> on 2.4 kernel.
> 
> This is a test program to reproduce the problem.

This seems to be the same problem as reported by Peter Horton as while
ago; in his case that was with PIO IDE.

  Ralf
