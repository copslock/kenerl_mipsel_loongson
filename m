Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 13:49:00 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:3401
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8224939AbTBYNtA> convert rfc822-to-8bit; Tue, 25 Feb 2003 13:49:00 +0000
Received: from yaelgilad [81.218.92.190] by myrealbox.com
	with NetMail ModWeb Module; Tue, 25 Feb 2003 13:49:01 +0000
Subject: modules_install
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Tue, 25 Feb 2003 13:49:01 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1046180941.4ef528e0yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

How does one tweak the kernel's "modules_install" target in the 
makefile to properly be used for cross compiling ?
I can change the kernel Makefile, but I'd rather not.

My aim is to compile the modules and pack them into a ramdisk 
that is compiled into the kernel.
