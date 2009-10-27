Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 14:27:58 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:60965 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492570AbZJ0N1v (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 14:27:51 +0100
Received: by pzk32 with SMTP id 32so89132pzk.21
        for <linux-mips@linux-mips.org>; Tue, 27 Oct 2009 06:27:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=LXI+WMfNOdD//mcCWQpC/9cQit4DwGRybYJ0keWPVHE=;
        b=BBWfmAGTh5P0JElR84TvYjzBLkH5X1DYoFkox9krczvv+4pwr2HccP97p2lFN3VrVB
         +hKglaYDz7qKUx5JfP9w3oOZsj/hl0vF+MJC90pYCQMOYohUMEwseS6xxd5ll3jXJKc5
         t2mQDGKwqkVUFNwMTm7NuFLRCdbHca/MEN+Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ahF9X9rdFeaJ16gMXSfDocY7TFKqyLwZ/eq7MMeHvQlUOR/3vnL6UMzVJeBJEJIIwV
         GD6vFzKRSiHgQPPbBJcwFHFbhDMfweHHUEAiYWYK9XXSX01/ilmnV/QkDmC8U1bppw+/
         VHKRxaxdXdYwc+fHZwiGtdsw4MDuhI8LamBXI=
MIME-Version: 1.0
Received: by 10.143.25.39 with SMTP id c39mr1315087wfj.249.1256650063536; Tue, 
	27 Oct 2009 06:27:43 -0700 (PDT)
Date:	Tue, 27 Oct 2009 21:27:43 +0800
Message-ID: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
Subject: kernel panic about kernel unaligned access
From:	loody <miloody@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I use kernel 2.6.18 and I get the kernel panic as below:
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 00000000 11000001 0000040a 8721f0d8
$ 4   : 874a6c00 80001d18 00000000 00000000
$ 8   : 00000000 ffffa438 00000000 874c2000
$12   : 00000000 00000000 00005800 00011000
$16   : 80001d10 874a6c40 874a6c00 87d7bf00
$20   : 874a6c78 871a0000 87370000 874a6c80
$24   : 00000000 2aacc770
$28   : 87d7a000 87d7be88 ffffa438 8709ed20
Hi    : 00000000
Lo    : 00000000
epc   : 8709e72c sync_sb_inodes+0x9c/0x320     Not tainted
ra    : 8709ed20 writeback_inodes+0xb4/0x160
Status: 11000003    KERNEL EXL IE
Cause : 00808010
BadVA : 00000442
PrId  : 00019654
Modules linked in:
Process pdflush (pid: 38, threadinfo=87d7a000, task=87d695b8)
Stack : ffffffff ffffffff 871c0000 87cae4d8 874a6c00 874a6c40 87d7bf00 871c4290
        87d7bf64 871a0000 87370000 00000000 00000000 8709ed20 ffffffff ffffffff
        8735e380 874bb8a8 00000400 0000034b ffffa62c 87d7bf00 87057f9c 00000000
        87189270 87188b20 00000000 87189564 ffff9880 87362d58 00000000 00000000
        87d7bef8 00000400 00000000 00000000 00000000 00000000 00000000 00000000
        ...
Call Trace:
 [<8709ed20>] writeback_inodes+0xb4/0x160
 [<87057f9c>] wb_kupdate+0xb8/0x154
 [<87189270>] __schedule+0x998/0xb34
 [<87188b20>] __schedule+0x248/0xb34
 [<87189564>] preempt_schedule+0x68/0xac
 [<87058d74>] pdflush+0x188/0x284
 [<87058cfc>] pdflush+0x110/0x284
 [<8703b9e4>] kthread+0x14c/0x1b8
 [<87057ee4>] wb_kupdate+0x0/0x154
 [<87058bec>] pdflush+0x0/0x284
 [<8703ba00>] kthread+0x168/0x1b8
 [<87003398>] kernel_thread_helper+0x10/0x18
 [<87003388>] kernel_thread_helper+0x0/0x18


Code: 8e450084  24b0fff8  8e02009c <8c510038> 8e220008  30420002
1040000f  00000000  8ca20000
note: pdflush[38] exited with preempt_count 1

my questions are:
1. what does "Not tainted" mean?
2. I grep the kernel and I find the above message comes from do_ade in
unaligned.c, If I guess correctly.
    but from the call trace I cannot find out who call it.
    who and how kernel pass the information to do_ade?
3. as far as i know, inode is the data structure we used to record file.
From what information in the inode I can find out the file name the
writeback_inodes try to write?
appreciate your help,
miloody
