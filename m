Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 17:23:57 +0100 (BST)
Received: from smtp16.dti.ne.jp ([202.216.231.191]:11916 "EHLO
	smtp16.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22229797AbYJWQXw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 17:23:52 +0100
Received: from [192.168.1.3] (PPPax526.tokyo-ip.dti.ne.jp [210.170.129.26]) by smtp16.dti.ne.jp (3.11s) with ESMTP AUTH id m9NGNikl006584;Fri, 24 Oct 2008 01:23:48 +0900 (JST)
Message-ID: <4900A510.3000101@ruby.dti.ne.jp>
Date:	Fri, 24 Oct 2008 01:23:44 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH 00/10] Restructure EMMA2RH port
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Hi,

there have been many NEC EMMA SoCs so far, and with great pleasure we
have many Linux ports running on EMMA these days.  Even though most
those ports are not submitted to upstream, but I'd like to reorganize
current EMMA2RH ports into more easy maintainable shape as a reference.

There are a lot of things to do.  For the first step, I'd like to
introduce arch/mips/emma/ and include/asm/emma/ directories so that all
EMMA related sourches/headers can be easily shared across various EMMA
products/ports.

Here's the first attempt to try to change things as mentioned above.
Some possible improvements and cleanups are also included.  Patches will
follow, please review.  Any comments are highly appreciated.

Thanks in advance,

P.S. I'm also planning to do more cleanups around IRQ codes, register
     definition style, and so on.  But that'll be some other time.

--
Shinya Kuribayashi
NEC Electronics
