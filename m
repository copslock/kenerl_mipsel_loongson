Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 12:35:18 +0000 (GMT)
Received: from p508B6B36.dip.t-dialin.net ([IPv6:::ffff:80.139.107.54]:25629
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225203AbUATMfS>; Tue, 20 Jan 2004 12:35:18 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0KCZ8ex017564;
	Tue, 20 Jan 2004 13:35:08 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0KCZ6La017563;
	Tue, 20 Jan 2004 13:35:06 +0100
Date: Tue, 20 Jan 2004 13:35:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: wei liu <wei.liu@esstech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: unaligned problem in linux2.4.18?
Message-ID: <20040120123506.GA17208@linux-mips.org>
References: <002d01c3def2$cbc76480$6a0d12ac@ess>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002d01c3def2$cbc76480$6a0d12ac@ess>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 19, 2004 at 05:14:47PM -0800, wei liu wrote:

> I'm using mips-4kc core and try to port linux2.4.18. When kernel starts, it display the following OOP

An oops message is pretty usless unless decoded by ksymoops.  To make
matters worse, a crash in the unaligned handler is most probably just
sympthom of a problem elsewhere so having a decoded oops isn't necesarily
sufficient information to find the problem.

  Ralf
