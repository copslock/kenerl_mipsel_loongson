Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 07:40:56 +0000 (GMT)
Received: from p508B6890.dip.t-dialin.net ([IPv6:::ffff:80.139.104.144]:53390
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225259AbUAIHk4>; Fri, 9 Jan 2004 07:40:56 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i097epfY002599;
	Fri, 9 Jan 2004 08:40:51 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i097ep7u002598;
	Fri, 9 Jan 2004 08:40:51 +0100
Date: Fri, 9 Jan 2004 08:40:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] add smp.h in processor.h
Message-ID: <20040109074051.GA2558@linux-mips.org>
References: <20040107125509.34cfa9db.yuasa@hh.iij4u.or.jp> <20040107052829.GB29672@linux-mips.org> <20040107154216.77967c1e.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107154216.77967c1e.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 07, 2004 at 03:42:16PM +0900, Yoichi Yuasa wrote:

> > <linux/smp.h> pulls in a fairly large number of other header files which
> > is why no Linux architecture includes <linux/smp.h> in <asm/processor.h>.
> > So instead please include the file directly into your code.  In which .c
> > file you're hitting the problem?
> 
> OK, I made a patch for same problem about vr41xx.
> Please apply this patch.

Applied,

  Ralf
