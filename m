Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 16:44:52 +0100 (BST)
Received: from smtp2.infineon.com ([IPv6:::ffff:194.175.117.77]:26531 "EHLO
	smtp2.infineon.com") by linux-mips.org with ESMTP
	id <S8225192AbTCaPou>; Mon, 31 Mar 2003 16:44:50 +0100
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp2.infineon.com (8.12.8/8.12.8) with ESMTP id h2VFgOV1017725
	for <linux-mips@linux-mips.org>; Mon, 31 Mar 2003 17:42:24 +0200 (MEST)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <2A24JQ5L>; Mon, 31 Mar 2003 17:44:44 +0200
Message-ID: <04C8EDC5AE3FD611ABE40002B39CF69B07F37F@ntah901e.savan.com>
From: Amit.Lubovsky@infineon.com
To: linux-mips@linux-mips.org
Subject: mips5kc - cpu registers
Date: Mon, 31 Mar 2003 18:45:43 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Return-Path: <Amit.Lubovsky@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Amit.Lubovsky@infineon.com
Precedence: bulk
X-list: linux-mips

Hi,
is there a possibility to use cpu registers in the code (temporarily)
instead of allocating 
automatic variables something like:
	func a()
	{
		FAST int, i, tmp;
		tmp = ...
		...
	}

as in vxWorks ?

Thanks,
Amit.
