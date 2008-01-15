Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 13:11:51 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:13996 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20036735AbYAONLs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 13:11:48 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0FDBkYi007107;
	Tue, 15 Jan 2008 13:11:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0FDBjYU007106;
	Tue, 15 Jan 2008 13:11:45 GMT
Date:	Tue, 15 Jan 2008 13:11:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080115131145.GA5189@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080115112420.GA7347@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 15, 2008 at 12:24:20PM +0100, Thomas Bogendoerfer wrote:

> we are facing a strange problem with lenny/sid chroots on IP28. The
> machine locks up after issuing a few ls/ps commands in a chroot
> bash. This only happens with a lenny/sid chroot, but not with etch.
> The major difference is probably the updare to glibc2.7. Since
> IP28 isn't really a nice R10k machine, it would be good, if someone
> with a working IP27/IP30 could try a lenny/sid chroot and tell us,
> if it's working/not working.

Which CPU revision do you hit these problems on?

  Ralf
