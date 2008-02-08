Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2008 19:30:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13038 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576485AbYBHT37 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Feb 2008 19:29:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m18JTw9Z023042;
	Fri, 8 Feb 2008 19:29:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m18JTvfx023041;
	Fri, 8 Feb 2008 19:29:57 GMT
Date:	Fri, 8 Feb 2008 19:29:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	Kumba <kumba@gentoo.org>, Thiemo Seufer <ths@networkno.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080208192957.GA18947@linux-mips.org>
References: <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org> <20080206085610.GA20751@paradigm.rfc822.org> <20080206142217.GA7633@linux-mips.org> <20080208172316.GD25893@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080208172316.GD25893@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 08, 2008 at 06:23:16PM +0100, Florian Lohoff wrote:

> You mean a single page in every processes address space or some
> /proc/sys/kernel/libatomic.so which would be a really cool hack?

The way it's being done on x86 doesn't work for MIPS unless we use
supervisor mode but supervisor mode is not implemented on all CPUs and
also of interest for virtualization.

  Ralf
