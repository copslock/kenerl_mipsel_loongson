Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jan 2003 02:42:43 +0000 (GMT)
Received: from ppp-66-122-194-201.aonnetworks.com ([IPv6:::ffff:66.122.194.201]:23941
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8226083AbTAICmn>; Thu, 9 Jan 2003 02:42:43 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h092jcDP002663
	for <linux-mips@linux-mips.org>; Wed, 8 Jan 2003 18:45:38 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h092jcgi002661
	for linux-mips@linux-mips.org; Wed, 8 Jan 2003 18:45:38 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 8 Jan 2003 18:45:38 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: IS_ERR() in linux32.c
Message-ID: <20030109024537.GA2653@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

The file arch/mips64/kernel/linux32.c has a bunch of uses of IS_ERR(),
some against pointers (which is what it's designed to be used with),
and some against integers. I see a patch posted in 2001 which fixes
that, but it was also fixing other things and didn't get applied.

Anyone have a comment? This is about 1/3 of the remaining warnings when
I do "make -s" on the kernel.

-- greg
