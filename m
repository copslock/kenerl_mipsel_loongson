Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2008 22:49:13 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:62877 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28593726AbYGGVtE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2008 22:49:04 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KFyZz-00019G-00; Mon, 07 Jul 2008 23:49:03 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id A32DCC340A; Mon,  7 Jul 2008 23:49:00 +0200 (CEST)
Date:	Mon, 7 Jul 2008 23:49:00 +0200
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, ths@networkno.de
Subject: Current git broken for R4400 IP22
Message-ID: <20080707214900.GA16143@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

and the bisect winner is:

fb2a27e743cd565c25cd896911e494482a8b7251 is first bad commit
commit fb2a27e743cd565c25cd896911e494482a8b7251
Author: Thiemo Seufer <ths@networkno.de>
Date:   Mon Feb 18 19:32:49 2008 +0000

    [MIPS] Reimplement clear_page/copy_page

....


booting stops after:

EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 244k freed



This is on a IP22 CPU with 200Mhz:

CPU revision is: 00000460 (R4400SC)
FPU revision is: 00000500
[..]
Primary instruction cache 16kB, VIPT, direct mapped, linesize 16 bytes.
Primary data cache 16kB, direct mapped, VIPT, cache aliases, linesize 16
bytes
Unified secondary cache 1024kB direct mapped, linesize 128 bytes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
