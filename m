Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 13:48:18 +0100 (BST)
Received: from p508B77C3.dip.t-dialin.net ([IPv6:::ffff:80.139.119.195]:11482
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTE0MsP>; Tue, 27 May 2003 13:48:15 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h4RCmAbY025902;
	Tue, 27 May 2003 05:48:10 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h4RCmAY6025901;
	Tue, 27 May 2003 14:48:10 +0200
Date: Tue, 27 May 2003 14:48:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: special include/asm/siginfo.h for MIPS
Message-ID: <20030527124810.GB25333@linux-mips.org>
References: <20030520191124.N32567@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030520191124.N32567@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 20, 2003 at 07:11:24PM -0700, Jun Sun wrote:

> Any thoughts?  Can we just use what other arches are using?

No.  Changing the Linux ABI is not an option without forcing reason
unless you somehow can show that some interface simply wasn't used.

  Ralf
