Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 19:32:48 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53966 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6836140Ab3GRQ3EC8-OW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 18:29:04 +0200
Received: by mail-pa0-f44.google.com with SMTP id lj1so3418329pab.17
        for <linux-mips@linux-mips.org>; Thu, 18 Jul 2013 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KNzychshp3VOhp5p8/moN01wISkTnjo0JiiWc8RnXUo=;
        b=YnSIiYntpTpbGol8z5h9Mr3nJmT4VZ4HgDswCdaWkJVNwhpUi6C2HuarTrpjkvzACG
         Fi4XvGLeXt+utdpgIfU/oQgrNP++wY+G6HuPBSll62gpVuz3fwQwtLGfNttfChpUcuyZ
         H89IOHpJG1HCQnjpxabiDFOwXvkLS9DuIRvGkMLrXMDZ0UU44UxUcK9+RqbmUa4t3o4x
         /Syl45/ycLeqasjeCw9lCK9vmbvP2yFGzGXQyYbjit7n8C1qQ/P6AMp9cXOpPd1jqodf
         WCT1qXr5GHpvT21dC1npncuqMIA/Nm/gLPaaM3TeAggW0DBMIzLlEVch9ag+xPLywB49
         LI8Q==
X-Received: by 10.66.102.41 with SMTP id fl9mr14066424pab.169.1374164936910;
        Thu, 18 Jul 2013 09:28:56 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id zf3sm17605181pac.9.2013.07.18.09.28.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 09:28:56 -0700 (PDT)
Message-ID: <51E817C6.3030706@gmail.com>
Date:   Thu, 18 Jul 2013 09:28:54 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Faidon Liambotis <paravoid@debian.org>
CC:     linux-mips@linux-mips.org
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
References: <20130718122556.GA19040@tty.gr>
In-Reply-To: <20130718122556.GA19040@tty.gr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 07/18/2013 05:25 AM, Faidon Liambotis wrote:
> Hi,
>
> My goal is to run a standard Debian kernel and its octeon variant[1] on
> the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
> to boot and work (octeon-ethernet patch, octeon-usb driver) but these
> are already merged 3.11 and I'll file Debian bugs to enable those
> settings appropriately.
>
> 1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon
>
> However, when trying to boot a standard Debian kernel in the ERLite I
> get a 7s delay followed by an oops for a Data bus error on i8042_flush()
> and ending up with a panic. It looks like the kernel is built with
> CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No
> controller found" but works nevertheless.  This isn't the case with the
> ERLite; I tried 3.2 & 3.10 and got the same oops which went away as soon
> as I disabled CONFIG_SERIO_I8042.
>
> Are there even any octeon machines with i8042 anyway? Should I request
> for the setting to be disabled irrespective of this bug?

Yes.  There is a rare board called NAC38 that was produced by ASUS in a 
1U chassis.  I don't think it is important to support this, so the best 
thing seems to be not to enable SERIO_I8042

David Daney

>
> The oops is as follows:
> [    1.702762] ehci-pci: EHCI PCI platform driver
> [    1.707913] usbcore: registered new interface driver usb-storage
> [    8.591312] Data bus error, epc == ffffffff81446838, ra ==
> ffffffff814467f0
> [    8.598102] Oops[#1]:
> [    8.600360] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.10.0 #5
> [    8.606253] task: a80000041f869540 ti: a80000041f86c000 task.ti:
> a80000041f86c000
> [    8.613706] $ 0   : 0000000000000000 0000000000000000
> 0000000000000000 0000000000010000
> [    8.621684] $ 4   : 0000000000000000 a80000041f1bbb40
> 000000000000006f ffffffff816ffe60
> [    8.629662] $ 8   : 0000000000000000 000000000000005b
> 726564206e657720 696e746572666163
> [    8.637640] $12   : 0000000000000000 ffffffff8136b0dc
> ffffffff81790000 0000000000000000
> [    8.645619] $16   : 80011a0400000064 80011a0400000000
> 0000000000000010 ffffffff817a0000
> [    8.653597] $20   : ffffffff817a0000 0000000000000001
> ffffffff81770e20 ffffffff817a0000
> [    8.661575] $24   : 0000000000000004 ffffffff81790000 [    8.669553]
> $28   : a80000041f86c000 a80000041f86fd70 0000000000000000 ffffffff814467f0
> [    8.677532] Hi    : 0000000000acd49d
> [    8.681088] Lo    : 0e5604189441f8e5
> [    8.684661] epc   : ffffffff81446838 i8042_flush+0x80/0x118
> [    8.690194]     Not tainted
> [    8.692975] ra    : ffffffff814467f0 i8042_flush+0x38/0x118
> [    8.698518] Status: 10008ce2    KX SX UX KERNEL EXL [    8.703201]
> Cause : 4080801c
> [    8.706064] PrId  : 000d0601 (Cavium Octeon+)
> [    8.710398] Modules linked in:
> [    8.713439] Process swapper/0 (pid: 1, threadinfo=a80000041f86c000,
> task=a80000041f869540, tls=0000000000000000)
> [    8.723580] Stack : ffffffff81700000 ffffffff81751158
> 0000000000000000 ffffffff8175f2f8
>        ffffffff817361d8 ffffffff8175f288 ffffffff81770e20 ffffffff816c0000
>        000000000000008c ffffffff817511ac 0000000000000000 ffffffff81780000
>        ffffffff81751158 ffffffff811004e0 ffffffff817361d8 0000000000000030
>        ffffffff81780000 0000000000000007 ffffffff8175f2f8 ffffffff81736b50
>        ffffffff81595080 0000000000000000 ffffffff81780000 0000000000000000
>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>        0000000000000000 ffffffff8159509c ffffffff81595080 0000000000000000
>        0000000000000000 ffffffff8111a124 0000000000000000 0000000000000000
>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>        ...
> [    8.788447] Call Trace:
> [    8.790882] [<ffffffff81446838>] i8042_flush+0x80/0x118
> [    8.796092] [<ffffffff817511ac>] i8042_init+0x54/0xf0
> [    8.801118] [<ffffffff811004e0>] do_one_initcall+0xe0/0x130
> [    8.806658] [    8.808132] Code: 14800017  27de0001  92020000
> <305600ff> cac00003  24040032  17d2fff4  00200825  6684d338 [
> 8.820195] ---[ end trace 76cca175541407ab ]---
> [    8.824650] note: swapper/0[1] exited with preempt_count 1
> [    8.830188] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    8.830188]
> Regards,
> Faidon
>
>
