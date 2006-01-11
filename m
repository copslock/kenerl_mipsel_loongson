Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 15:06:56 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:57567 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133731AbWAKPGb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2006 15:06:31 +0000
Received: from localhost (p8236-ipad03funabasi.chiba.ocn.ne.jp [219.160.88.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 01BC9B12C; Thu, 12 Jan 2006 00:09:34 +0900 (JST)
Date:	Thu, 12 Jan 2006 00:09:04 +0900 (JST)
Message-Id: <20060112.000904.74752908.anemo@mba.ocn.ne.jp>
To:	dan@debian.org
Cc:	linux-mips@linux-mips.org
Subject: Re: QEMU and kernel 2.6.15
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060111144355.GA17275@nevyn.them.org>
References: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
	<20060111144355.GA17275@nevyn.them.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 11 Jan 2006 09:43:56 -0500, Daniel Jacobowitz <dan@debian.org> said:

dan> You've configured the kernel for QEMU, right?  And are usin QEMU
dan> from CVS?

Yes, I configured the kernel with qemu_defconfig.  I tried both QEMU
0.8.0 and tried current CVS today, but got same results.

Here is my instructions:

kernel:
make O=../build-qemu qemu_defconfig
make O=../build-qemu

QEMU:
./configure --target-list=mips-softmmu --disable-gfx-check
make

Then:
mips-softmmu/qemu-system-mips -kernel /home/git/build-qemu/arch/mips/boot/vmlinux.bin -m 16 -nographic

dan> It worked for me the last time I tried, but that was a couple of
dan> weeks ago.  The port may have gotten broken...

While QEMU 0.8.0 was released on Dec 19 and it seems there was not so
much changes on kernel's arch/mips in last few weeks, we should be
very close ...

---
Atsushi Nemoto
