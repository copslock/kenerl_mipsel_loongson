Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Mar 2010 10:31:53 +0100 (CET)
Received: from qw-out-1920.google.com ([74.125.92.145]:10376 "EHLO
        qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491852Ab0CVJbt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Mar 2010 10:31:49 +0100
Received: by qw-out-1920.google.com with SMTP id 4so751135qwk.54
        for <linux-mips@linux-mips.org>; Mon, 22 Mar 2010 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=spf8Mntd4dSkC+mNF4NOvaZfr9VQwe9kIiCm2+2I+Sg=;
        b=Y19N5f0XOdXe/hQxxLjadB84v1l1Kbb5NPm+t8juTU0IckQLJV+HmYFlboTtlR1718
         o5t9rNKT/pjyHLnpL/C8AcST0pEY6jSTcOd5q/LkyXCEr1HEz3ePDGgZiX3a/n1sdh7c
         us+QszZ1ecOs98cDodeHhTtHN9MYIbalmRiOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jMqh9CT95RjMzegNK1vcEXd15N8EMdF4w42RReQ/1lIXoienFIVuPW4pbCF4tq+CDM
         HcSvb1js6yhUBUE2Tg1OoSxew7R4iE5nNcob8Ag9nw1bsdKf6Q2uif/85XmdkzZg722w
         HSbvAfzQzSc1xZf5uS3SN7jXX9pIXjHUHDots=
MIME-Version: 1.0
Received: by 10.229.112.2 with SMTP id u2mr2260202qcp.0.1269250308589; Mon, 22 
        Mar 2010 02:31:48 -0700 (PDT)
In-Reply-To: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
References: <e732b6801003220001m7e08bbf7w20ba62d42f30a190@mail.gmail.com>
Date:   Mon, 22 Mar 2010 17:31:48 +0800
Message-ID: <e732b6801003220231i52a87119yd4361b68c07460b9@mail.gmail.com>
Subject: Re: [BUG?] cavium cn56xx and dma_map_single warning
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mlistz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips

Here are some additional information.I added a dump_stack() where the
warning happened and changed pr_warning() to panic(). here is the
output. I am using linux 2.6.32.9.

Is it scsi drivers where i should look into, to make the scsi  do not
request for memory reserved by octeon?

[<ffffffff8110e718>] dump_stack+0x8/0x34
[<ffffffff811144ec>] octeon_map_dma_mem+0x4dc/0x538
[<ffffffff81126a50>] dma_map_sg+0xa0/0xe0
[<ffffffff812e1c98>] scsi_dma_map+0x40/0x50
[<ffffffff8130297c>] aac_build_sgraw+0x44/0x1a0
[<ffffffff81302cd0>] aac_read_raw_io+0x98/0x120
[<ffffffff81300f50>] aac_scsi_cmd+0xb48/0x14b8
[<ffffffff812ff39c>] aac_queuecommand+0x94/0xa8
[<ffffffff812d9c74>] scsi_dispatch_cmd+0x104/0x260
[<ffffffff812dff94>] scsi_request_fn+0x374/0x430
[<ffffffff81279e48>] generic_unplug_device+0x38/0x50
[<ffffffff8118328c>] sync_page+0x4c/0x70
[<ffffffff811832c0>] sync_page_killable+0x10/0x48
[<ffffffff8110fb2c>] __wait_on_bit_lock+0xcc/0x158
[<ffffffff811831b0>] __lock_page_killable+0x50/0x60
[<ffffffff8118549c>] generic_file_aio_read+0x444/0x6c0
[<ffffffff811b81dc>] do_sync_read+0xbc/0x120
[<ffffffff811b8fc4>] vfs_read+0xb4/0x178
[<ffffffff811b9170>] SyS_read+0x48/0xa0
[<ffffffff81102bc4>] handle_sys64+0x44/0x60

Kernel panic - not syncing: dma_map_single: conflict 0xffc00000


On Mon, Mar 22, 2010 at 3:01 PM, Zhuang Yuyao <mlistz@gmail.com> wrote:
> Hi,
>
> I've got a strange dma error on my cavium cn56xx board.
>
> ......
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfbb8f000-0xfbb8ffff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb2ef000-0xfb2f0fff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb3de000-0xfb3defff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfb3dd000-0xfb3ddfff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfac28000-0xfac29fff
> dma_map_single: Warning: Mapping memory address that might conflict
> with devices 0xfad1a000-0xfad1bfff
> .....
>
> this error appeared when I plugged 4G or 8G ram on the board, if there
> is only 2G ram on the board, the error never happened.
>
> an adaptec 3405 pci-e raid card is plugged on the board, and a
> harddisk attached. the program i am running is a postgresql server
> with more than 20 million record, so do a count(*) will let postgresql
> consume almost all of the available memory. while there is 4G ram, the
> 'free' command reported that the free memory is below 18M.
>
> then the error kept printing on the console for a while, then kernel panic.
>
> the warning message is come from arch/mips/cavium-octeon/dma-octeon.c
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/mips/cavium-octeon/dma-octeon.c;h=be531ec1f2064b590b58dfe8b4db4f5534999bab;hb=HEAD
>
> i tried several raid card from different producer, including LSI and
> Adaptec. the same error always happened while there are more than or
> equal to 4G memory on the board.
>
> Would you please give some advice on this issue? any help will be appreciated.
>
> Thanks.
>
> Zhuang Yuyao
>
