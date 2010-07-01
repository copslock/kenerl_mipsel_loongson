Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jul 2010 07:47:28 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:47739 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491015Ab0GAFrX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jul 2010 07:47:23 +0200
Received: by vws8 with SMTP id 8so2237582vws.36
        for <linux-mips@linux-mips.org>; Wed, 30 Jun 2010 22:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=NF8o0SiUcJbJFHhmvKkt2Wkr6dNXin7/5mpXXn3y3Qw=;
        b=fHrpdtuyYpVMSKx42hUcwe49DkBRVBDiGedQYCZtaOqcetTHYVyyc/lF+Yjtx51elZ
         PdXEq5mLxQDx0VHQSKcauPG8DqOh4zGVd/5TBxcI7Z7oTosrDF5ja1nYfa6bQ+F9Yco8
         +yVcO21sqNTD8+RkgObyW67VExC2WxIW32LS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=ISKt61eTiMB8ABIiGnPNW/0DA4Iz905pv7qqV00Gy2NW80Eb66822zQWp019PLcAOi
         KtfpVD21IvZXKe7aXJUUgZurFFHA+rgXwsPKBzh2i1YgrdHniN217MVzY8BuIMZXXtaQ
         aoYxJW20mhojYM+W3Po0Q0m7jCpnxTWFIlDGc=
MIME-Version: 1.0
Received: by 10.229.182.20 with SMTP id ca20mr5873890qcb.58.1277963236613; 
        Wed, 30 Jun 2010 22:47:16 -0700 (PDT)
Received: by 10.229.211.206 with HTTP; Wed, 30 Jun 2010 22:47:16 -0700 (PDT)
Date:   Thu, 1 Jul 2010 13:47:16 +0800
Message-ID: <AANLkTik9OHNXHE1l6bKixAG2ZqrYiswZCAKj-V5L8PGe@mail.gmail.com>
Subject: [Kernel Oops] Cavium Octeon, linux 2.6.34
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

While the 2.6.34 kernel works fine on loading and running, but it
emits oops everytime while rebooting.

/ # /sbin/reboot
CPU 2 Unable to handle kernel paging request at virtual address
0000005781657c00, epc == ffffffff8115f290, ra == ffffffff8115f380
Oops[#1]:
Cpu 2
$ 0   : 0000000000000000 0000000000000018 002bffffffc0af58 015ffffffe057ac0
$ 4   : ffffffe057afee00 0000000000000000 0000005781657c00 00000057ffffff80
$ 8   : 000000182f2de56b 0000000000000000 0000000000000001 0000000000008000
$12   : 0000000000000000 ffffffff81105d44 0000000000000000 0000000000000000
$16   : ffffffff815ebfb8 ffffffff815ec0a0 ffffffff815d0000 ffffffff815ec100
$20   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
$24   : 0000000000000000 ffffffff811152b8
$28   : a8000000bd180000 a8000000bd183dc0 0000000000000000 ffffffff8115f380
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff8115f290 bit_waitqueue+0x30/0xd0
    Not tainted
ra    : ffffffff8115f380 wake_up_bit+0x18/0x38
Status: 10108ce3    KX SX UX KERNEL EXL IE
Cause : 00800008
BadVA : 0000005781657c00
PrId  : 000d0409 (Cavium Octeon+)
Modules linked in:
Process flush-mtd-unmap (pid: 1357, threadinfo=a8000000bd180000,
task=a8000000d0256040, tls=0000000000000000)
Stack : 0000000000000000 ffffffff815d0000 ffffffff815ebf90 ffffffff8119ce18
        0000000000000000 a8000000d0cc7ca0 ffffffff8119cd90 ffffffff815ec0a0
        0000000000000000 ffffffff8115eec0 00000000beb2b997 0000000041b4b962
        00000000dead4ead ffffffffecbeaa23 ffffffffffffffff a8000000bd183e38
        a8000000bd183e38 a8000000044e9200 0000000000000000 0000000000000000
        0000000000000000 ffffffff81119348 a8000000044d9200 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        a8000000d0cc7ca0 ffffffff8115ee38 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        0000000000000000 0000000000000000 0000000000000000 0000000000000000
        ...
Call Trace:
[<ffffffff8115f290>] bit_waitqueue+0x30/0xd0
[<ffffffff8115f380>] wake_up_bit+0x18/0x38
[<ffffffff8119ce18>] bdi_start_fn+0x88/0x108
[<ffffffff8115eec0>] kthread+0x88/0x90
[<ffffffff81119348>] kernel_thread_helper+0x10/0x18


Code: 000219b8  00c7302d  000210f8 <dcc60000> 0062102f  2403fffc
24070680  00c31824  00a42025
Disabling lock debugging due to kernel taint

Is it a known and fixed bug?

Best regards,

Zhuang Yuyao
