Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Nov 2002 20:26:34 +0100 (CET)
Received: from host-65-122-203-2.quicklogic.com ([65.122.203.2]:18169 "HELO
	quicklogic.com") by linux-mips.org with SMTP id <S1123954AbSKMT0d> convert rfc822-to-8bit;
	Wed, 13 Nov 2002 20:26:33 +0100
Received: from qldomain-Message_Server by quicklogic.com
	with Novell_GroupWise; Wed, 13 Nov 2002 11:39:24 -0800
Message-Id: <sdd239ec.049@quicklogic.com>
X-Mailer: Novell GroupWise Internet Agent 5.5.6.1
Date: Wed, 13 Nov 2002 11:39:08 -0800
From: "Dan Aizenstros" <daizenstros@quicklogic.com>
To: <linux-mips@linux-mips.org>
Subject: Problem build kernel version 2.5.47
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <daizenstros@quicklogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daizenstros@quicklogic.com
Precedence: bulk
X-list: linux-mips

Hello All,

I am having a problem building the latest version
of the kernel. Below are the last lines seen during
the build.

make -f scripts/Makefile.build obj=drivers/char
  mipsel-linux-gcc -Wp,-MD,drivers/char/.consolemap.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -I /home/dan/devel/linux-2.5.x/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe -mcpu=r5000 -mips2 -Wa,--trap -nostdinc -iwithprefix include    -DKBUILD_BASENAME=consolemap   -c -o drivers/char/consolemap.o drivers/char/consolemap.c
make[1]: *** [drivers/char] Segmentation fault (core dumped)
make: *** [drivers] Error 2

The consolemap.o is built so I think the problem is
happening when consolemap_deftbl.o is being built.

I am using gcc version 3.2 and binutils 2.13.

Has any one else seen this problem?

-- Dan A.
