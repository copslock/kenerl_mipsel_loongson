Received:  by oss.sgi.com id <S305158AbQBPLhU>;
	Wed, 16 Feb 2000 03:37:20 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37976 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQBPLgs>; Wed, 16 Feb 2000 03:36:48 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA07184; Wed, 16 Feb 2000 03:39:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA57090
	for linux-list;
	Wed, 16 Feb 2000 03:25:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA51049
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 16 Feb 2000 03:25:40 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA02748
	for <linux@cthulhu.engr.sgi.com>; Wed, 16 Feb 2000 03:25:43 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id DA79A7F3; Wed, 16 Feb 2000 12:25:31 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8F8298FC4; Wed, 16 Feb 2000 12:22:50 +0100 (CET)
Date:   Wed, 16 Feb 2000 12:22:50 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@vger.rutgers.edu, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: oss.sgi.com CVS kernel doesn compile for DEC
Message-ID: <20000216122250.A898@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Just a small note - probably most of the people already stumbled on this.

ar  rcs lib.a  csum_partial.o csum_partial_copy.o floppy-std.o floppy-no.o ide-std.o ide-no.o kbd-std.o kbd-no.o rtc-std.o rtc-no.o memcpy.o memset.o strlen_user.o strncpy_user.o strnlen_user.o watch.o dump_tlb.o 
make[2]: Leaving directory `/data/kernel/linux/arch/mips/lib'
make[1]: Leaving directory `/data/kernel/linux/arch/mips/lib'
ld -static -G 0 -T arch/mips/ld.script.little -Ttext 0x80040000 arch/mips/kernel/head.o arch/mips/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/mips/kernel/kernel.o arch/mips/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o arch/mips/dec/dec.o \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.o drivers/net/net.o drivers/parport/parport.a drivers/scsi/scsi.a drivers/cdrom/cdrom.a drivers/video/video.o drivers/tc/tc.a \
        arch/mips/lib/lib.a /data/kernel/linux/lib/lib.a arch/mips/dec/prom/rexlib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o: In function `setkeycode':
keyboard.c(.text+0x848c): undefined reference to `pckbd_setkeycode'
keyboard.c(.text+0x848c): relocation truncated to fit: R_MIPS_26 pckbd_setkeycode
drivers/char/char.o: In function `getkeycode':
keyboard.c(.text+0x84a8): undefined reference to `pckbd_getkeycode'
keyboard.c(.text+0x84a8): relocation truncated to fit: R_MIPS_26 pckbd_getkeycode
drivers/char/char.o: In function `handle_scancode':
keyboard.c(.text+0x85c8): undefined reference to `pckbd_translate'
keyboard.c(.text+0x85c8): relocation truncated to fit: R_MIPS_26 pckbd_translate
keyboard.c(.text+0x8634): undefined reference to `pckbd_unexpected_up'
keyboard.c(.text+0x8634): relocation truncated to fit: R_MIPS_26 pckbd_unexpected_up
drivers/char/char.o: In function `kbd_bh':
keyboard.c(.text+0x9ab0): undefined reference to `pckbd_leds'
keyboard.c(.text+0x9ab0): relocation truncated to fit: R_MIPS_26 pckbd_leds
drivers/char/char.o: In function `misc_register':
misc.c(.text.init+0x910): undefined reference to `pckbd_init_hw'
misc.c(.text.init+0x910): relocation truncated to fit: R_MIPS_26 pckbd_init_hw
make: *** [vmlinux] Error 1

(root@193)/data/kernel/linux# egrep -i "KEY|KBD" .config
# CONFIG_KEYBOARD is not set

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
