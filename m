Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 14:36:29 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43623 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903660Ab2FSMgW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 14:36:22 +0200
Received: by lbbgg6 with SMTP id gg6so5997427lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YAKtWQES9uG/stNzoJacSP9cxHQ8R6+satvrtVc7md4=;
        b=CNFHmJRMm+FTIp3HiJsZmOvW0iz9gPD7vuMirGRHJrmOGNrC7S9q8MVvVOzUsv7sp7
         siirhmd6RbYlstcTdRmSCQM4Yy+9KInCnOo0jm5jK8U99R83erfrFJYaYMgW6DdtKdTB
         x4UFkGHsCuJjmGc0MF+6vqOH1e5L8LXzamqw9wa4du2I2DFYFEMQtS2lACe7wUEyzWh2
         KKdz4xDvuy+6rmqRjGd5NbR8DrrgG374KEbapEGAVK+MNdCsCiIoQeVzajtT89EOC6q2
         U9GyZ+5m3bsXccBZQa+jN/dxhkI+gOmZnl0Fh9lXfq8mQ1byWQMmpRKDEvzx9z25a1Mg
         NJ8Q==
MIME-Version: 1.0
Received: by 10.152.46.6 with SMTP id r6mr18389787lam.7.1340109377332; Tue, 19
 Jun 2012 05:36:17 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 05:36:17 -0700 (PDT)
In-Reply-To: <4FE0717A.7070109@garzik.org>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-12-git-send-email-chenhc@lemote.com>
        <4FE0717A.7070109@garzik.org>
Date:   Tue, 19 Jun 2012 20:36:17 +0800
Message-ID: <CAAhV-H5H6E+sshfc3p8Mq-OfVZDKA+CizZgRwAtPswkYwY=7mw@mail.gmail.com>
Subject: Re: [PATCH V2 11/16] ata: Use 32-bit DMA in AHCI for Loongson-3.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Jeff Garzik <jeff@garzik.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

OK, thanks.

On Tue, Jun 19, 2012 at 8:32 PM, Jeff Garzik <jeff@garzik.org> wrote:
> On 06/19/2012 02:50 AM, Huacai Chen wrote:
>>
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index ebaf67e..3e3cfd8 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] =
>> {
>>        },
>>        [board_ahci_sb700] =    /* for SB700 and SB800 */
>>        {
>> +#ifndef CONFIG_CPU_LOONGSON3
>>                AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL),
>> +#else
>> +               AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL |
>> +                                               AHCI_HFLAG_32BIT_ONLY),
>> +#endif
>>                .flags          = AHCI_FLAG_COMMON,
>
>
>
> NAK -- the place to fix this up is ahci_init_one()
>
