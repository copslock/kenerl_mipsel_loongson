Received:  by oss.sgi.com id <S553780AbQKNXMV>;
	Tue, 14 Nov 2000 15:12:21 -0800
Received: from tower.ti.com ([192.94.94.5]:13196 "EHLO tower.ti.com")
	by oss.sgi.com with ESMTP id <S553768AbQKNXMM>;
	Tue, 14 Nov 2000 15:12:12 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by tower.ti.com (8.11.1/8.11.1) with ESMTP id eAENC6911709
	for <linux-mips@oss.sgi.com>; Tue, 14 Nov 2000 17:12:06 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA09938
	for <linux-mips@oss.sgi.com>; Tue, 14 Nov 2000 17:12:06 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA09923
	for <linux-mips@oss.sgi.com>; Tue, 14 Nov 2000 17:12:05 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA22060
	for <linux-mips@oss.sgi.com>; Tue, 14 Nov 2000 17:12:05 -0600 (CST)
Message-ID: <3A11C6C5.C2CAB92E@ti.com>
Date:   Tue, 14 Nov 2000 16:12:05 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: egcs 1.0.3a build error?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I am trying to natively build egcs-1.0.3a-2 on an Atlas board (r4kc
little endian). I followed the emails and pulled down
ftp://ftp.mvista.com/pub/Area51/mips_le/misc/egcs-10.03a.tar.gz and
ftp://oss.sgi.com/pub/linux/mips/egcs/egcs-1.0.3a-2.diff.gz
applied the diff and did configure and then make. (I'm running
binutils-2.8.1 glibc-2.0.6 and egcs-1.0.2). The build fails with this
output:

/tmp/cca30501.s: Assembler messages:
/tmp/cca30501.s:136: Internal error!
Assertion failure in mips_emit_delays at ./config/tc-mips.c line 2231.
Please report this bug.
make[1]: *** [xexit.o] Error 1
make: *** [all-target-libiberty] Error 2

I have been unable to figure out what the problem is.

Any ideas?
