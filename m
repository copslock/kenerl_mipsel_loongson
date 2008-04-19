Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2008 23:23:55 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:50103 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28575417AbYDSWXx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 19 Apr 2008 23:23:53 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id E612B3187F4
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2008 22:24:37 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2008 22:24:37 +0000 (UTC)
Received: from [192.168.7.226] ([192.168.7.226]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 19 Apr 2008 15:23:38 -0700
Message-ID: <480A70EA.50804@avtrex.com>
Date:	Sat, 19 Apr 2008 15:23:38 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Building current kernel for Qemu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2008 22:23:38.0967 (UTC) FILETIME=[04239E70:01C8A26C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

I would like to build a current kernel for mipsel on qemu.  However it
seems that the qemu target was recently removed.

I tried building a plain malta kernel vmlinux, but there is no output on
the console when trying to boot it.  The Debian 2.6.18 qemu kernel seems
to work well though.

Do you have to do anything special to the kernel to run on qemu?

How does one go about building a kernel for qemu from current kernel
sources?

Thanks in advance for any insight into this,
David Daney
