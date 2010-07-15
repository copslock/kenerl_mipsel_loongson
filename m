Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 09:52:39 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:42392 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492117Ab0GOHwe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jul 2010 09:52:34 +0200
Received: by qwe4 with SMTP id 4so166441qwe.36
        for <linux-mips@linux-mips.org>; Thu, 15 Jul 2010 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nz4nClMTlrUAa9NyIWM6MAYjbTbTTFiLyU1+Mh7iUw0=;
        b=N1DuUZPWvAQNUMlYLrNRVVGkZVYcIvbQ6124pWW94LekdgDJUBpx6r/NsYvKq1FDZm
         u1tg1+TzJIwrqX2PGWhbazoiPSPWIDhQCB/P3E1DEWGVn0AI4PVRwY6+tEsoXRJlC+Uu
         qSpzytxfZBO+Hri7Cy8NGBwgPrHxnbS1ev4kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WUvoV4K9aec92q5DmgPbozoIRRsxyp8XiQVMQ6O4rWlzWyZMSLkO/jcjQ4iDNY9Wzo
         lydTo0cHeuG6a4OxfG/QgnDWlrOFtzhq8wJRSS05rqS8Kq7nK5hh4nBMD3xap6cNCZjY
         fPkb8Zxc4S8P9CoEgLyzO636TKStzheGYHTVM=
MIME-Version: 1.0
Received: by 10.224.78.194 with SMTP id m2mr2352369qak.19.1279180346519; Thu, 
        15 Jul 2010 00:52:26 -0700 (PDT)
Received: by 10.229.51.7 with HTTP; Thu, 15 Jul 2010 00:52:26 -0700 (PDT)
In-Reply-To: <AANLkTileSQlDee5J_SVHAQCE3QoEt5tMdGp-rGmwPpi1@mail.gmail.com>
References: <AANLkTik9OHNXHE1l6bKixAG2ZqrYiswZCAKj-V5L8PGe@mail.gmail.com>
        <AANLkTileSQlDee5J_SVHAQCE3QoEt5tMdGp-rGmwPpi1@mail.gmail.com>
Date:   Thu, 15 Jul 2010 15:52:26 +0800
Message-ID: <AANLkTimvA9hQj1mc_2Cwb5qFwq4dxozLcZLGv_ZT6iKx@mail.gmail.com>
Subject: Re: [Kernel Oops] Cavium Octeon, linux 2.6.34
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I tried to find the cause of this bug, finally, I've found that it is
introduced by a patch in linux-2.6.34-rc6.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6de9400250f95f82da432c28b9b43823f4154c58

commit 6de9400250f95f82da432c28b9b43823f4154c58
Author: Jörn Engel <joern@logfs.org>
Date:   Thu Apr 22 14:11:43 2010 +0200

    Fix JFFS2 sync silent failure

    JFFS2 does not appear to set s_bdi anywhere.  And as of 32a88aa1,
    __sync_filesystem() will return 0 if s_bdi is not set.  As a result,
    sync_fs() is never called for jffs2 and whatever remains in the wbuf
    will not make it to the device.

    Fix that up by assigning the mtd bdi.

    Signed-off-by: Jörn Engel <joern@logfs.org>
    Acked-By: David Woodhouse <David.Woodhouse@intel.com>
    Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

revert this patch, the problem disappeared.

fix this problem is beyond my knowledge, but I think it may be caused
by memory barrier implementation on cavium octeon cpu.


On Tue, Jul 13, 2010 at 11:40 AM, Zhuang Yuyao <mlistz@gmail.com> wrote:
> This bug still exists in linux kernel 2.6.34.1.
>
> / # reboot
> CPU 1 Unable to handle kernel paging request at virtual address
> 0000005781657c00, epc == ffffffff8115f2b0, ra == ffffffff8115f3a0
> Oops[#1]:
> Cpu 1
> $ 0   : 0000000000000000 ffffffff81640008 002bffffffc0af58 015ffffffe057ac0
> $ 4   : ffffffe057afee00 0000000000000000 0000005781657c00 00000057ffffff80
> $ 8   : 0000000000000014 ffffffff815d0000 0000000000000001 0000000000008000
> $12   : a8000000cbb7ffe0 0000000000008c00 a8000000d0cc8000 0000000000000000
> $16   : ffffffff815ebfb8 ffffffff815ec0a0 ffffffff815d0000 ffffffff815ec100
> $20   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> $24   : 0000000000000000 0000000000000000
> $28   : a8000000cbb7c000 a8000000cbb7fdc0 0000000000000000 ffffffff8115f3a0
> Hi    : 000000000000000a
> Lo    : 92f53dde60000000
> epc   : ffffffff8115f2b0 bit_waitqueue+0x30/0xd0
>    Not tainted
> ra    : ffffffff8115f3a0 wake_up_bit+0x18/0x38
> Status: 10108ce3    KX SX UX KERNEL EXL IE
> Cause : 00800008
> BadVA : 0000005781657c00
> PrId  : 000d0409 (Cavium Octeon+)
> Modules linked in:
> Process flush-mtd-unmap (pid: 1307, threadinfo=a8000000cbb7c000,
> task=a8000000d0ca4040, tls=0000000000000000)
> Stack : 0000000000000000 ffffffff815d0000 ffffffff815ebf90 ffffffff8119ce70
>        0000000000000000 a8000000d0ccbca0 ffffffff8119cde8 ffffffff815ec0a0
>        0000000000000000 ffffffff8115eee0 0000000000000000 0000000000000000
>        00000000dead4ead ffffffff00000000 ffffffffffffffff a8000000cbb7fe38
>        a8000000cbb7fe38 a8000000044d9200 0000000000000000 0000000000000000
>        0000000000000000 ffffffff81119368 a8000000044c9200 0000000000000000
>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>        a8000000d0ccbca0 ffffffff8115ee58 0000000000000000 0000000000000000
>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>        ...
> Call Trace:
> [<ffffffff8115f2b0>] bit_waitqueue+0x30/0xd0
> [<ffffffff8115f3a0>] wake_up_bit+0x18/0x38
> [<ffffffff8119ce70>] bdi_start_fn+0x88/0x108
> [<ffffffff8115eee0>] kthread+0x88/0x90
> [<ffffffff81119368>] kernel_thread_helper+0x10/0x18
>
>
> Code: 000219b8  00c7302d  000210f8 <dcc60000> 0062102f  2403fffc
> 24070680  00c31824  00a42025
> Disabling lock debugging due to kernel taint
>
> On Thu, Jul 1, 2010 at 1:47 PM, Zhuang Yuyao <mlistz@gmail.com> wrote:
>> Hi,
>>
>> While the 2.6.34 kernel works fine on loading and running, but it
>> emits oops everytime while rebooting.
>>
>> / # /sbin/reboot
>> CPU 2 Unable to handle kernel paging request at virtual address
>> 0000005781657c00, epc == ffffffff8115f290, ra == ffffffff8115f380
>> Oops[#1]:
>> Cpu 2
>> $ 0   : 0000000000000000 0000000000000018 002bffffffc0af58 015ffffffe057ac0
>> $ 4   : ffffffe057afee00 0000000000000000 0000005781657c00 00000057ffffff80
>> $ 8   : 000000182f2de56b 0000000000000000 0000000000000001 0000000000008000
>> $12   : 0000000000000000 ffffffff81105d44 0000000000000000 0000000000000000
>> $16   : ffffffff815ebfb8 ffffffff815ec0a0 ffffffff815d0000 ffffffff815ec100
>> $20   : 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> $24   : 0000000000000000 ffffffff811152b8
>> $28   : a8000000bd180000 a8000000bd183dc0 0000000000000000 ffffffff8115f380
>> Hi    : 0000000000000000
>> Lo    : 0000000000000000
>> epc   : ffffffff8115f290 bit_waitqueue+0x30/0xd0
>>    Not tainted
>> ra    : ffffffff8115f380 wake_up_bit+0x18/0x38
>> Status: 10108ce3    KX SX UX KERNEL EXL IE
>> Cause : 00800008
>> BadVA : 0000005781657c00
>> PrId  : 000d0409 (Cavium Octeon+)
>> Modules linked in:
>> Process flush-mtd-unmap (pid: 1357, threadinfo=a8000000bd180000,
>> task=a8000000d0256040, tls=0000000000000000)
>> Stack : 0000000000000000 ffffffff815d0000 ffffffff815ebf90 ffffffff8119ce18
>>        0000000000000000 a8000000d0cc7ca0 ffffffff8119cd90 ffffffff815ec0a0
>>        0000000000000000 ffffffff8115eec0 00000000beb2b997 0000000041b4b962
>>        00000000dead4ead ffffffffecbeaa23 ffffffffffffffff a8000000bd183e38
>>        a8000000bd183e38 a8000000044e9200 0000000000000000 0000000000000000
>>        0000000000000000 ffffffff81119348 a8000000044d9200 0000000000000000
>>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>        a8000000d0cc7ca0 ffffffff8115ee38 0000000000000000 0000000000000000
>>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>        0000000000000000 0000000000000000 0000000000000000 0000000000000000
>>        ...
>> Call Trace:
>> [<ffffffff8115f290>] bit_waitqueue+0x30/0xd0
>> [<ffffffff8115f380>] wake_up_bit+0x18/0x38
>> [<ffffffff8119ce18>] bdi_start_fn+0x88/0x108
>> [<ffffffff8115eec0>] kthread+0x88/0x90
>> [<ffffffff81119348>] kernel_thread_helper+0x10/0x18
>>
>>
>> Code: 000219b8  00c7302d  000210f8 <dcc60000> 0062102f  2403fffc
>> 24070680  00c31824  00a42025
>> Disabling lock debugging due to kernel taint
>>
>> Is it a known and fixed bug?
>>
>> Best regards,
>>
>> Zhuang Yuyao
>>
>
