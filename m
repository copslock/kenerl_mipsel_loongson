Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2008 17:33:21 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:17880 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S36902744AbYEAQdS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2008 17:33:18 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Jrbif-0006pR-00
	for linux-mips@linux-mips.org; Thu, 01 May 2008 18:33:17 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 5366CC2A8A; Thu,  1 May 2008 18:33:14 +0200 (CEST)
Date:	Thu, 1 May 2008 18:33:14 +0200
To:	linux-mips@linux-mips.org
Subject: Breakage in arch/mips/kernel/traps.c for 64bit
Message-ID: <20080501163314.GA9955@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Hi,

it would be nice, if people started thinking before supplying such
crappy^Winteresting code:

arch/mips/kernel/traps.c:

#define IS_KVA01(a) ((((unsigned int)a) & 0xc0000000) == 0x80000000)

Kills every 64bit kernel build...

Why is this needed at all ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
