Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 07:51:59 +0100 (BST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:11209 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8126552AbWFGGvw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 07:51:52 +0100
Received: (qmail 21798 invoked from network); 7 Jun 2006 11:01:09 -0000
Received: from laja.dev.rtsoft.ru.dev.rtsoft.ru (HELO dev.rtsoft.ru.) (192.168.1.205)
  by mail.dev.rtsoft.ru with SMTP; 7 Jun 2006 11:01:09 -0000
Date:	Wed, 7 Jun 2006 10:52:21 +0400
From:	Vitaly Wool <vitalywool@gmail.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-mips@linux-mips.org
Subject: PNX8550 fails to compile in 2.6.17-rc4
Message-Id: <20060607105221.7b15b243.vitalywool@gmail.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <vitalywool@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vitalywool@gmail.com
Precedence: bulk
X-list: linux-mips

Hi folks,

when I try to compile Linux kernel for pnx8550 in 2.6.17-rc4, I get the following error:

  CC      arch/mips/philips/pnx8550/common/setup.o
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c: In function `plat_setup':
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:133: warning: implicit declaration of function `ip3106_lcr'
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:134: error: invalid lvalue in assignment
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: warning: implicit declaration of function `ip3106_baud'
/home/vital/work/opensource/mtd/arch/mips/philips/pnx8550/common/setup.c:135: error: invalid lvalue in assignment
make[2]: *** [arch/mips/philips/pnx8550/common/setup.o] Error 1
make[1]: *** [arch/mips/philips/pnx8550/common] Error 2
make: *** [vmlinux] Error 2

I guess it's not what it should be ;-)

Vitaly
