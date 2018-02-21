Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 04:58:19 +0100 (CET)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50421 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeBUD6JyY5Ep (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 04:58:09 +0100
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w1L3vQwI027542;
        Wed, 21 Feb 2018 12:57:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1L3vQwI027542
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1519185447;
        bh=ryVO6MS5d0fUCOui2IMYNLn0CHAPnldpndlYsBdo9vc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=TlSwOSO8r3q0MgjaGwHbOv0kl24rX5AW+MMvDCZQsefcfFM4dCDAD1B01YO+jMbOr
         uMVt3UQkMdQT0MyJPO/QWLZPQxlcvg/UJQylO3pZaPEIz8lUq5VfASW9CWrSoyhEp3
         q0oyeCp7NjS0ymTnhV0/XdqXk1V6UEJEL5vVSN8cuqQZEx+WCRThhWEPbvqDHV8VsT
         aDnvf5M2RQGM+USwsoBvDzYiaSSMMhWZkzFpP0csVx5pYxByMuOPILJEFv4RCNTNXP
         Ik15sQEDFxyHjA2eZU6k0p4kjsmcOprEnC135UVpSMLEeC4VRZxEZWSWP0D247BFNZ
         3CykJ5O5afAVA==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id u200so193739vke.4;
        Tue, 20 Feb 2018 19:57:26 -0800 (PST)
X-Gm-Message-State: APf1xPD2pfZfYVtWdeVvYSLI3MqeH0B8TQv0p2nrDqDdVFTHVN5pcxqK
        ukQUJM6W0/BtfIBAPKWrE0ngGVs9//t96WA0/Es=
X-Google-Smtp-Source: AH8x224+seY/NAC+b30Mae2kngPk98Uy1A1myw09h2fRVfFqJ47g5la/Ubq6HNmkawv89cqjUUgSNTP20TTG14ub5pE=
X-Received: by 10.31.236.195 with SMTP id k186mr1454242vkh.166.1519185445162;
 Tue, 20 Feb 2018 19:57:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.212 with HTTP; Tue, 20 Feb 2018 19:56:44 -0800 (PST)
In-Reply-To: <04370c02b170604b3edde66cdf087bc82710a07f.1518192692.git-series.jhogan@kernel.org>
References: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
 <04370c02b170604b3edde66cdf087bc82710a07f.1518192692.git-series.jhogan@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 21 Feb 2018 12:56:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ4OVEST5gvsgZAr4C9GgyaYrHLJBx8HvaPzEqS5zqgCQ@mail.gmail.com>
Message-ID: <CAK7LNAQ4OVEST5gvsgZAr4C9GgyaYrHLJBx8HvaPzEqS5zqgCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: Add generic list_* Makefile targets
To:     James Hogan <jhogan@kernel.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2018-02-10 1:11 GMT+09:00 James Hogan <jhogan@kernel.org>:
> Add MIPS specific Makefile targets for listing generic defconfigs
> (list_generic_defconfigs), generic board types (list_generic_boards),
> and legacy defconfigs which have been converted to generic
> (list_legacy_defconfigs).
>
> This is useful for quick reference and for buildbots to be able to
> automatically build all supported default configurations without parsing
> of the generic_defconfig error output.
>
> In order for these to work without .config being updated or
> CROSS_COMPILE being needed, list_%s is added to no-dot-config-targets in
> the main Makefile.
>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile           |  2 +-
>  arch/mips/Makefile | 51 ++++++++++++++++++++++++++++++-----------------
>  2 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 3f4d157add54..635015848a2c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -223,7 +223,7 @@ old_version_h := include/linux/version.h
>  no-dot-config-targets := clean mrproper distclean \
>                          cscope gtags TAGS tags help% %docs check% coccicheck \
>                          $(version_h) headers_% archheaders archscripts \
> -                        kernelversion %src-pkg
> +                        kernelversion %src-pkg list_%s
>
>  config-targets := 0
>  mixed-targets  := 0



Unfortunately, there is no way to specify arch-specific
no-dot-config-targets.


This patch made me upset a bit.
Some solutions.


[1] Decide list_% is the right thing

[2] Invent a way to add arch-specific no-dot-config-targets

    For example, add arch/mips/no-dot-config

    Then, append it as follows:

     no-dot-config-targets := clean mrproper distclean \
                              cscope gtags TAGS tags help% %docs
check% coccicheck \
                              $(version_h) headers_% archheaders archscripts \
                              kernelversion %src-pkg
                              kernelversion %src-pkg $(shell cat
arch/$(SRCARCH)/no-dot-config)

   (This needs to tweak the top Makefile a bit more)

[3] (Ab)use the existing name convention

    For example, if you rename as follow,

      list_generic_defconfigs  -> list_generic_defconfig

      list_legacy_defconfigs   -> list_legacy_defconfig

   This works without adding  'list_%s'


   The hack of arch/mips/Makefile is so ugly,
   but adding two more would not hurt.





> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 6f368b5cdf29..9ba487c1c4d2 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -447,24 +447,27 @@ archclean:
>         $(Q)$(MAKE) $(clean)=arch/mips/lasat
>
>  define archhelp
> -       echo '  install              - install kernel into $(INSTALL_PATH)'
> -       echo '  vmlinux.ecoff        - ECOFF boot image'
> -       echo '  vmlinux.bin          - Raw binary boot image'
> -       echo '  vmlinux.srec         - SREC boot image'
> -       echo '  vmlinux.32           - 64-bit boot image wrapped in 32bits (IP22/IP32)'
> -       echo '  vmlinuz              - Compressed boot(zboot) image'
> -       echo '  vmlinuz.ecoff        - ECOFF zboot image'
> -       echo '  vmlinuz.bin          - Raw binary zboot image'
> -       echo '  vmlinuz.srec         - SREC zboot image'
> -       echo '  uImage               - U-Boot image'
> -       echo '  uImage.bin           - U-Boot image (uncompressed)'
> -       echo '  uImage.bz2           - U-Boot image (bz2)'
> -       echo '  uImage.gz            - U-Boot image (gzip)'
> -       echo '  uImage.lzma          - U-Boot image (lzma)'
> -       echo '  uImage.lzo           - U-Boot image (lzo)'
> -       echo '  uzImage.bin          - U-Boot image (self-extracting)'
> -       echo '  dtbs                 - Device-tree blobs for enabled boards'
> -       echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
> +       echo '  install                 - install kernel into $(INSTALL_PATH)'
> +       echo '  vmlinux.ecoff           - ECOFF boot image'
> +       echo '  vmlinux.bin             - Raw binary boot image'
> +       echo '  vmlinux.srec            - SREC boot image'
> +       echo '  vmlinux.32              - 64-bit boot image wrapped in 32bits (IP22/IP32)'
> +       echo '  vmlinuz                 - Compressed boot(zboot) image'
> +       echo '  vmlinuz.ecoff           - ECOFF zboot image'
> +       echo '  vmlinuz.bin             - Raw binary zboot image'
> +       echo '  vmlinuz.srec            - SREC zboot image'
> +       echo '  uImage                  - U-Boot image'
> +       echo '  uImage.bin              - U-Boot image (uncompressed)'
> +       echo '  uImage.bz2              - U-Boot image (bz2)'
> +       echo '  uImage.gz               - U-Boot image (gzip)'
> +       echo '  uImage.lzma             - U-Boot image (lzma)'
> +       echo '  uImage.lzo              - U-Boot image (lzo)'
> +       echo '  uzImage.bin             - U-Boot image (self-extracting)'
> +       echo '  dtbs                    - Device-tree blobs for enabled boards'
> +       echo '  dtbs_install            - Install dtbs to $(INSTALL_DTBS_PATH)'
> +       echo '  list_generic_defconfigs - List available generic defconfigs'
> +       echo '  list_generic_boards     - List available generic boards'
> +       echo '  list_legacy_defconfigs  - List available legacy defconfigs'
>         echo
>         echo '  These will be default as appropriate for a configured platform.'
>         echo
> @@ -538,6 +541,14 @@ generic_defconfig:
>         $(Q)echo
>         $(Q)false
>
> +.PHONY: list_generic_defconfigs
> +list_generic_defconfigs:
> +       $(Q)for cfg in $(generic_defconfigs); do echo "$${cfg}"; done
> +
> +.PHONY: list_generic_boards
> +list_generic_boards:
> +       $(Q)for board in $(sort $(BOARDS)); do echo "$${board}"; done
> +
>  #
>  # Legacy defconfig compatibility - these targets used to be real defconfigs but
>  # now that the boards have been converted to use the generic kernel they are
> @@ -555,3 +566,7 @@ xilfpga_defconfig-y         := 32r2el_defconfig BOARDS=xilfpga
>  .PHONY: $(legacy_defconfigs)
>  $(legacy_defconfigs):
>         $(Q)$(MAKE) -f $(srctree)/Makefile $($@-y)
> +
> +.PHONY: list_legacy_defconfigs
> +list_legacy_defconfigs:
> +       $(Q)for cfg in $(sort $(legacy_defconfigs)); do echo "$${cfg}"; done
> --
> git-series 0.9.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
