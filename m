Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 16:23:34 +0000 (GMT)
Received: from rtsoft3.corbina.net ([85.21.88.6]:30752 "EHLO
	buildserver.ru.mvista.com") by ftp.linux-mips.org with ESMTP
	id S20031258AbYBLQXZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 16:23:25 +0000
Received: from localhost.localdomain (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id D999D8818
	for <linux-mips@linux-mips.org>; Tue, 12 Feb 2008 21:23:33 +0400 (SAMT)
Message-ID: <47B1C739.1080509@ru.mvista.com>
Date:	Tue, 12 Feb 2008 19:20:09 +0300
From:	Dmitry Antipov <antipov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Export exception cause register to userspace ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <antipov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antipov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello,

I'm working on a debugging software which should be able to determine an
exact reason of exception which may (and should) be processed within user
space - SIGTRAP, for example. This information should be extracted from
cause register (CP0 register 13, select 0), which is cp0_cause of pt_regs.
But this register is not stored within sigcontext of signal frame, so
it's value is not available from signal handler. Is it a good idea to add a
dedicated sigcontext field to store cause register ?

Dmitry
