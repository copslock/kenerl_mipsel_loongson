Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Feb 2008 14:23:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38036 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035993AbYBFOXk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Feb 2008 14:23:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m16EMIXV007807;
	Wed, 6 Feb 2008 14:22:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m16EMHm4007806;
	Wed, 6 Feb 2008 14:22:17 GMT
Date:	Wed, 6 Feb 2008 14:22:17 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	Kumba <kumba@gentoo.org>, Thiemo Seufer <ths@networkno.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080206142217.GA7633@linux-mips.org>
References: <20080122154958.GA29108@linux-mips.org> <479AA532.5040603@gentoo.org> <20080126143949.GA6579@alpha.franken.de> <47A4E9DF.5070603@gentoo.org> <20080203021647.GA15910@linux-mips.org> <20080203062711.GA28394@paradigm.rfc822.org> <47A80C0A.4040106@gentoo.org> <20080205122211.GA24136@networkno.de> <47A928BF.5000302@gentoo.org> <20080206085610.GA20751@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080206085610.GA20751@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 06, 2008 at 09:56:10AM +0100, Florian Lohoff wrote:

> No - the very same GLIBC does not work on mips1 machines and vice versa.
> Might by okay for gentoo but debian needs a run everywhere glibc which
> means some ld.so tricks like with the libc6-i686 to load a different
> glibc from my understanding.

There is the long standing plan to generate a shared library on on the
fly during kernel initialization and move atomic operations and performance
relevant functions like memcpy to it.  Thiemo's latest work on tlbex.c
got us a tiny step closer to that.

  Ralf
