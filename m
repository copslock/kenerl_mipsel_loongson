Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2003 17:12:21 +0100 (BST)
Received: from p508B6685.dip.t-dialin.net ([IPv6:::ffff:80.139.102.133]:45760
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225361AbTHaQMT>; Sun, 31 Aug 2003 17:12:19 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h7VGCH1p011509;
	Sun, 31 Aug 2003 18:12:17 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h7VGCHGA011508;
	Sun, 31 Aug 2003 18:12:17 +0200
Date: Sun, 31 Aug 2003 18:12:17 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ulrich Drepper <drepper@redhat.com>,
	Glibc hackers <libc-hacker@sources.redhat.com>,
	linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: Re: [PATCH] Fix sigevent_t stuff
Message-ID: <20030831161217.GA10286@linux-mips.org>
References: <20030831145854.GB23189@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831145854.GB23189@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Aug 31, 2003 at 04:58:54PM +0200, Ralf Baechle wrote:

> below patch fixes a mismatch between glibc and the kernel header's
> definition on MIPS.  Please apply.

Please ignore this patch.  Digging through the history of the missmatch
I came to the conclusion that this fix isn't the right one; I'll send
an updated patch.

  Ralf
