Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 14:42:59 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:59052 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902245Ab2FOMmx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jun 2012 14:42:53 +0200
Received: by laap9 with SMTP id p9so2093302laa.36
        for <multiple recipients>; Fri, 15 Jun 2012 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zgeZ+26g/xilnEqNjv1IEnbexg6NYjMWbgyN5a6+JKo=;
        b=ex5zOigP3xQB/XVHuj6D6MnEa4fBtirEljsRu0WN40fSIsBLJnNJfCToyeexjoIaiU
         hdpUlzGgeamGU29sRaDspX4BgW0R4X2oFHIrwdH+4VlcUAI6RAw7oha+ibxcvtZouJ9U
         QNhmJuwfjW11E0y1sHZ+ELixrdOFTUOoGr97FpsdogJRhciGmJYDP5lFUk3DzN2N9hDI
         5zEOW+b8ifD7u2DJdiDlJNe190QaHDXhNYQOWiAaq3M0Mfm9rT6kO4u1hALg4l3IUpMt
         bSIWw9P2r8BMHLzpiJy9lroYzOCzF8vDn7OO+2lZDpt6HIh7rxnnvWp3peolro6VTcG9
         p9iw==
MIME-Version: 1.0
Received: by 10.112.46.9 with SMTP id r9mr2506378lbm.81.1339764167764; Fri, 15
 Jun 2012 05:42:47 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Fri, 15 Jun 2012 05:42:47 -0700 (PDT)
In-Reply-To: <4FDB08AC.8010208@mvista.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-10-git-send-email-chenhc@lemote.com>
        <4FDB08AC.8010208@mvista.com>
Date:   Fri, 15 Jun 2012 20:42:47 +0800
Message-ID: <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
From:   huacai chen <chenhuacai@gmail.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33661
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

On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 15-06-2012 12:09, Huacai Chen wrote:
>
>> Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> Signed-off-by: Hua Yan<yanh@lemote.com>
>
>
>   You  should have CCed the 'linux-ide' mailing list.
>
>
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
>
>
>   No, this #ifdef'ery won't do. You should add a new board type.
All Loongson-3 based machines use AMD SB700 chipsets, add a new board
type is better than #ifdef?

>
> MBR, Sergei
