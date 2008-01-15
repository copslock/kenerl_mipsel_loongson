Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 11:24:34 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:12687 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20036527AbYAOLY0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2008 11:24:26 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1JEju4-0002Na-00
	for linux-mips@linux-mips.org; Tue, 15 Jan 2008 12:24:24 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2DFCAC2F7C; Tue, 15 Jan 2008 12:24:20 +0100 (CET)
Date:	Tue, 15 Jan 2008 12:24:20 +0100
To:	linux-mips@linux-mips.org
Subject: Tester with IP27/IP30 needed
Message-ID: <20080115112420.GA7347@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Hi,

we are facing a strange problem with lenny/sid chroots on IP28. The
machine locks up after issuing a few ls/ps commands in a chroot
bash. This only happens with a lenny/sid chroot, but not with etch.
The major difference is probably the updare to glibc2.7. Since
IP28 isn't really a nice R10k machine, it would be good, if someone
with a working IP27/IP30 could try a lenny/sid chroot and tell us,
if it's working/not working.

Thanks in advance.
Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
