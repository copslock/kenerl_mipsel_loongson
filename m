Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 16:53:26 +0200 (CEST)
Received: from scrooge.tty.gr ([62.217.125.135]:46027 "EHLO mail.tty.gr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6838429Ab3GRMZ7YY3G7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jul 2013 14:25:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tty.gr; s=x;
        h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=P23XtTqmqZlwaqKBzwba+u7OQbO9VUYLFULHS2gtG3M=;
        b=csZJlp0SQzz6Fot6rLPWGDsPN6Jjao76esdMOBx6IXsQTBufmce8NS4cJG32E/H49V0sES0lpEanayHob4ejvJy2t/bkasFsXVJ5QjZC67t+qItV+GnXBjjUs092fCKr;
Received: from [2001:648:2001:f000:223:aeff:fe91:b5f4] (helo=serenity.void.home)
        by mail.tty.gr (envelope-from <paravoid@debian.org>)
        with esmtpsa (tls_cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80 (Debian GNU/Linux))
        id 1UznHR-0007Ok-2c; Thu, 18 Jul 2013 15:25:57 +0300
Received: from paravoid by serenity.void.home with local (Exim 4.80)
        (envelope-from <paravoid@debian.org>)
        id 1UznHQ-0005Lr-OR; Thu, 18 Jul 2013 15:25:56 +0300
Date:   Thu, 18 Jul 2013 15:25:56 +0300
From:   Faidon Liambotis <paravoid@debian.org>
To:     linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>
Subject: octeon: oops/panic with CONFIG_SERIO_I8042=y
Message-ID: <20130718122556.GA19040@tty.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <paravoid@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paravoid@debian.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi,

My goal is to run a standard Debian kernel and its octeon variant[1] on 
the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
to boot and work (octeon-ethernet patch, octeon-usb driver) but these 
are already merged 3.11 and I'll file Debian bugs to enable those 
settings appropriately.

1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon

However, when trying to boot a standard Debian kernel in the ERLite I 
get a 7s delay followed by an oops for a Data bus error on i8042_flush() 
and ending up with a panic. It looks like the kernel is built with 
CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No 
controller found" but works nevertheless.  This isn't the case with the 
ERLite; I tried 3.2 & 3.10 and got the same oops which went away as soon 
as I disabled CONFIG_SERIO_I8042.

Are there even any octeon machines with i8042 anyway? Should I request 
for the setting to be disabled irrespective of this bug?

The oops is as follows:
[    1.702762] ehci-pci: EHCI PCI platform driver
[    1.707913] usbcore: registered new interface driver usb-storage
[    8.591312] Data bus error, epc == ffffffff81446838, ra == ffffffff814467f0
[    8.598102] Oops[#1]:
[    8.600360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0 #5
[    8.606253] task: a80000041f869540 ti: a80000041f86c000 task.ti: a80000041f86c000
[    8.613706] $ 0   : 0000000000000000 0000000000000000 0000000000000000 0000000000010000
[    8.621684] $ 4   : 0000000000000000 a80000041f1bbb40 000000000000006f ffffffff816ffe60
[    8.629662] $ 8   : 0000000000000000 000000000000005b 726564206e657720 696e746572666163
[    8.637640] $12   : 0000000000000000 ffffffff8136b0dc ffffffff81790000 0000000000000000
[    8.645619] $16   : 80011a0400000064 80011a0400000000 0000000000000010 ffffffff817a0000
[    8.653597] $20   : ffffffff817a0000 0000000000000001 ffffffff81770e20 ffffffff817a0000
[    8.661575] $24   : 0000000000000004 ffffffff81790000                                  
[    8.669553] $28   : a80000041f86c000 a80000041f86fd70 0000000000000000 ffffffff814467f0
[    8.677532] Hi    : 0000000000acd49d
[    8.681088] Lo    : 0e5604189441f8e5
[    8.684661] epc   : ffffffff81446838 i8042_flush+0x80/0x118
[    8.690194]     Not tainted
[    8.692975] ra    : ffffffff814467f0 i8042_flush+0x38/0x118
[    8.698518] Status: 10008ce2	KX SX UX KERNEL EXL 
[    8.703201] Cause : 4080801c
[    8.706064] PrId  : 000d0601 (Cavium Octeon+)
[    8.710398] Modules linked in:
[    8.713439] Process swapper/0 (pid: 1, threadinfo=a80000041f86c000, task=a80000041f869540, tls=0000000000000000)
[    8.723580] Stack : ffffffff81700000 ffffffff81751158 0000000000000000 ffffffff8175f2f8
	  ffffffff817361d8 ffffffff8175f288 ffffffff81770e20 ffffffff816c0000
	  000000000000008c ffffffff817511ac 0000000000000000 ffffffff81780000
	  ffffffff81751158 ffffffff811004e0 ffffffff817361d8 0000000000000030
	  ffffffff81780000 0000000000000007 ffffffff8175f2f8 ffffffff81736b50
	  ffffffff81595080 0000000000000000 ffffffff81780000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  0000000000000000 ffffffff8159509c ffffffff81595080 0000000000000000
	  0000000000000000 ffffffff8111a124 0000000000000000 0000000000000000
	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
	  ...
[    8.788447] Call Trace:
[    8.790882] [<ffffffff81446838>] i8042_flush+0x80/0x118
[    8.796092] [<ffffffff817511ac>] i8042_init+0x54/0xf0
[    8.801118] [<ffffffff811004e0>] do_one_initcall+0xe0/0x130
[    8.806658] 
[    8.808132] 
Code: 14800017  27de0001  92020000 <305600ff> cac00003  24040032  17d2fff4  00200825  6684d338 
[    8.820195] ---[ end trace 76cca175541407ab ]---
[    8.824650] note: swapper/0[1] exited with preempt_count 1
[    8.830188] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    8.830188] 

Regards,
Faidon
