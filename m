Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 05:41:21 +0000 (GMT)
Received: from dsl-KK-049.206.95.61.touchtelindia.net ([IPv6:::ffff:61.95.206.49]:21182
	"EHLO trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224908AbVAFFlR>; Thu, 6 Jan 2005 05:41:17 +0000
Received: from procsys.com ([192.168.1.128])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id j065S3gH013971
	for <linux-mips@linux-mips.org>; Thu, 6 Jan 2005 10:58:26 +0530
Message-ID: <41DCCD4A.20206AE9@procsys.com>
Date: Thu, 06 Jan 2005 11:01:54 +0530
From: priya <priya@procsys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Keyboard interface test fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <priya@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,
Iam trying to bring up the PS/2 mouse on
a custom board based on RM5231A MIPS
processor and IT8172 companion chip.

The PS/2 mouse and keyboard are
connected to the Super IO chip IT712F-A
(version 7). The keyboard gives me
"interface failed self test" error and
the mouse events does not get
recognized.

Iam running kernel version 2.4.25.

I have dumped the status and the data
register contents when the "keyboard
interface failure" happens. The data
register content is "0x2" - which means
clock is line stuck high. But the key
presses are recognized and iam able to
work with the keyboard well.

I dont know if anyone has faced such a
problem with this particular version of
Super IO or do i have to apply  a patch
??

regards
priya
