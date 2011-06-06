Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 05:36:25 +0200 (CEST)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:61692 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFDgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 05:36:20 +0200
Received: by vxd2 with SMTP id 2so3330542vxd.36
        for <multiple recipients>; Sun, 05 Jun 2011 20:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=0FJ0rm1xg/3n71WM/jv5YZ8Dzeap8tEHf9mfSQeM4S4=;
        b=WC2ZIySQjra6GeNG/LJKZiEiM33tBje2oOZGUWcn8MeKpDMscIM7zeWjuVLKhJdyhn
         KmMmuQOqjmHIuWTBEqKQ6rheFqW9ZVnzRPMOhvMwkQeyGl9ILiOJhQVqSgtpFqDUSvH2
         UQp3E5q4Fr1voJdBunmv2mfTg5eGZuZDclYPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=v2PkpAkBZ+OdlYjQpFwtVpIVCpET7+O46NnfYT4FnAgf8yNb5pdafW8LOSn/DeHKZN
         Vev0TFe1ZA8kaKKG+cCMWGjj4GIF+qI3xJrCZHVeHzu79XsP/5bNa0g61oyyyEk9zeTy
         0wKPSTWZcnUCRdGwespgg0Sn1NSfX9cNeHNtw=
Received: by 10.220.90.77 with SMTP id h13mr83667vcm.14.1307331370110;
        Sun, 05 Jun 2011 20:36:10 -0700 (PDT)
Received: from localhost (cpe-174-109-057-197.nc.res.rr.com [174.109.57.197])
        by mx.google.com with ESMTPS id q38sm375289vcz.31.2011.06.05.20.36.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Jun 2011 20:36:09 -0700 (PDT)
Date:   Sun, 5 Jun 2011 23:36:08 -0400
From:   Matt Turner <mattst88@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Regression: d6d5d5c breaks Broadcom BCM91250A
Message-ID: <20110606033608.GA14686@localhost.mattst88>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3776

Hi Thomas,

Commit d6d5d5c4afd4c8bb4c5e3753a2141e9c3a874629 breaks boot-up on my
Broadcom BCM91250A. Reverting it solves the problem.

I looked at the commit but nothing obviously wrong jumped out at me.

Thanks,
Matt

CPU 1 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff80173888
Oops�#1�:
Cpu 1
$ 0   : 0000000000000000 0000000014001fe0 0000000000000000 ffffffff804d6e00
$ 4   : ffffffff804cce20 0000000000000000 0000000000000005 0000000000000000
$ 8   : 0000000000000000 0000000000000000 6978000000000000 0000000000000000
$12   : 0000000000000000 ffffffff80000008 ffffffff801aab00 0000000010020000
$16   : ffffffff804cce20 ffffffff804cce20 0000000000000008 ffffffff804cce9c
$20   : ffffffff8059de60 0000000014001fe1 0000000000001d4c 0000000000000000
$24   : 0000000010018348 ffffffff802e9f58                                  
$28   : a8000000ce068000 a8000000ce06bc10 0000000000000000 ffffffff80173888
Hi    : 0000000000000000
Lo    : 0000000000000700
epc   : 0000000000000000           (null)
    Tainted: G        W  
ra    : ffffffff80173888 irq_shutdown+0x58/0x78
Status: 14001fe2    KX SX UX KERNEL EXL 
Cause : 00800008
BadVA : 0000000000000000
PrId  : 03040102 (SiByte SB1)
Modules linked in:
Process init (pid: 1, threadinfo=a8000000ce068000, task=a8000000ce067718, tls=000000002b340400)
Stack : a8000000ce5d1700 ffffffff80171c28 a8000000ce46b800 ffffffff804cce20
        ffffffff8059de60 0000000000000008 a8000000ce46b810 ffffffff8059de68
        0000000000001d4c ffffffff80171d78 ffffffff8059de68 a8000000ce46b800
        a8000000ce468000 ffffffff802ea6c8 0000000014001fe1 a8000000ce46b878
        a8000000ce46b800 a8000000ce46b878 a8000000ce46b800 ffffffff802eb7c0
        a8000000ce06be50 a8000000ce06bcf8 a8000000ce06bda0 a8000000ce06be50
        a8000000ce06bd80 a8000000ce06be50 0000000014001fe1 a8000000ce11d760
        0000000000000000 a8000000ce468000 0000000000000000 0000000000000000
        a8000000ce044f40 0000000000000008 a8000000ce11d760 a8000000cd001450
        0000000000000000 ffffffff802d2c14 a8000000ce3b7000 ffffffffffffff9c
        ...
Call Trace:
�<ffffffff80171c28>� __free_irq+0xe4/0x1c8
�<ffffffff80171d78>� free_irq+0x6c/0xb4
�<ffffffff802ea6c8>� uart_shutdown+0xe4/0x120
�<ffffffff802eb7c0>� uart_close+0x224/0x334
�<ffffffff802d2c14>� tty_release+0x1dc/0x4c8
�<ffffffff801b9820>� do_filp_open+0x38/0x9c
�<ffffffff801ace88>� fput+0x130/0x224
�<ffffffff801a94ec>� filp_close+0x8c/0xa4
�<ffffffff801aabb0>� SyS_close+0xb0/0x110
�<ffffffff8010e6c4>� handle_sysn32+0x44/0xa0


Code: (Bad address in epc)

Disabling lock debugging due to kernel taint
Kernel panic - not syncing: Attempted to kill init!
