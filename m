Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 12:47:54 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50213 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903616Ab2FSKrs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Jun 2012 12:47:48 +0200
Received: by lbbgg6 with SMTP id gg6so5869860lbb.36
        for <multiple recipients>; Tue, 19 Jun 2012 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dmQgMqd9S3h+GkgiKoOk5y/XWh9BZWex9Cs6pgE0nfc=;
        b=VaGsfgVSxmflnhSHl5fXicnIUUNiZKWe2+PzLo2cc88rvQFRFHIR3WXw/r1XD/Uuc5
         1NGxofgejELQkIaLeK1rY7rQk9QGG8W4fJj3ORwAG55VHD98Qqj2mdGLs9Dn5rjxPDGj
         wnBxMnAtY4VtzmMKJDzjIgnRP9pO5kjE5KWoc63UAlI/2GQgiUp4RxDfpRe1+/el+VyL
         4AciEOmHi+0aLMJm/mgTMDesMbhFZNs+mUdRGJaNZDimlluLt6w5/vafVSuVTNC/wS+x
         +OrNFB5nGMaqP0AK3KljZtv6wcFHOYj69DtA1FvtW5IdXzJss527UAQCAMQ7OqKOx9I5
         KuPg==
MIME-Version: 1.0
Received: by 10.152.148.199 with SMTP id tu7mr17999882lab.43.1340102862774;
 Tue, 19 Jun 2012 03:47:42 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Tue, 19 Jun 2012 03:47:42 -0700 (PDT)
In-Reply-To: <s5hd34vlkin.wl%tiwai@suse.de>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
        <1340088624-25550-14-git-send-email-chenhc@lemote.com>
        <s5hd34vlkin.wl%tiwai@suse.de>
Date:   Tue, 19 Jun 2012 18:47:42 +0800
Message-ID: <CAAhV-H4ALZMW21=6DfGms2wjfuBzKLHrpgV28he8PG77YWbqYA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V2 13/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33718
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

Thanks, I'll improve the patch.

On Tue, Jun 19, 2012 at 5:26 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 19 Jun 2012 14:50:21 +0800,
> Huacai Chen wrote:
>>
>> Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
>> this patch make it usable:
>> 1, Use 32-bit DMA as a workaround (Loongson has a hardware bug that it
>>    doesn't support DMA address above 4GB).
>> 2, Modify patch_conexant.c to add Lemote specific code.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: alsa-devel@alsa-project.org
>> ---
>>  include/linux/pci_ids.h        |    2 +
>>  sound/pci/hda/hda_intel.c      |    5 ++++
>>  sound/pci/hda/patch_conexant.c |   52 ++++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index ab741b0..d8b0a52 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2906,3 +2906,5 @@
>>  #define PCI_DEVICE_ID_XEN_PLATFORM   0x0001
>>
>>  #define PCI_VENDOR_ID_OCZ            0x1b85
>> +
>> +#define PCI_VENDOR_ID_LEMOTE         0x1c06
>
> As Clemens already suggested, please split your patch.  The addition
> of PCI ID, addition of the workaround in HD-audio controller code, and
> the modification to Conexant codec code are all different things.
>
>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index 2b6392b..2b73ed4 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -3013,6 +3013,11 @@ static int DELAYED_INIT_MARK azx_first_init(struct azx *chip)
>>               gcap &= ~ICH6_GCAP_64OK;
>>       }
>>
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +     /* Workaround: Loongson 3 doesn't support 64-bit DMA */
>> +     gcap &= ~ICH6_GCAP_64OK;
>> +#endif
>
> Where is CONFIG_CPU_LOONGSON3 defined at all?
> This isn't found in the upstream Linus or linux-next tree.
>
>
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
>> index 3acb582..1c8dfb9 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -142,6 +142,7 @@ struct conexant_spec {
>>       unsigned int thinkpad:1;
>>       unsigned int hp_laptop:1;
>>       unsigned int asus:1;
>> +     unsigned int lemote:1;
>
> In general, we don't accept such a static quirk any longer unless a
> special reason is given.  Doesn't the auto-parser work for you?
>
>
> thanks,
>
> Takashi
