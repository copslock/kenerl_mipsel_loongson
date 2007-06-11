Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2007 10:57:36 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:20806 "EHLO mail.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022583AbXFKJ5d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2007 10:57:33 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by mail.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1HxgbK-00016L-FI
	for linux-mips@linux-mips.org; Mon, 11 Jun 2007 11:54:18 +0200
Message-ID: <466D1BBF.6030403@aurel32.net>
Date:	Mon, 11 Jun 2007 11:54:07 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: MIPS 20Kc and WAIT instruction
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

The latest kernels from kernel.org or linux-mips.org do not enter low
power mode when the CPU is idle on a MIPS 20Kc CPU.

Looking at the code in arch/mips/kernel/cpu-probe.c, the "case"
corresponding to the 20Kc CPU is commented out:

        case CPU_5KC:
/*      case CPU_20KC:*/
        case CPU_24K:

According to the datasheet this CPU supports the WAIT instruction, so I
don't really understand why it is disabled in the kernel. Does anybody
know why?

Thanks,
Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
