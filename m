Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2008 04:01:17 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.168]:56863 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029302AbYFIDBP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jun 2008 04:01:15 +0100
Received: by wf-out-1314.google.com with SMTP id 28so2391175wff.21
        for <linux-mips@linux-mips.org>; Sun, 08 Jun 2008 20:01:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=DQmkV6WrooTb8F5oyLS6ACGCvTI6htP5BKynnKylmW4=;
        b=UGB6BcTUITgGMjJudDORuoHIiPT2hmaDwx2wPfiay8t/z7pbZYKS851i7iNjTwySI8
         FR42ZUS8Ie4ZTRi1GSWwgnfNMS+fG3pmZK5MMm69Mb1J4IhdGZdWsR+EqiVzL4V4vJLh
         CVg8httadTF76RpsHiluY18WtE1xQiAJSBrBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=M/iBUuovy3dnOsdV9AFrlDHQRMrTmKFBfEQBC8mlQ6d6M/mwdiXDFKNC8OA91SCRQ1
         Ap02/KqF3eR1QJ/WcKazKLJ2GXVVd/5u+W3dRdmdFMHAvBju6DDUhy5KUJjyjQr7mThy
         kG5cfkEHP4PVT696YsRDNinzwKxF3KWeH1wVU=
Received: by 10.142.126.17 with SMTP id y17mr1202934wfc.170.1212980473022;
        Sun, 08 Jun 2008 20:01:13 -0700 (PDT)
Received: by 10.143.42.1 with HTTP; Sun, 8 Jun 2008 20:01:12 -0700 (PDT)
Message-ID: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com>
Date:	Mon, 9 Jun 2008 11:01:12 +0800
From:	J.Ma <sync.jma@gmail.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: linux-2.6.25.4 Porting OOPS
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <sync.jma@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sync.jma@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,
    I am a newbie in kernel, so please be gentle.:)
    For these days, I am working on porting linux-2.6.25.4 to my own
Broadcom's SOC board, and I choose BCM47xx to start when menuconfig.
Everything goes well, I ported timer, serial, flash,etc. howerver, it
just broken when jumping to the userspace routine /sbin/init, please
take a look at the oops dump belowed.
    Could anyone give me a hint kindly? I doubt it might be the
toolchain's problem(maybe syscall_exit got a invalid para), bcz the
mipsel-linux- toolchain I used is built for linux-2.6.12. Since it
would be a huge work to rebuild a new 2.6.25-based toolchain, I sent
this email to check if any experienced guy could acknowledge this.
    Thanks in advance.



open /dev/console done.
try execute_command.
try /sbin/init.
Data bus error, epc == 8038c180, ra == 8000dd10
Oops[#1]:
Cpu 0
$ 0   : 00000000 10008000 fffda000 00000001
$ 4   : 811bf000 fffda000 811bff00 fffda000
$ 8   : 81007b20 00000044 2aaad268 2ab45c5c
$12   : 00000248 007cd68b 2ab48f4c 004670d0
$16   : 811bf000 80380000 7fb0a1d8 87d05a50
$20   : 87d7c7f8 87d05a50 87cfb1a0 7fb0a1d8
$24   : 000001b7 2aaa8a9c
$28   : 87d78000 87d79da0 87cfb1f0 8000dd10
Hi    : 308287f7
Lo    : b4e07b20
epc   : 8038c180 0x8038c180     Not tainted
ra    : 8000dd10 copy_user_highpage+0x98/0x158
Status: 10008003    KERNEL EXL IE
Cause : 0080001c
PrId  : 00020000 (Broadcom BCM4710)
Modules linked in:
Process init (pid: 206, threadinfo=87d78000, task=87c32df8)
Stack : 00000000 81007b20 87d7fc28 87d05a50 00000000 81007b20 87d7fc28 810237e0
        800774f8 80077440 87cfb1a0 87d7c004 00000000 00000000 00000000 00000000
        00000000 00000000 003d969b 87d7fc28 003d969b 87d05a50 87cfb1f0 7fb0a1d8
        87d7c7f8 00030000 7fb0a624 80078c88 87cfb1a0 00000000 87c32df8 802c3b0c
        87d7c7f8 87cfb1f0 003d969b 87cfb1a0 802c35ec 00000000 00000000 00000000
        ...
Call Trace:
[<800774f8>] do_wp_page+0x58c/0x818
[<80077440>] do_wp_page+0x4d4/0x818
[<80078c88>] handle_mm_fault+0x778/0x86c
[<802c3b0c>] _spin_unlock_irq+0x10/0x3c
[<802c35ec>] __down_read+0x48/0x150
[<8000d6f0>] do_page_fault+0x100/0x340
[<80002a00>] ret_from_exception+0x0/0x24
[<80002a78>] syscall_exit+0x0/0x38


Code: cca40100  8ca80000  8ca90004 <8caa0008> 8cab000c  cc9e0100
ac880000  ac890004  ac8a0008
note: init[206] exited with preempt_count 2
BUG: scheduling while atomic: init/206/0x10000002
Call Trace:
[<80008384>] dump_stack+0x8/0x34
[<802c0c6c>] schedule+0x74/0x5b8
[<80023e90>] __cond_resched+0x30/0x5c
[<802c1304>] _cond_resched+0x4c/0x60
[<802c2a50>] down_read+0x28/0x3c
[<80056ecc>] acct_collect+0x48/0x1a8
[<8002c340>] do_exit+0x2a0/0x738
[<80008a80>] do_be+0x0/0x16c

Data bus error, epc == 8038c180, ra == 8000dd10
Oops[#2]:
Cpu 0
$ 0   : 00000000 10008000 fffda000 00000002
$ 4   : 811c4000 fffda000 811c4f00 fffda000
$ 8   : 81007b20 00000001 81023940 00080000
$12   : 00000000 80386980 00000001 2ab437dc
$16   : 811c4000 80380000 7fb0a1dc 87d05058
$20   : 87d0a7f8 87d05058 87cfb000 7fb0a1dc
$24   : 00000001 0046703c
$28   : 87c18000 87c19da0 87cfb050 8000dd10
Hi    : 308287f7
Lo    : b4e07b20
epc   : 8038c180 0x8038c180     Tainted: G      D
ra    : 8000dd10 copy_user_highpage+0x98/0x158
Status: 10008003    KERNEL EXL IE
Cause : 0080001c
PrId  : 00020000 (Broadcom BCM4710)
Modules linked in:
Process init (pid: 1, threadinfo=87c18000, task=87c16000)
Stack : 00000000 81007b20 87d17c28 87d05058 00000000 81007b20 87d17c28 81023880
        800774f8 80077440 00000000 10008000 00000001 ffffffff 00000000 00000000
        00000000 00000000 003d969b 87d17c28 003d969b 87d05058 87cfb050 7fb0a1dc
        87d0a7f8 00030000 7fb0a624 80078c88 000000ce 00000000 87c16000 802c3b0c
        87d0a7f8 87cfb050 003d969b 87cfb000 802c35ec 8001fa34 87c18000 87c19e60
        ...
Call Trace:
[<800774f8>] do_wp_page+0x58c/0x818
[<80077440>] do_wp_page+0x4d4/0x818
[<80078c88>] handle_mm_fault+0x778/0x86c
[<802c3b0c>] _spin_unlock_irq+0x10/0x3c
[<802c35ec>] __down_read+0x48/0x150
[<8001fa34>] enqueue_task_fair+0x2c/0x44
[<8000d6f0>] do_page_fault+0x100/0x340
[<80027908>] do_fork+0x254/0x338
[<800277d0>] do_fork+0x11c/0x338
[<8001f9cc>] set_next_entity+0x28/0x64
[<8001f9cc>] set_next_entity+0x28/0x64
[<8001fd84>] pick_next_task_fair+0xc0/0xf0
[<8001fdfc>] put_prev_task_fair+0x48/0x64
[<8001fde4>] put_prev_task_fair+0x30/0x64
[<802c1160>] schedule+0x568/0x5b8
[<80002a00>] ret_from_exception+0x0/0x24
[<80002b80>] work_resched+0x8/0x44


Code: cca40100  8ca80000  8ca90004 <8caa0008> 8cab000c  cc9e0100
ac880000  ac890004  ac8a0008
note: init[1] exited with preempt_count 2
Kernel panic - not syncing: Attempted to kill init!



-- 
FIXME if it is wrong.
