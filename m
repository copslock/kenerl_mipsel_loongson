Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 00:29:24 +0000 (GMT)
Received: from p508B617B.dip.t-dialin.net ([IPv6:::ffff:80.139.97.123]:61459
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225475AbUATA3Y>; Tue, 20 Jan 2004 00:29:24 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0K0RMex007100;
	Tue, 20 Jan 2004 01:27:22 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0K0RMxA007099;
	Tue, 20 Jan 2004 01:27:22 +0100
Date: Tue, 20 Jan 2004 01:27:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Pavel Kiryukhin <vksavl@cityline.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: sys32_sched_getaffinity
Message-ID: <20040120002721.GA6933@linux-mips.org>
References: <1852455000.20040119225548@cityline.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1852455000.20040119225548@cityline.ru>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 19, 2004 at 10:55:48PM +0300, Pavel Kiryukhin wrote:

> could anybody give some comments on the following code in 2.4.x -
> 2.6.1.
> 
> sys_sched_getaffinity [kernel/sched.c] on success returns the size of
> cpumask_t, which is obviously positive value.
> 
> while
> 
> sys32_sched_getaffinity [arch/mips/kernel/linux32.c] expect 0 as
> successful return from sys_sched_getaffinity.

Wrong question.  The question should be why does the MIPS kernel not use
the generic 32-bit compatibility functions?  It now does, I just changed
that.

  Ralf
