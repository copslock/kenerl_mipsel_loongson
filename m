Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 00:33:27 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:41554 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20038423AbWLBAdX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2006 00:33:23 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: N32 shmat problem identified! Kernel fix needed.
Date:	Fri, 1 Dec 2006 16:33:16 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D4B5F5F@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: N32 shmat problem identified! Kernel fix needed.
Thread-Index: AccVn4woxnreGnt4Qeu5SryUvIlOVgAAtm7gAAGkLSA=
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

The problem is simple.

The function named sys32_shmat has no reason to exist, and is broken. It
assumes that user space has passed a pointer to the location where the
resulting pointer should be stored. But that is not the shmat API, and
glibc will pass no such parameter. So a null dereference results,
leading to EFAULT.

The fix is to remove this function from the code base and quite simply
to wire the normal sys_shmat into the n32 syscall table. Since there is
in fact no pointer-to-pointer argument, this function doesn't have a 32
bit compatibility issues.
