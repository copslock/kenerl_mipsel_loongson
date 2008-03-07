Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2008 15:32:59 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53935 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28641573AbYCGPc5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Mar 2008 15:32:57 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m27FWuaR008878
	for <linux-mips@linux-mips.org>; Fri, 7 Mar 2008 15:32:56 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m27FWu19008877
	for linux-mips@linux-mips.org; Fri, 7 Mar 2008 15:32:56 GMT
Date:	Fri, 7 Mar 2008 15:32:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Cobalt build error
Message-ID: <20080307153256.GA8851@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Maybe some Cobalt hacker can sort out these issues in the latest kernel.
I could try to fix the build but don't have any Cobalt kit for testing ...

  Ralf

  CC      drivers/input/misc/cobalt_btns.o
drivers/input/misc/cobalt_btns.c: In function ‘cobalt_buttons_probe’:
drivers/input/misc/cobalt_btns.c:100: error: ‘struct input_dev’ has no member named ‘cdev’
drivers/input/misc/cobalt_btns.c:102: error: ‘struct platform_device’ has no member named ‘keymap’
drivers/input/misc/cobalt_btns.c:103: error: ‘struct platform_device’ has no member named ‘keymap’
drivers/input/misc/cobalt_btns.c:103: error: ‘struct platform_device’ has no member named ‘keymap’
drivers/input/misc/cobalt_btns.c:103: error: ‘struct platform_device’ has no member named ‘keymap’
drivers/input/misc/cobalt_btns.c:103: error: ‘struct platform_device’ has no member named ‘keymap’
drivers/input/misc/cobalt_btns.c:103: warning: type defaults to ‘int’ in declaration of ‘type name’
drivers/input/misc/cobalt_btns.c:103: warning: type defaults to ‘int’ in declaration of ‘type name’
drivers/input/misc/cobalt_btns.c:103: error: size of array ‘type name’ is negative
drivers/input/misc/cobalt_btns.c:108: error: ‘buttons_map’ undeclared (first use in this function)
drivers/input/misc/cobalt_btns.c:108: error: (Each undeclared identifier is reported only once
drivers/input/misc/cobalt_btns.c:108: error: for each function it appears in.)
drivers/input/misc/cobalt_btns.c:108: warning: type defaults to ‘int’ in declaration of ‘type name’
drivers/input/misc/cobalt_btns.c:108: warning: type defaults to ‘int’ in declaration of ‘type name’
drivers/input/misc/cobalt_btns.c:108: error: size of array ‘type name’ is negative
drivers/input/misc/cobalt_btns.c:109: warning: dereferencing ‘void *’ pointer
drivers/input/misc/cobalt_btns.c:109: error: invalid use of void expression
make[1]: *** [drivers/input/misc/cobalt_btns.o] Error 1
make: *** [drivers/input/misc/cobalt_btns.o] Error 2
