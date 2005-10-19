Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 08:33:49 +0100 (BST)
Received: from web16914.mail.tpe.yahoo.com ([202.43.201.188]:11958 "HELO
	web16914.mail.tpe.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465562AbVJSHdc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 08:33:32 +0100
Received: (qmail 88029 invoked by uid 60001); 19 Oct 2005 07:33:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.tw;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nocz1QdJLY1k/p9QuOx3KEzz50sUK9y9SWqEEonwdRKeBVyNflc+qLBf8O/anNUv2ZT9TqGsJFqZJZgijd90Dfu03Bp06gSA6Mw6GLAuYk9YTtnRGl3UTz7pfSm+bnkAbfegapZMnO5J+XX0ZFd4REpT/sI4yGYJkYRPIZnovPw=  ;
Message-ID: <20051019073323.88027.qmail@web16914.mail.tpe.yahoo.com>
Received: from [203.126.245.198] by web16914.mail.tpe.yahoo.com via HTTP; Wed, 19 Oct 2005 15:33:23 CST
Date:	Wed, 19 Oct 2005 15:33:23 +0800 (CST)
From:	hmc0116 <hmc0116@yahoo.com.tw>
Subject: Malta on Linux 2.6.14_rc1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Return-Path: <hmc0116@yahoo.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hmc0116@yahoo.com.tw
Precedence: bulk
X-list: linux-mips

Dear All,

I try to compile kernel 2.5.14 for Malta board. (It
includes a 4Kc CPU). I find that when I enable PCI,
and it will crash.
I serach from linux-mips and find that 

A long standing bug in the kernel's memcpy is
prefetching beyond the source and destination areas.
That's usually harmless unless the prefetched
addresses are outside of any RAM area. In this case
the Malta board will signal a bus error exception
which will result in a kernel crash. The issue was
being discussed
(http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=3DC7CB8B.E2C1D4E5%40mips.com)
on the linux-mips mailing list. The workaround is to
disable the use of prefetch instructions by disabling
the CONFIG_HAS_PREFETCH instruction or alternativly
making sure the last page of each memory area isn't
being used. Other boards are likely to be affected
also.

----------------

I disable CONFIG_CPU_HAS_PREFETCH . But I can not
boot.
I check th EPC. The boot fails in mips_pci_init.
What should I do to boot malta with PCI suppirt ???

___________________________________________________  最新版 Yahoo!奇摩即時通訊 7.0 beta，免費網路電話任你打！  http://messenger.yahoo.com.tw/beta.html
