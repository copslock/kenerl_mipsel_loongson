Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 09:00:01 +0000 (GMT)
Received: from host181-209-dsl.dols.net.pk ([IPv6:::ffff:202.147.181.209]:13472
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8224788AbVAJI75>; Mon, 10 Jan 2005 08:59:57 +0000
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2448.0)
	id <C459AN2D>; Mon, 10 Jan 2005 13:50:00 +0500
Message-ID: <1B701004057AF74FAFF851560087B1610646A0@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
Date: Mon, 10 Jan 2005 13:49:59 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <mudeem@Quartics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mudeem@Quartics.com
Precedence: bulk
X-list: linux-mips

hi,

I have built a toolchain using the following combination

binutils-2.15.94.0.2
gcc-3.4.3
glibc-2.3.3
linux-2.6.9	(from linux-mips.org)

I am cross compiling linux kernel for mips. I think the toolchain has been
successfully built. But when cross compiling the kernel I get the following
error

LD	init/built-in.o
LD .tmp_vmlinux1
mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
make: ***[.tmp_vmlinux1] Error 1

The vmlinux.lds is as follows

1) OUPUT_ARH(mips)
2) Entry(kernel_entry)
3) jiffies = jiffies_64;
4) SECTION
5) {
6)	. = ;
7)	/* rea-only */
8)	_text = .; /* Text and read only data *
	..................................
}

The line indicated by the error is . = ; Any ideas

Thanks in advance

Mudeem
