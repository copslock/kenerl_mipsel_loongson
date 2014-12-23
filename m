Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 17:08:40 +0100 (CET)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:62252 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009665AbaLWQIhOOIK6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 17:08:37 +0100
Received: by mail-ig0-f172.google.com with SMTP id hl2so5649971igb.11;
        Tue, 23 Dec 2014 08:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GICVSIINt8RktJbd8itObNEGEW+L7RSC5aRJXvriEk8=;
        b=02E5xi0vw4LDjXHI1YQT8XF/F/1znOW+kngdpP2sekFSxl7bVyX6pYbdDE6wd7wi9H
         dQmmxzJSrEz6Y9GmO2ty4MNAX8IHviw7A7aqAllbAVnM4W6bf4+bJ13b7VuwLwgPagCQ
         Y1RLt3rE4KzUAKM7Zi2VghphWrtJCq0ZrX2Hc3/CRcdRNzhedhNFKWyiCIgneo0yhnoh
         K5pdiMQIU/0ZaPXQzOFe577Q9gLmHLzw10HvrIFSs9jeBv+328odI0blU3NR1eEzVC9g
         CtthBY5JfVC/lUm23wfQoQmldY5pAkB6vvX5YHMNNwTD5pkbhEwP79rRxSNvniVBwZ/e
         sOmg==
X-Received: by 10.107.41.148 with SMTP id p142mr25223222iop.64.1419350911074;
 Tue, 23 Dec 2014 08:08:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.165.65 with HTTP; Tue, 23 Dec 2014 08:07:49 -0800 (PST)
In-Reply-To: <1419290863-19788-1-git-send-email-abrestic@chromium.org>
References: <1419290863-19788-1-git-send-email-abrestic@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 23 Dec 2014 08:07:49 -0800
Message-ID: <CAGVrzcZPODEbQBF8Z+_r-6H3A_S-4Mi=1ALBf87ZmEngWzDpyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Move device-trees into vendor sub-directories
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-12-22 15:27 GMT-08:00 Andrew Bresticker <abrestic@chromium.org>:
> Move the MIPS device-trees into the appropriate vendor sub-directories.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/mips/Makefile                                 |  2 +-
>  arch/mips/boot/dts/Makefile                        | 33 ++++++++--------------
>  arch/mips/boot/dts/bcm/Makefile                    |  9 ++++++
>  arch/mips/boot/dts/{ => bcm}/bcm3384.dtsi          |  0
>  arch/mips/boot/dts/{ => bcm}/bcm93384wvg.dts       |  0

Let's use brcm here, which is the DT vendor prefix, or go full name
with broadcom, there has been enough debate in the past about this ;)

Thanks!

>  arch/mips/boot/dts/cavium-octeon/Makefile          |  9 ++++++
>  .../boot/dts/{ => cavium-octeon}/octeon_3xxx.dts   |  0
>  .../boot/dts/{ => cavium-octeon}/octeon_68xx.dts   |  0
>  arch/mips/boot/dts/lantiq/Makefile                 |  9 ++++++
>  arch/mips/boot/dts/{ => lantiq}/danube.dtsi        |  0
>  arch/mips/boot/dts/{ => lantiq}/easy50712.dts      |  0
>  arch/mips/boot/dts/mti/Makefile                    |  9 ++++++
>  arch/mips/boot/dts/{ => mti}/sead3.dts             |  0
>  arch/mips/boot/dts/netlogic/Makefile               | 12 ++++++++
>  arch/mips/boot/dts/{ => netlogic}/xlp_evp.dts      |  0
>  arch/mips/boot/dts/{ => netlogic}/xlp_fvp.dts      |  0
>  arch/mips/boot/dts/{ => netlogic}/xlp_gvp.dts      |  0
>  arch/mips/boot/dts/{ => netlogic}/xlp_svp.dts      |  0
>  arch/mips/boot/dts/ralink/Makefile                 | 12 ++++++++
>  arch/mips/boot/dts/{ => ralink}/mt7620a.dtsi       |  0
>  arch/mips/boot/dts/{ => ralink}/mt7620a_eval.dts   |  0
>  arch/mips/boot/dts/{ => ralink}/rt2880.dtsi        |  0
>  arch/mips/boot/dts/{ => ralink}/rt2880_eval.dts    |  0
>  arch/mips/boot/dts/{ => ralink}/rt3050.dtsi        |  0
>  arch/mips/boot/dts/{ => ralink}/rt3052_eval.dts    |  0
>  arch/mips/boot/dts/{ => ralink}/rt3883.dtsi        |  0
>  arch/mips/boot/dts/{ => ralink}/rt3883_eval.dts    |  0
>  27 files changed, 73 insertions(+), 22 deletions(-)
>  create mode 100644 arch/mips/boot/dts/bcm/Makefile
>  rename arch/mips/boot/dts/{ => bcm}/bcm3384.dtsi (100%)
>  rename arch/mips/boot/dts/{ => bcm}/bcm93384wvg.dts (100%)
>  create mode 100644 arch/mips/boot/dts/cavium-octeon/Makefile
>  rename arch/mips/boot/dts/{ => cavium-octeon}/octeon_3xxx.dts (100%)
>  rename arch/mips/boot/dts/{ => cavium-octeon}/octeon_68xx.dts (100%)
>  create mode 100644 arch/mips/boot/dts/lantiq/Makefile
>  rename arch/mips/boot/dts/{ => lantiq}/danube.dtsi (100%)
>  rename arch/mips/boot/dts/{ => lantiq}/easy50712.dts (100%)
>  create mode 100644 arch/mips/boot/dts/mti/Makefile
>  rename arch/mips/boot/dts/{ => mti}/sead3.dts (100%)
>  create mode 100644 arch/mips/boot/dts/netlogic/Makefile
>  rename arch/mips/boot/dts/{ => netlogic}/xlp_evp.dts (100%)
>  rename arch/mips/boot/dts/{ => netlogic}/xlp_fvp.dts (100%)
>  rename arch/mips/boot/dts/{ => netlogic}/xlp_gvp.dts (100%)
>  rename arch/mips/boot/dts/{ => netlogic}/xlp_svp.dts (100%)
>  create mode 100644 arch/mips/boot/dts/ralink/Makefile
>  rename arch/mips/boot/dts/{ => ralink}/mt7620a.dtsi (100%)
>  rename arch/mips/boot/dts/{ => ralink}/mt7620a_eval.dts (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt2880.dtsi (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt2880_eval.dts (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt3050.dtsi (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt3052_eval.dts (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt3883.dtsi (100%)
>  rename arch/mips/boot/dts/{ => ralink}/rt3883_eval.dts (100%)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 37fce70..9c4b9c8 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -354,7 +354,7 @@ core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
>
>  PHONY += dtbs
>  dtbs: scripts
> -       $(Q)$(MAKE) $(build)=arch/mips/boot/dts dtbs
> +       $(Q)$(MAKE) $(build)=arch/mips/boot/dts
>
>  archprepare:
>  ifdef CONFIG_MIPS32_N32
> diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
> index 4f49fa4..90d1fbc 100644
> --- a/arch/mips/boot/dts/Makefile
> +++ b/arch/mips/boot/dts/Makefile
> @@ -1,21 +1,12 @@
> -dtb-$(CONFIG_BCM3384)                  += bcm93384wvg.dtb
> -dtb-$(CONFIG_CAVIUM_OCTEON_SOC)                += octeon_3xxx.dtb octeon_68xx.dtb
> -dtb-$(CONFIG_DT_EASY50712)             += easy50712.dtb
> -dtb-$(CONFIG_DT_XLP_EVP)               += xlp_evp.dtb
> -dtb-$(CONFIG_DT_XLP_SVP)               += xlp_svp.dtb
> -dtb-$(CONFIG_DT_XLP_FVP)               += xlp_fvp.dtb
> -dtb-$(CONFIG_DT_XLP_GVP)               += xlp_gvp.dtb
> -dtb-$(CONFIG_DTB_RT2880_EVAL)          += rt2880_eval.dtb
> -dtb-$(CONFIG_DTB_RT305X_EVAL)          += rt3052_eval.dtb
> -dtb-$(CONFIG_DTB_RT3883_EVAL)          += rt3883_eval.dtb
> -dtb-$(CONFIG_DTB_MT7620A_EVAL)         += mt7620a_eval.dtb
> -dtb-$(CONFIG_MIPS_SEAD3)               += sead3.dtb
> -
> -obj-y          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> -
> -targets                += dtbs
> -targets                += $(dtb-y)
> -
> -dtbs: $(addprefix $(obj)/, $(dtb-y))
> -
> -clean-files    += *.dtb *.dtb.S
> +dts-dirs       += bcm
> +dts-dirs       += cavium-octeon
> +dts-dirs       += lantiq
> +dts-dirs       += mti
> +dts-dirs       += netlogic
> +dts-dirs       += ralink
> +
> +obj-y          := $(addsuffix /, $(dts-dirs))
> +
> +always         := $(dtb-y)
> +subdir-y       := $(dts-dirs)
> +clean-files    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/bcm/Makefile b/arch/mips/boot/dts/bcm/Makefile
> new file mode 100644
> index 0000000..a353d4e
> --- /dev/null
> +++ b/arch/mips/boot/dts/bcm/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_BCM3384)          += bcm93384wvg.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/bcm3384.dtsi b/arch/mips/boot/dts/bcm/bcm3384.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/bcm3384.dtsi
> rename to arch/mips/boot/dts/bcm/bcm3384.dtsi
> diff --git a/arch/mips/boot/dts/bcm93384wvg.dts b/arch/mips/boot/dts/bcm/bcm93384wvg.dts
> similarity index 100%
> rename from arch/mips/boot/dts/bcm93384wvg.dts
> rename to arch/mips/boot/dts/bcm/bcm93384wvg.dts
> diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
> new file mode 100644
> index 0000000..5b99c40
> --- /dev/null
> +++ b/arch/mips/boot/dts/cavium-octeon/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_CAVIUM_OCTEON_SOC)        += octeon_3xxx.dtb octeon_68xx.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/octeon_3xxx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> similarity index 100%
> rename from arch/mips/boot/dts/octeon_3xxx.dts
> rename to arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
> diff --git a/arch/mips/boot/dts/octeon_68xx.dts b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> similarity index 100%
> rename from arch/mips/boot/dts/octeon_68xx.dts
> rename to arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
> diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
> new file mode 100644
> index 0000000..0906c62
> --- /dev/null
> +++ b/arch/mips/boot/dts/lantiq/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_DT_EASY50712)     += easy50712.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/danube.dtsi
> rename to arch/mips/boot/dts/lantiq/danube.dtsi
> diff --git a/arch/mips/boot/dts/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
> similarity index 100%
> rename from arch/mips/boot/dts/easy50712.dts
> rename to arch/mips/boot/dts/lantiq/easy50712.dts
> diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
> new file mode 100644
> index 0000000..ef1f3db
> --- /dev/null
> +++ b/arch/mips/boot/dts/mti/Makefile
> @@ -0,0 +1,9 @@
> +dtb-$(CONFIG_MIPS_SEAD3)       += sead3.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
> similarity index 100%
> rename from arch/mips/boot/dts/sead3.dts
> rename to arch/mips/boot/dts/mti/sead3.dts
> diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
> new file mode 100644
> index 0000000..e126cd3
> --- /dev/null
> +++ b/arch/mips/boot/dts/netlogic/Makefile
> @@ -0,0 +1,12 @@
> +dtb-$(CONFIG_DT_XLP_EVP)       += xlp_evp.dtb
> +dtb-$(CONFIG_DT_XLP_SVP)       += xlp_svp.dtb
> +dtb-$(CONFIG_DT_XLP_FVP)       += xlp_fvp.dtb
> +dtb-$(CONFIG_DT_XLP_GVP)       += xlp_gvp.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/xlp_evp.dts b/arch/mips/boot/dts/netlogic/xlp_evp.dts
> similarity index 100%
> rename from arch/mips/boot/dts/xlp_evp.dts
> rename to arch/mips/boot/dts/netlogic/xlp_evp.dts
> diff --git a/arch/mips/boot/dts/xlp_fvp.dts b/arch/mips/boot/dts/netlogic/xlp_fvp.dts
> similarity index 100%
> rename from arch/mips/boot/dts/xlp_fvp.dts
> rename to arch/mips/boot/dts/netlogic/xlp_fvp.dts
> diff --git a/arch/mips/boot/dts/xlp_gvp.dts b/arch/mips/boot/dts/netlogic/xlp_gvp.dts
> similarity index 100%
> rename from arch/mips/boot/dts/xlp_gvp.dts
> rename to arch/mips/boot/dts/netlogic/xlp_gvp.dts
> diff --git a/arch/mips/boot/dts/xlp_svp.dts b/arch/mips/boot/dts/netlogic/xlp_svp.dts
> similarity index 100%
> rename from arch/mips/boot/dts/xlp_svp.dts
> rename to arch/mips/boot/dts/netlogic/xlp_svp.dts
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> new file mode 100644
> index 0000000..2a72259
> --- /dev/null
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -0,0 +1,12 @@
> +dtb-$(CONFIG_DTB_RT2880_EVAL)  += rt2880_eval.dtb
> +dtb-$(CONFIG_DTB_RT305X_EVAL)  += rt3052_eval.dtb
> +dtb-$(CONFIG_DTB_RT3883_EVAL)  += rt3883_eval.dtb
> +dtb-$(CONFIG_DTB_MT7620A_EVAL) += mt7620a_eval.dtb
> +
> +obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> +
> +# Force kbuild to make empty built-in.o if necessary
> +obj-                           += dummy.o
> +
> +always                         := $(dtb-y)
> +clean-files                    := *.dtb *.dtb.S
> diff --git a/arch/mips/boot/dts/mt7620a.dtsi b/arch/mips/boot/dts/ralink/mt7620a.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/mt7620a.dtsi
> rename to arch/mips/boot/dts/ralink/mt7620a.dtsi
> diff --git a/arch/mips/boot/dts/mt7620a_eval.dts b/arch/mips/boot/dts/ralink/mt7620a_eval.dts
> similarity index 100%
> rename from arch/mips/boot/dts/mt7620a_eval.dts
> rename to arch/mips/boot/dts/ralink/mt7620a_eval.dts
> diff --git a/arch/mips/boot/dts/rt2880.dtsi b/arch/mips/boot/dts/ralink/rt2880.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/rt2880.dtsi
> rename to arch/mips/boot/dts/ralink/rt2880.dtsi
> diff --git a/arch/mips/boot/dts/rt2880_eval.dts b/arch/mips/boot/dts/ralink/rt2880_eval.dts
> similarity index 100%
> rename from arch/mips/boot/dts/rt2880_eval.dts
> rename to arch/mips/boot/dts/ralink/rt2880_eval.dts
> diff --git a/arch/mips/boot/dts/rt3050.dtsi b/arch/mips/boot/dts/ralink/rt3050.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/rt3050.dtsi
> rename to arch/mips/boot/dts/ralink/rt3050.dtsi
> diff --git a/arch/mips/boot/dts/rt3052_eval.dts b/arch/mips/boot/dts/ralink/rt3052_eval.dts
> similarity index 100%
> rename from arch/mips/boot/dts/rt3052_eval.dts
> rename to arch/mips/boot/dts/ralink/rt3052_eval.dts
> diff --git a/arch/mips/boot/dts/rt3883.dtsi b/arch/mips/boot/dts/ralink/rt3883.dtsi
> similarity index 100%
> rename from arch/mips/boot/dts/rt3883.dtsi
> rename to arch/mips/boot/dts/ralink/rt3883.dtsi
> diff --git a/arch/mips/boot/dts/rt3883_eval.dts b/arch/mips/boot/dts/ralink/rt3883_eval.dts
> similarity index 100%
> rename from arch/mips/boot/dts/rt3883_eval.dts
> rename to arch/mips/boot/dts/ralink/rt3883_eval.dts
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Florian
