Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2005 21:47:26 +0000 (GMT)
Received: from e4.ny.us.ibm.com ([IPv6:::ffff:32.97.182.144]:37049 "EHLO
	e4.ny.us.ibm.com") by linux-mips.org with ESMTP id <S8225215AbVAYVrL>;
	Tue, 25 Jan 2005 21:47:11 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j0PLl4ua015540;
	Tue, 25 Jan 2005 16:47:04 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j0PLl35X273928;
	Tue, 25 Jan 2005 16:47:03 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0PLl3xB007042;
	Tue, 25 Jan 2005 16:47:03 -0500
Received: from joust (DYN317993BLD.beaverton.ibm.com [9.47.17.65])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j0PLl3xY007007;
	Tue, 25 Jan 2005 16:47:03 -0500
Received: by joust (Postfix, from userid 1000)
	id D8DEB4F99A; Tue, 25 Jan 2005 13:47:01 -0800 (PST)
Date:	Tue, 25 Jan 2005 13:47:01 -0800
From:	Nishanth Aravamudan <nacc@us.ibm.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, kernel-janitors@lists.osdl.org
Subject: MIPS still uses sleep_on*()
Message-ID: <20050125214701.GA2689@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <nacc@us.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nacc@us.ibm.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to clean up the remaning sleep_on*() calls in the kernel. These
functions have been deprecated for a *long* time, just never completely removed
:)

The only file I'm not comfortable with changing myself (since I am not a MIPS
user/expert) is arch/mips/kernel/process.c. This file references sleep_on(),
sleep_on_timeout(), interruptible_sleep_on() and
interruptible_sleep_on_timeout().

This file is (presuming my upcoming patches for sleep_on() go through
Kernel-Janitors ok) the final one before we can declare the kernel clean of
sleep_on() callers -- the other members of the family will take longer.

Any insight anyone could provide would be great, so that this milestone (for me,
at least) can be achieved.

Thanks,
Nish
