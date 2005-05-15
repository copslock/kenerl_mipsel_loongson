Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 May 2005 13:53:15 +0100 (BST)
Received: from fh020.dia.cp.net ([IPv6:::ffff:64.97.160.30]:474 "EHLO
	n016.sc0.cp.net") by linux-mips.org with ESMTP id <S8224979AbVEOMw7>;
	Sun, 15 May 2005 13:52:59 +0100
Received: from smtp.sc0.cp.net (64.97.131.2) by n016.sc0.cp.net (7.0.038) (authenticated as neoxx@canada.com)
        id 42693F9F00403647 for linux-mips@linux-mips.org; Sun, 15 May 2005 12:52:48 +0000
Received: from [129.13.186.3] by mail.canada.com with HTTP; Sun,
    15 May 2005 05:52:47 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
From:	neoxx@canada.com
Subject: crosscompiler
X-Sent-From: neoxx@canada.com
Date:	Sun, 15 May 2005 05:52:47 -0700 (PDT)
X-Mailer: Web Mail 6.1.7-3.4_1
Message-Id: <20050515125247.7596.fh034.wm@smtp.sc0.cp.net>
Return-Path: <neoxx@canada.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7913
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: neoxx@canada.com
Precedence: bulk
X-list: linux-mips

Hi,

I wanna set up a crosscompiler on my intel machine (
using debian woody ) in order to cross-compile a
self-written kernel ( no Linux/Mips ) for a MIPS 4kc (
little endian ) CPU. 


I've set up the binutils ( 2.15 ). While trying to
compile gcc 3.3.4 ( --target=mipsel
--prefix=/usr/local/mipscross --enable-languages=c,c++
--without-headers ) the following error occurs:

 xgcc: installation problem, cannot exec `mips-tfile':
No such file or directory
make[2]: *** [libgcc/./_m16addsf3.o] Error 1
make[2]: Leaving directory
`/home/cag/finaltry/gcc-3.3.4/gcc'
make[1]: *** [stmp-multilib] Error 2
make[1]: Leaving directory
`/home/cag/finaltry/gcc-3.3.4/gcc'
make: *** [all-gcc] Error 2

Any ideas how to fix that ?? Can I alternatively use
the mipsel-linux-gcc for the kernel ( I'm not quite
sure what sort of compiler that is... )

Thanks,

neoxx
