Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2005 18:04:43 +0000 (GMT)
Received: from bay101-dav18.bay101.hotmail.com ([64.4.56.90]:40226 "EHLO
	hotmail.com") by ftp.linux-mips.org with ESMTP id S8135602AbVKGSEZ
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Nov 2005 18:04:25 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 7 Nov 2005 10:05:37 -0800
Message-ID: <BAY101-DAV18ABC35208B50E0535A360D2650@phx.gbl>
Received: from 81.159.218.61 by BAY101-DAV18.phx.gbl with DAV;
	Mon, 07 Nov 2005 18:05:37 +0000
X-Originating-IP: [81.159.218.61]
X-Originating-Email: [oski2001@hotmail.com]
X-Sender: oski2001@hotmail.com
From:	"oski" <oski2001@hotmail.com>
To:	<linux-mips@linux-mips.org>
Subject: Compiling a kernel for ibm z50
Date:	Mon, 7 Nov 2005 18:07:42 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-OriginalArrivalTime: 07 Nov 2005 18:05:37.0228 (UTC) FILETIME=[DB0138C0:01C5E3C5]
Return-Path: <oski2001@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oski2001@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,
I am still having problems when compiling thfe kernel.
I get an Error and the last lines are:
init/do_mounts.o: In function "mount_root"
do_mounts.c: (.text.init+0x7e8): undefined reference to "ip_auto_config"
do_mounts.c: (.text.init+0x7e8): relocation truncated to fit:R_MIPS_26
against "ip_auto_config"
make: *** (vmlinux) Error 1

Any suggestions?

Many tks

oski
