Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 14:02:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7377 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039968AbXJPNCd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Oct 2007 14:02:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9GD2WGM010945;
	Tue, 16 Oct 2007 14:02:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9GD2VxO010944;
	Tue, 16 Oct 2007 14:02:31 +0100
Date:	Tue, 16 Oct 2007 14:02:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-kernel@vger.kernel.org,
	Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc:	linux-mips@linux-mips.org
Subject: Build breakage if !SYSFS
Message-ID: <20071016130231.GA10778@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Changeset 5cb350baf580017da38199625b7365b1763d7180 causes build breakage
if sysfs support is disabled:

kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1488): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1490): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1480): undefined reference to `kernel_subsys'
kernel/built-in.o: In function `uids_kobject_init':
(.init.text+0x1494): undefined reference to `kernel_subsys'

This breaks for example mipssim_defconfig.

  Ralf
