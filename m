Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 11:09:50 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:46509 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903451Ab2HQJJm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2012 11:09:42 +0200
Received: from relay2.suse.de (unknown [195.135.220.254])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 1A3FFA329D;
        Fri, 17 Aug 2012 11:09:36 +0200 (CEST)
Date:   Fri, 17 Aug 2012 11:09:33 +0200
Message-ID: <s5hy5ldvq9e.wl%tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        alsa-devel@alsa-project.org, Zhangjin Wu <wuzhangjin@gmail.com>,
        Hua Yan <yanh@lemote.com>, Fuxin Zhang <zhangfx@lemote.com>,
        linux-kernel@vger.kernel.org, Hongliang Tao <taohl@lemote.com>,
        Jie Chen <chenj@lemote.com>
Subject: Re: [alsa-devel] [PATCH V6 12/15] ALSA: HDA: Make hda sound card usable        for Loongson
In-Reply-To: <1345193015-3024-13-git-send-email-chenhc@lemote.com>
References: <1345193015-3024-1-git-send-email-chenhc@lemote.com>
        <1345193015-3024-13-git-send-email-chenhc@lemote.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/24.1
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=US-ASCII
X-archive-position: 34250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiwai@suse.de
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

At Fri, 17 Aug 2012 16:43:32 +0800,
Huacai Chen wrote:
> 
> Lemote A1004(Laptop) and A1205(All-In-One) use Conexant's hda codec,
> this patch modify patch_conexant.c to add Lemote specific code.
> 
> Both A1004 and A1205 use the same pin configurations, but A1004 need
> to increase the default boost of internal mic.
> 
> Signed-off-by: Jie Chen <chenj@lemote.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> Cc: alsa-devel@alsa-project.org

Looks good.
	Reviewed-by: Takashi Iwai <tiwai@suse.de>

Should I apply it to sound git tree or all patches will go through
mips tree?


thanks,

Takashi

> ---
>  sound/pci/hda/patch_conexant.c |   44 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 5e22a8f..3cc265e 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -4408,7 +4408,10 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
>  enum {
>  	CXT_PINCFG_LENOVO_X200,
>  	CXT_PINCFG_LENOVO_TP410,
> +	CXT_PINCFG_LEMOTE_A1004,
> +	CXT_PINCFG_LEMOTE_A1205,
>  	CXT_FIXUP_STEREO_DMIC,
> +	CXT_FIXUP_INC_MIC_BOOST,
>  };
>  
>  static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
> @@ -4418,6 +4421,19 @@ static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
>  	spec->fixup_stereo_dmic = 1;
>  }
>  
> +static void cxt5066_increase_mic_boost(struct hda_codec *codec,
> +				   const struct hda_fixup *fix, int action)
> +{
> +	if (action != HDA_FIXUP_ACT_PRE_PROBE)
> +		return;
> +
> +	snd_hda_override_amp_caps(codec, 0x17, HDA_OUTPUT,
> +				  (0x3 << AC_AMPCAP_OFFSET_SHIFT) |
> +				  (0x4 << AC_AMPCAP_NUM_STEPS_SHIFT) |
> +				  (0x27 << AC_AMPCAP_STEP_SIZE_SHIFT) |
> +				  (0 << AC_AMPCAP_MUTE_SHIFT));
> +}
> +
>  /* ThinkPad X200 & co with cxt5051 */
>  static const struct hda_pintbl cxt_pincfg_lenovo_x200[] = {
>  	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
> @@ -4435,6 +4451,18 @@ static const struct hda_pintbl cxt_pincfg_lenovo_tp410[] = {
>  	{}
>  };
>  
> +/* Lemote A1004/A1205 with cxt5066 */
> +static const struct hda_pintbl cxt_pincfg_lemote[] = {
> +	{ 0x1a, 0x90a10020 }, /* Internal mic */
> +	{ 0x1b, 0x03a11020 }, /* External mic */
> +	{ 0x1d, 0x400101f0 }, /* Not used */
> +	{ 0x1e, 0x40a701f0 }, /* Not used */
> +	{ 0x20, 0x404501f0 }, /* Not used */
> +	{ 0x22, 0x404401f0 }, /* Not used */
> +	{ 0x23, 0x40a701f0 }, /* Not used */
> +	{}
> +};
> +
>  static const struct hda_fixup cxt_fixups[] = {
>  	[CXT_PINCFG_LENOVO_X200] = {
>  		.type = HDA_FIXUP_PINS,
> @@ -4444,10 +4472,24 @@ static const struct hda_fixup cxt_fixups[] = {
>  		.type = HDA_FIXUP_PINS,
>  		.v.pins = cxt_pincfg_lenovo_tp410,
>  	},
> +	[CXT_PINCFG_LEMOTE_A1004] = {
> +		.type = HDA_FIXUP_PINS,
> +		.chained = true,
> +		.chain_id = CXT_FIXUP_INC_MIC_BOOST,
> +		.v.pins = cxt_pincfg_lemote,
> +	},
> +	[CXT_PINCFG_LEMOTE_A1205] = {
> +		.type = HDA_FIXUP_PINS,
> +		.v.pins = cxt_pincfg_lemote,
> +	},
>  	[CXT_FIXUP_STEREO_DMIC] = {
>  		.type = HDA_FIXUP_FUNC,
>  		.v.func = cxt_fixup_stereo_dmic,
>  	},
> +	[CXT_FIXUP_INC_MIC_BOOST] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = cxt5066_increase_mic_boost,
> +	},
>  };
>  
>  static const struct snd_pci_quirk cxt5051_fixups[] = {
> @@ -4463,6 +4505,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x21cf, "Lenovo T520", CXT_PINCFG_LENOVO_TP410),
>  	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
>  	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
> +	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
> +	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
>  	{}
>  };
>  
> -- 
> 1.7.7.3
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
