Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 16:29:15 +0100 (BST)
Received: from smtp14.dti.ne.jp ([202.216.231.189]:42480 "EHLO
	smtp14.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S20091840AbYIJP3L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Sep 2008 16:29:11 +0100
Received: from [192.168.1.3] (PPPa881.tokyo-ip.dti.ne.jp [210.159.215.131]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m8AFSw1r020588;Thu, 11 Sep 2008 00:29:01 +0900 (JST)
Message-ID: <48C7E7BA.2040600@ruby.dti.ne.jp>
Date:	Thu, 11 Sep 2008 00:28:58 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@paralogos.com>
CC:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	michael@free-electrons.com, vlad.lungu@windriver.com
Subject: Re: [PATCH 1/1] mips: clear IV bit in CP0 cause if the CPU doesn't
 support divec
References: <> <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com> <48C7AB71.8090106@paralogos.com>
In-Reply-To: <48C7AB71.8090106@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:
> I think it's important to know whether it's U-Boot or Linux that's confused.
> As Thomas Bogendoerfer pointed out, it's not good practice to flip bits whose
> use is unknown to the kernel.  If in fact the CPU in question does support IV,
> was correctly identified as such by U-Boot, but isn't recognized by the MIPS
> Linux kernel, then we ought to fix Linux to recognize the CPU.  If it doesn't
> support IV, but U-Boot thought it did, then U-Boot is broken and ought to
> be fixed.  If you you're stuck with a broken U-Boot for some reason, then
> there ought to be some platform-specific place to put a hack.

It seems the culprit is U-Boot/MIPS `qemu-mips' target. It apparently
sets IV bit in its local initialization.

u-boot/board/qemu-mips/lowlevel_init.S
---------------------------------------
http://git.denx.de/?p=u-boot.git;a=blob;f=board/qemu-mips/lowlevel_init.S;hb=HEAD

/* Memory sub-system initialization code */

#include <config.h>
#include <asm/regdef.h>
#include <asm/mipsregs.h>

	.text
	.set noreorder
	.set mips32

	.globl	lowlevel_init
lowlevel_init:

	/*
	 * Step 2) Establish Status Register
	 * (set BEV, clear ERL, clear EXL, clear IE)
	 */
	li	t1, 0x00400000
	mtc0	t1, CP0_STATUS

	/*
	 * Step 3) Establish CP0 Config0
	 * (set K0=3)
	 */
	li	t1, 0x00000003
	mtc0	t1, CP0_CONFIG

	/*
	 * Step 7) Establish Cause
	 * (set IV bit)
	 */
	li	t1, 0x00800000
	mtc0	t1, CP0_CAUSE

	/* Establish Wired (and Random) */
	mtc0	zero, CP0_WIRED
	nop

	jr	ra
	nop

--->8--->8--->8--->8---


On the other hand, a normal U-Boot/MIPS startup routine doesn't set any
CP0.CAUSE bits; it just clears all bits right after system reset.

u-boot/cpu/mips/start.S
------------------------
http://git.denx.de/?p=u-boot.git;a=blob;f=cpu/mips/start.S;hb=HEAD

	(snipped)

	/* Clear watch registers.
	 */
	mtc0	zero, CP0_WATCHLO
	mtc0	zero, CP0_WATCHHI

	/* WP(Watch Pending), SW0/1 should be cleared. */
	mtc0	zero, CP0_CAUSE

	setup_c0_status_reset

	/* Init Timer */
	mtc0	zero, CP0_COUNT
	mtc0	zero, CP0_COMPARE

	(snipped)

So this issue only happens on U-Boot/MIPS `qemu-mips' target, I think.


  Shinya
