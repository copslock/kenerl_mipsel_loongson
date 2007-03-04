Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 16:22:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:53389 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037751AbXCDQWU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 16:22:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l24GKVoK002890
	for <linux-mips@linux-mips.org>; Sun, 4 Mar 2007 16:20:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l24GKUIu002889
	for linux-mips@linux-mips.org; Sun, 4 Mar 2007 16:20:30 GMT
Date:	Sun, 4 Mar 2007 16:20:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: PNX8550_V2PCI build breakage
Message-ID: <20070304162030.GA2853@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

pnx8550-v2pci_defconfig fails with:

  AR      arch/mips/lib-32/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
/usr/bin/mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:37: syntax error
make: *** [.tmp_vmlinux1] Error 1

Can somebody PNX knowledgable take care of that?

  Ralf
