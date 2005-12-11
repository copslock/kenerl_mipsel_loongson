Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2006 02:33:29 +0000 (GMT)
Received: from webmail.ict.ac.cn ([159.226.39.7]:52698 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S3465640AbWBBCdG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2006 02:33:06 +0000
Received: (qmail 539 invoked by uid 507); 2 Feb 2006 02:03:38 -0000
Received: from unknown (HELO ?210.77.15.252?) (fxzhang@210.77.15.72)
  by ict.ac.cn with SMTP; 2 Feb 2006 02:03:38 -0000
Message-ID: <439B9104.6000605@ict.ac.cn>
Date:	Sun, 11 Dec 2005 10:37:56 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: linker script for non-4k page size
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

hi,
  I come across a problem when trying to use 16k page size for 2.6.14
linux/mips kernel: arch/mips/kernel/vmlinux.lds.S align some sections
with hardcoded ". = ALIGN(4096)".
  This will lead to problem if non-4k page size is used. For example,
if the .init section is put at a page 4k-aligned but not 16k-aligned,
free_initmem will free more spaces than it should do, and strange
problems will occur.
  Should we change to alignment according to CONFIG_PAGE_SIZE_XX? or
just set it to largest possible value(this may cause size increasement?)
