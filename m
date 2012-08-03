Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 12:36:54 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:49560 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902244Ab2HCKgp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 12:36:45 +0200
Received: by laap9 with SMTP id p9so265856laa.36
        for <multiple recipients>; Fri, 03 Aug 2012 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RhzpIM9fIcmhog7W2avEQgbm7dj5JNksKUnR2ofMMjs=;
        b=jRxPGt6ir2+GGBWPX1aNAWsdD1IZ2aSYcfyfdO8Xb9JPSPosuxFrP0gO2FsANBf42J
         6XMMNW2fXjIYSQ2wkTpm670bB5zPvm8W4jkD3wcet9mzXB5NwuhYKNHxfyBAQnYp+MPF
         MGdCql/E/LQOZblhnpt1PZmoyFC/ESU7U3lhO8LLeZsjA0AL0NaKfBS3GQw0frb6Wa1K
         zkuHvzaBiMDkDxIhhFvglWTI97trLJwAxU/iXHKKNIM201/5tQAFv4DEZScQD3pyYCbK
         wx2v5KQOW9bDJHAojk1aNb4q3clmAJuht6LNYNxJwVeEfHfUNcGK8f991ujrwCxeHGWR
         KRvA==
MIME-Version: 1.0
Received: by 10.152.124.76 with SMTP id mg12mr1221760lab.10.1343990200161;
 Fri, 03 Aug 2012 03:36:40 -0700 (PDT)
Received: by 10.152.105.51 with HTTP; Fri, 3 Aug 2012 03:36:40 -0700 (PDT)
In-Reply-To: <s5hobmsqqeh.wl%tiwai@suse.de>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
        <1343977571-2292-13-git-send-email-chenhc@lemote.com>
        <s5hobmsqqeh.wl%tiwai@suse.de>
Date:   Fri, 3 Aug 2012 18:36:40 +0800
Message-ID: <CAAhV-H5ATFD7pksBkA374ShYWmvrgttGSs0vgu8QJ1F3VeRyzA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH V4 12/16] ALSA: HDA: Make hda sound card
 usable for Loongson.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel@vger.kernel.org, Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34044
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

We write these quirks on 2.6.36 some time ago, and then we port them
to 3.x (3.2, 3.3, 3.4 and 3.5). As you say, PMON (BIOS for Loongson)
doesn't set the pins correctly. Anyway, I'll try your suggestions.

On Fri, Aug 3, 2012 at 5:24 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri,  3 Aug 2012 15:06:07 +0800,
> Huacai Chen wrote:
>>
>> Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
>> this patch modify patch_conexant.c to add Lemote specific code.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> Signed-off-by: Hongliang Tao <taohl@lemote.com>
>> Signed-off-by: Hua Yan <yanh@lemote.com>
>> Cc: alsa-devel@alsa-project.org
>
> Doesn't the recent kernel work as is?  Which kernel have you tested?
> If it doesn't work with the recent kernel, it's likely just because
> the pins aren't set properly by BIOS or whatever.
>
> In general, we avoid to add this kind of quirks any longer.
> If the problem is only about the pin configuration, you can add the
> pin table in the driver.
>
>
> thanks,
>
> Takashi
>
>> ---
>>  include/linux/pci_ids.h        |    2 +
>>  sound/pci/hda/patch_conexant.c |   52 ++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 52 insertions(+), 2 deletions(-)
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
>> index 1436118..6bbac39 100644
>> --- a/sound/pci/hda/patch_conexant.c
>> +++ b/sound/pci/hda/patch_conexant.c
>> @@ -142,6 +142,7 @@ struct conexant_spec {
>>       unsigned int thinkpad:1;
>>       unsigned int hp_laptop:1;
>>       unsigned int asus:1;
>> +     unsigned int lemote:1;
>>       unsigned int pin_eapd_ctrls:1;
>>       unsigned int fixup_stereo_dmic:1;
>>
>> @@ -2280,7 +2281,7 @@ static void cxt5066_automic(struct hda_codec *codec)
>>               cxt5066_thinkpad_automic(codec);
>>       else if (spec->hp_laptop)
>>               cxt5066_hp_laptop_automic(codec);
>> -     else if (spec->asus)
>> +     else if (spec->asus || spec->lemote)
>>               cxt5066_asus_automic(codec);
>>  }
>>
>> @@ -2913,6 +2914,32 @@ static const struct hda_verb cxt5066_init_verbs_hp_laptop[] = {
>>       { } /* end */
>>  };
>>
>> +static struct hda_verb cxt5066_init_verbs_lemote[] = {
>> +     {0x14, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1: Connection index: 0 */
>> +     {0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_HP_EVENT},
>> +     {0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | CONEXANT_MIC_EVENT},
>> +
>> +     /* DAC2: unused */
>> +     {0x11, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>> +
>> +     /* ADC2, ADC3: unused */
>> +     {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
>> +     {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
>> +     {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
>> +     {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
>> +     {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
>> +     {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
>> +     {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
>> +     {0x16, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
>> +
>> +     /* Disable digital microphone port */
>> +     {0x23, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
>> +
>> +     /* Disable SPDIF */
>> +     {0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0},
>> +     { } /* end */
>> +};
>> +
>>  /* initialize jack-sensing, too */
>>  static int cxt5066_init(struct hda_codec *codec)
>>  {
>> @@ -2950,6 +2977,8 @@ enum {
>>       CXT5066_THINKPAD,       /* Lenovo ThinkPad T410s, others? */
>>       CXT5066_ASUS,           /* Asus K52JU, Lenovo G560 - Int mic at 0x1a and Ext mic at 0x1b */
>>       CXT5066_HP_LAPTOP,      /* HP Laptop */
>> +     CXT5066_LEMOTE_A1004,   /* Lemote Laptop A1004 */
>> +     CXT5066_LEMOTE_A1205,   /* Lemote All-In-One A1205 */
>>       CXT5066_AUTO,           /* BIOS auto-parser */
>>       CXT5066_MODELS
>>  };
>> @@ -2963,6 +2992,8 @@ static const char * const cxt5066_models[CXT5066_MODELS] = {
>>       [CXT5066_THINKPAD]      = "thinkpad",
>>       [CXT5066_ASUS]          = "asus",
>>       [CXT5066_HP_LAPTOP]     = "hp-laptop",
>> +     [CXT5066_LEMOTE_A1004]  = "lemote-laptop-a1004",
>> +     [CXT5066_LEMOTE_A1205]  = "lemote-aio-a1205",
>>       [CXT5066_AUTO]          = "auto",
>>  };
>>
>> @@ -2995,6 +3026,8 @@ static const struct snd_pci_quirk cxt5066_cfg_tbl[] = {
>>       SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo U350", CXT5066_ASUS),
>>       SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G560", CXT5066_ASUS),
>>       SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G565", CXT5066_AUTO),
>> +     SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2011, "Lemote A1004", CXT5066_LEMOTE_A1004),
>> +     SND_PCI_QUIRK(PCI_VENDOR_ID_LEMOTE, 0x2012, "Lemote A1205", CXT5066_LEMOTE_A1205),
>>       SND_PCI_QUIRK(0x1b0a, 0x2092, "CyberpowerPC Gamer Xplorer N57001", CXT5066_AUTO),
>>       {}
>>  };
>> @@ -3075,7 +3108,22 @@ static int patch_cxt5066(struct hda_codec *codec)
>>               spec->port_d_mode = 0;
>>               spec->mic_boost = 3; /* default 30dB gain */
>>               break;
>> -
>> +     case CXT5066_LEMOTE_A1004:
>> +     case CXT5066_LEMOTE_A1205:
>> +             codec->patch_ops.init = cxt5066_init;
>> +             codec->patch_ops.unsol_event = cxt5066_unsol_event;
>> +             spec->init_verbs[spec->num_init_verbs] =
>> +                     cxt5066_init_verbs_lemote;
>> +             spec->num_init_verbs++;
>> +             spec->lemote = 1;
>> +             spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
>> +             spec->mixers[spec->num_mixers++] = cxt5066_mixers;
>> +             /* no S/PDIF out */
>> +             /* input source automatically selected */
>> +             spec->input_mux = NULL;
>> +             spec->port_d_mode = 0;
>> +             spec->mic_boost = 3; /* default 30dB gain */
>> +             break;
>>       case CXT5066_OLPC_XO_1_5:
>>               codec->patch_ops.init = cxt5066_olpc_init;
>>               codec->patch_ops.unsol_event = cxt5066_olpc_unsol_event;
>> --
>> 1.7.7.3
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
