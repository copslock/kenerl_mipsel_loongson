Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2003 01:27:43 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:36457
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225212AbTCYB1n> convert rfc822-to-8bit; Tue, 25 Mar 2003 01:27:43 +0000
Received: from yaelgilad [194.90.64.161] by myrealbox.com
	with NetMail ModWeb Module; Sun, 23 Mar 2003 14:54:07 +0000
Subject: Second embedded ramdisk
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Sun, 23 Mar 2003 14:54:07 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1048431247.d25840c0yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

I am currently embedding a root-ram-disk within
my kernel image.
Can I embed a second disk ?

Motivation: The second disk will contain modules
to be inserted upon startup. I don't need the modules
later, so I'd rather umount this file system.
