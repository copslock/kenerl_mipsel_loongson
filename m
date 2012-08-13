Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2012 10:22:40 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:48521 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903386Ab2HMIWd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2012 10:22:33 +0200
Received: by lbbgf7 with SMTP id gf7so1781931lbb.36
        for <multiple recipients>; Mon, 13 Aug 2012 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pb+Fq0ar/crcXo8bjmqbHTUkxYwkMTPldTO1aut8Hmc=;
        b=b+hXRKcUobl6MWSnx9Ax2e51Kd8Xg0kFCyXrTX7CRyI75t/aF/AgTZxsmjXFWLpzl/
         keDqiVvtHB71zEi8lXMznDaF6cVqFLkTmn6go0HMcL+xKxuzJdMAGRmCC9xt6pB1gejo
         dVWKkTKDWkVOILNKuOUQv057cXXqeqzNjEjmCF7d+8kY5TjTnqST1fF2k+H8oHE5SPWO
         IK1OvWCf4id775XFYmL8J0xKClShKqjzGiCoLi4bC/DuuHAoljXvJXALQ5/HW7yoOz57
         WVei7WU8QR12km6iD4wG6IJAOcBz7m+OD93Xw+slt9lq+JrVugDM29DW2I98wYyJcT/C
         ldPQ==
MIME-Version: 1.0
Received: by 10.112.27.71 with SMTP id r7mr5976661lbg.73.1344846147702; Mon,
 13 Aug 2012 01:22:27 -0700 (PDT)
Received: by 10.152.105.51 with HTTP; Mon, 13 Aug 2012 01:22:27 -0700 (PDT)
In-Reply-To: <s5hlihjw7a2.wl%tiwai@suse.de>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
        <1344677543-22591-15-git-send-email-chenhc@lemote.com>
        <s5hlihjw7a2.wl%tiwai@suse.de>
Date:   Mon, 13 Aug 2012 16:22:27 +0800
Message-ID: <CAAhV-H6DoZ2qCAO=vZiCLXLmxv4-CLZtWRtEvWhuR6im2r3PDg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V5 14/18] ALSA: HDA: Make hda sound card
 usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel@vger.kernel.org, Hongliang Tao <taohl@lemote.com>,
        Jie Chen <chenj@lemote.com>, Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34123
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

OK, I will improve the code.

On Mon, Aug 13, 2012 at 4:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 11 Aug 2012 17:32:19 +0800,
> Huacai Chen wrote:
>>
>> Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
>> this patch modify patch_conexant.c to add Lemote specific code.
>>
>> Signed-off-by: Jie Chen <chenj@lemote.com>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: alsa-devel@alsa-project.org
>> ---
>>  include/linux/pci_ids.h        |    2 ++
>>  sound/pci/hda/patch_conexant.c |   24 ++++++++++++++++++++++++
>>  2 files changed, 26 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index fc35260..b28270e 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2918,3 +2918,5 @@
>>  #define PCI_DEVICE_ID_XEN_PLATFORM   0x0001
>>
>>  #define PCI_VENDOR_ID_OCZ            0x1b85
>> +
>> +#define PCI_VENDOR_ID_LEMOTE         0x1c06
>> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
>> index 1436118..b7de368 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -4414,6 +4414,8 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
>>  enum {
>>       CXT_PINCFG_LENOVO_X200,
>>       CXT_PINCFG_LENOVO_TP410,
>> +     CXT_PINCFG_LEMOTE_A1004,
>> +     CXT_PINCFG_LEMOTE_A1205,
>>       CXT_FIXUP_STEREO_DMIC,
>>  };
>>
>> @@ -4441,6 +4443,18 @@ static const struct hda_pintbl cxt_pincfg_lenovo_tp410[] = {
>>       {}
>>  };
>>
>> +/* Lemote A1004/A1205 with cxt5066 */
>> +static const struct hda_pintbl cxt_pincfg_lemote[] = {
>> +     { 0x1a, 0x90a10020 }, /* Internal mic */
>> +     { 0x1b, 0x03a11020 }, /* External mic */
>> +     { 0x1d, 0x400101f0 }, /* Not used */
>> +     { 0x1e, 0x40a701f0 }, /* Not used */
>> +     { 0x20, 0x404501f0 }, /* Not used */
>> +     { 0x22, 0x404401f0 }, /* Not used */
>> +     { 0x23, 0x40a701f0 }, /* Not used */
>> +     {}
>> +};
>> +
>>  static const struct hda_fixup cxt_fixups[] = {
>>       [CXT_PINCFG_LENOVO_X200] = {
>>               .type = HDA_FIXUP_PINS,
>> @@ -4450,6 +4464,14 @@ static const struct hda_fixup cxt_fixups[] = {
>>               .type = HDA_FIXUP_PINS,
>>               .v.pins = cxt_pincfg_lenovo_tp410,
>>       },
>> +     [CXT_PINCFG_LEMOTE_A1004] = {
>> +             .type = HDA_FIXUP_PINS,
>> +             .v.pins = cxt_pincfg_lemote,
>> +     },
>> +     [CXT_PINCFG_LEMOTE_A1205] = {
>> +             .type = HDA_FIXUP_PINS,
>> +             .v.pins = cxt_pincfg_lemote,
>> +     },
>
> Well, if both point to the same pin configuration, there is no merit
> to create two distinct fixup types.
> Just create CXT_PINCFG_LEMOTE_A1X05, then pass it in your both device
> entries.
>
>
>>       [CXT_FIXUP_STEREO_DMIC] = {
>>               .type = HDA_FIXUP_FUNC,
>>               .v.func = cxt_fixup_stereo_dmic,
>> @@ -4467,6 +4489,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
>>       SND_PCI_QUIRK(0x17aa, 0x215f, "Lenovo T510", CXT_PINCFG_LENOVO_TP410),
>>       SND_PCI_QUIRK(0x17aa, 0x21ce, "Lenovo T420", CXT_PINCFG_LENOVO_TP410),
>>       SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
>> +     SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
>> +     SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
>>       SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
>>       SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
>
> Don't put entries suddenly in the middle of others.
> As you can see, the list is sorted in the order of id numbers.
>
> Also, in this case, we prefer having numbers over PCI_* literals.
> It's easier to check through the table in the end.
>
>
> thanks,
>
> Takashi
