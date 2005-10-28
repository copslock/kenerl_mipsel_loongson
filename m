Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 10:51:59 +0100 (BST)
Received: from imsantv37.netvigator.com ([210.87.250.143]:12996 "EHLO
	imsantv37.netvigator.com") by ftp.linux-mips.org with ESMTP
	id S8133638AbVJ1Jvl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 10:51:41 +0100
Received: from imsantv44.netvigator.com (imsantv37 [127.0.0.1])
	by imsantv37.netvigator.com (8.13.1/8.13.1) with ESMTP id j9S9pmtU026535
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 17:51:49 +0800
Received: from LOUISLAI (ipvpn008225.netvigator.com [203.198.58.225])
	by imsantv44.netvigator.com (8.13.1/8.13.1) with SMTP id j9S9pjY7031495;
	Fri, 28 Oct 2005 17:51:46 +0800
From:	"Louis Lai" <louis.lai@entone.com>
To:	<linuxconsole-dev@lists.sourceforge.net>,
	<linux-mips@linux-mips.org>
Subject: missing /dev/tty0
Date:	Fri, 28 Oct 2005 17:46:23 +0800
Message-ID: <HAENJFHIMADGCOMALOKKOEELCBAA.louis.lai@entone.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Return-Path: <louis.lai@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: louis.lai@entone.com
Precedence: bulk
X-list: linux-mips

Hi all,

I am using a 2.4.30 kernel for my MIPS embedded processor. The kernel can
start up properly but the tty0 doesn't exist under /dev. I have already
enable the virtual console during kernel configuration. is it something
configure not properly for the kernel?? Anyone can help??

Thanks in advance,
Louis
