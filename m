Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 19:38:02 +0000 (GMT)
Received: from p508B764E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.78]:36772
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225551AbTLATh7>; Mon, 1 Dec 2003 19:37:59 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hB1JbpA0030737;
	Mon, 1 Dec 2003 20:37:52 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hB1Jbm59030736;
	Mon, 1 Dec 2003 20:37:48 +0100
Date: Mon, 1 Dec 2003 20:37:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] NEC VR41xx new timer
Message-ID: <20031201193748.GA21538@linux-mips.org>
References: <20031202014935.1b2c796b.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202014935.1b2c796b.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 02, 2003 at 01:49:35AM +0900, Yoichi Yuasa wrote:

> I updated new timer patches for latest CVS tree.
> These patches are required for power management.
> 
> Please apply these patches.

Applied.  One comment on the new ksym.c file.  In 2.4 we used to have most
of the EXPORT_SYMBOL calls in a separate file in order to reduce the
compile time.  With the new kbuild system of 2.6 this is no longer a
problem so now the prefered way is exporting symbols from the defining
file itself.  So for example most of the symbol exports left in
arch/mips/kernel/mips_ksyms.c are for definitions in assembler files.

  Ralf
