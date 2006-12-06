Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 01:58:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26033 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039130AbWLFB6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 01:58:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB61wId0028268;
	Wed, 6 Dec 2006 01:58:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB61wIL0028267;
	Wed, 6 Dec 2006 01:58:18 GMT
Date:	Wed, 6 Dec 2006 01:58:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
Message-ID: <20061206015818.GB27985@linux-mips.org>
References: <20061206.012311.86891097.anemo@mba.ocn.ne.jp> <20061205194907.GA1088@linux-mips.org> <20061205195702.GA2097@linux-mips.org> <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 10:39:23AM +0900, Atsushi Nemoto wrote:

> Ah ... could you tell me how Malta failed?

IDE DMA timeouts.

There are some other issues with the legacy IDE on the Intel PIIX which
likely affect other systems such as Alpha as well.  I think I solved that
so it's now time to tackle the IRQ stuff.  Even without your i8259 stuff
there are some strange things going on currently:

[...]
hda: Maxtor 31536H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 30015216 sectors (15367 MB) w/512KiB Cache, CHS=29777/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2   
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Time: MIPS clocksource has been installed.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing prom memory: 956kb freed
Freeing firmware memory: 978944k freed
Freeing unused kernel memory: 160k freed
irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
->chip(): 803a3d4c, 0x803a3d4c
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 7
Algorithmics/MIPS FPU Emulator v1.5
irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
->chip(): 803a3d4c, 0x803a3d4c
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 7
INIT: irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
->chip(): 803a3d4c, 0x803a3d4c
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 7
version 2.84 bootingirq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
->chip(): 803a3d4c, 0x803a3d4c
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 7

irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
->chip(): 803a3d4c, 0x803a3d4c
->action(): 00000000
  IRQ_DISABLED set
unexpected IRQ # 7
                Welcome to Red Hat Linux
                Press 'I' to enter interactive startup.
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
Setting clock  (utc): Wed Dec  6 00:16:39 GMT 2006 [  OK  ]
Activating swap partitions:  [  OK  ]
[...]

> BTW, your additional irq_cpu.c might have another problem.  The
> mips_mt_cpu_irq_controller have not used flow handler yet.  I did not
> change it since I could not see which flow handler (handle_level_irq
> or handle_percpu_irq) are suitable at the time.

  Ralf
