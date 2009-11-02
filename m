Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 00:33:57 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:56514 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493440AbZKBXdv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 00:33:51 +0100
Received: by yxe42 with SMTP id 42so5603010yxe.22
        for <linux-mips@linux-mips.org>; Mon, 02 Nov 2009 15:33:45 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=7F6twuMJaeisfHuSsK6bW6lGzxJK1QbCvHP4/4cALZU=;
        b=qIpcee11Zw9Gj/S4BCg3aAxnEQ2oMcbf1Yk1uNDAae+l5j8E+KRfhyefziBhlgRh/D
         2GveKk3uJHoU8Pte+NIZnK2SlmRJpxJLaWJuAMnnHLidZrbqiTSW9S92eIovS2Xq991R
         Ql3s0B9LtrqCfP4DQKmeU7uQPDuOwOQc90LHM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ZSPG0ZwSs61dmq6SSzJbThO4bj45mdcnI+dQNXTOxtFMPfhMuJHcv+SypNFxalDt6q
         QMrPDl2ZTY7vtlH7bb9aVKR7s1QReMuZSxh6h9LLERZomxZxsMadhaJWCicgb8hr7zVL
         4zsLCfYjpADGzNyESxc8nnSeGJFC1PNUHCjjU=
MIME-Version: 1.0
Received: by 10.90.62.4 with SMTP id k4mr1896548aga.56.1257204824420; Mon, 02 
	Nov 2009 15:33:44 -0800 (PST)
Date:	Tue, 3 Nov 2009 07:33:44 +0800
Message-ID: <e997b7420911021533t58dd2b1dr61218a67952dae97@mail.gmail.com>
Subject: mips64 smp kexec failed booting at timer interrupt
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	kexec@lists.infradead.org,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

I '  m using kexec on a mips64 smp board.

http://lists.infradead.org/pipermail/kexec/2008-June/001909.html

By now , the second kernel has halt at start_kernel --> calibrate_delay,

and I found that it was because of jiffies was not changing.

So  it might be the failure of installation for timer interrupt , or
timer interrupt did not trigger.



Before jumped into second kernel, local_irq_disable was called at each
CPU , and only one of CPU


was enable to jump into second kernel, while the others loop at
relocate_kernel all the time.




After I got dump_stack log of the firts kernel, I found that, do_timer
was invoked right after

console_init -->release_console_sem , it seemed that , timer interrupt
would be triggered

by release_console_sem .

here is the dump_stack info of do_timer of first kernel:


0:Call Trace:
0:[ <834243cc>]0: dump_stack+0x8/0x34
0:[ <83451ee0>]0: do_timer+0x70/0xa8
0:[ <8342333c>]0: timer_interrupt+0x64/0x160
0:[ <834234b4>]0: ll_timer_interrupt+0x7c/0xd8
0:[ <8341d220>]0: ret_from_irq+0x0/0x4
0:[ <83443a64>]0: release_console_sem+0x1e0/0x328
0:[ <8377cf88>]0: serial8250_console_init+0x1c/0x2c
0:[ <8377ae58>]0: console_init+0x4c/0x6c
0:[ <83762dd8>]0: start_kernel+0x3e0/0x75c



Any one know how to fix it?  or how to enable the timer interrupt  in
second kernel?

Thx
