Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2004 05:28:40 +0000 (GMT)
Received: from p508B4F41.dip.t-dialin.net ([IPv6:::ffff:80.139.79.65]:25506
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224934AbUAGF2j>; Wed, 7 Jan 2004 05:28:39 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i075SVa5007293;
	Wed, 7 Jan 2004 06:28:32 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id i075STI1007289;
	Wed, 7 Jan 2004 06:28:29 +0100
Date: Wed, 7 Jan 2004 06:28:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][2.6] add smp.h in processor.h
Message-ID: <20040107052829.GB29672@linux-mips.org>
References: <20040107125509.34cfa9db.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107125509.34cfa9db.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 07, 2004 at 12:55:09PM +0900, Yoichi Yuasa wrote:

> I made a patch for header file of 2.6.
> 
> smp_processor_id() is defined in smp.h.
> We need adding #include <linux/smp.h> in processor.h.

<linux/smp.h> pulls in a fairly large number of other header files which
is why no Linux architecture includes <linux/smp.h> in <asm/processor.h>.
So instead please include the file directly into your code.  In which .c
file you're hitting the problem?

  Ralf
