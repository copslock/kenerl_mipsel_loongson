Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jan 2015 17:34:14 +0100 (CET)
Received: from exprod5og118.obsmtp.com ([64.18.0.160]:55782 "EHLO
        exprod5og118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010967AbbAXQeMY0Yfn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jan 2015 17:34:12 +0100
Received: from mail-we0-f179.google.com ([74.125.82.179]) (using TLSv1) by exprod5ob118.postini.com ([64.18.4.12]) with SMTP
        ID DSNKVMPJgb+u6MM6lslRnvD2LavTuX3yJPLx@postini.com; Sat, 24 Jan 2015 08:34:11 PST
Received: by mail-we0-f179.google.com with SMTP id q59so2480612wes.10
        for <linux-mips@linux-mips.org>; Sat, 24 Jan 2015 08:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WVo/NydqDycufwC6swKziVXfgxwTAsSChccCoOAW6c0=;
        b=dIxLGIs9MVLKwVH2JSI9HBWAb8r6StnMWEiPwpBYg3/uzKmARGym/dyfY3UPSg6er1
         LZ3inlccOnr+zuaT29rIU0y051cPssZCztCfMY4rIB3NUeoid9U1cJayc0E2sCBghDUi
         omEx7MpO/rA0kkfEJC6gEjugsseuWJTUsOg+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVo/NydqDycufwC6swKziVXfgxwTAsSChccCoOAW6c0=;
        b=aKLoKkep8nNoxPfHNJEmxh7sE+D1FzBc+ppyb1L60QYfB5hgYou5B9/im1ZLIedt9q
         T+mzXr1OvtPz/KkZFLiPL6g2vdDQpCvNbjp6ZzOpXGb12AyXecUAMhpeQkUufZfFaUpK
         H6mYM+peK/IN2h0LTULG0MW80POwD95q/mJ6ZNcJeqR0V6Ggc4hPT+qEyjc0uSFd/QVa
         xIvBhPyza+lNLj3H+SbYzKu1BwNuD1218lG/9/eSqpw+7ZBinpROl24YQ67nbkeNVHyV
         a76CbgIzx+d6c/FgFy4V8nwXRjDhyVKhIoRHF3UO4PwwiP3lF/yryrXRmRaEOWgwiBPC
         hHVg==
X-Gm-Message-State: ALoCoQkQ2OTJVHlKz+OMqu9MrA3EM8Rbe324vx/eUUwnnHQ6ahjkEQ8OUSzT5IrQpDAVoZknX13fd6Kpo/hrrkGS+G/BIOo9lO/fjXgxamJBAFpFDlol0h2Gkw9ngfjjrbStjGsmA38QxPCAeJ7Q4Y6HZuLCizEwFw==
X-Received: by 10.194.190.162 with SMTP id gr2mr26238754wjc.13.1422117248503;
        Sat, 24 Jan 2015 08:34:08 -0800 (PST)
X-Received: by 10.194.190.162 with SMTP id gr2mr26238735wjc.13.1422117248418;
        Sat, 24 Jan 2015 08:34:08 -0800 (PST)
Received: from localhost ([195.238.92.132])
        by mx.google.com with ESMTPSA id er13sm6343107wjc.11.2015.01.24.08.34.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 24 Jan 2015 08:34:07 -0800 (PST)
From:   Semen Protsenko <semen.protsenko@globallogic.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Russell King <linux@arm.linux.org.uk>
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        linux-am33-list@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: [PATCH 0/4] defconfigs: cleanup obsolete MTD configs
Date:   Sat, 24 Jan 2015 18:33:29 +0200
Message-Id: <1422117213-3130-1-git-send-email-semen.protsenko@globallogic.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <semen.protsenko@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: semen.protsenko@globallogic.com
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

This patch series removes next obsolete MTD configs from all defconfig files:
  - CONFIG_MTD_CHAR
  - CONFIG_MTD_CONCAT
  - CONFIG_MTD_DEBUG
  - CONFIG_MTD_DEBUG_VERBOSE
  - CONFIG_MTD_PARTITIONS

All those configs were removed from drivers/mtd/Kconfig earlier, but their usage
in defconfig files was remain unnoticed. There are at least two obvious reasons
to get rid of those configs:
  1. Their usage may cause to build warnings
  2. Their usage may confuse someone who is grepping defconfig files to get
     the clue what MTD configuration may look like.

This series is harmless for all those defconfigs and will not break anything.


Semen Protsenko (4):
  defconfigs: remove CONFIG_MTD_CONCAT
  defconfigs: remove CONFIG_MTD_PARTITIONS
  defconfigs: remove CONFIG_MTD_CHAR
  defconfigs: remove CONFIG_MTD_DEBUG*

 arch/arm/configs/acs5k_defconfig                   |    3 ---
 arch/arm/configs/acs5k_tiny_defconfig              |    3 ---
 arch/arm/configs/am200epdkit_defconfig             |    1 -
 arch/arm/configs/assabet_defconfig                 |    2 --
 arch/arm/configs/badge4_defconfig                  |    3 ---
 arch/arm/configs/bockw_defconfig                   |    1 -
 arch/arm/configs/cerfcube_defconfig                |    2 --
 arch/arm/configs/cm_x2xx_defconfig                 |    1 -
 arch/arm/configs/cm_x300_defconfig                 |    2 --
 arch/arm/configs/cns3420vb_defconfig               |    2 --
 arch/arm/configs/colibri_pxa270_defconfig          |    2 --
 arch/arm/configs/collie_defconfig                  |    2 --
 arch/arm/configs/corgi_defconfig                   |    2 --
 arch/arm/configs/davinci_all_defconfig             |    2 --
 arch/arm/configs/em_x270_defconfig                 |    1 -
 arch/arm/configs/ezx_defconfig                     |    1 -
 arch/arm/configs/h5000_defconfig                   |    1 -
 arch/arm/configs/hackkit_defconfig                 |    3 ---
 arch/arm/configs/imote2_defconfig                  |    1 -
 arch/arm/configs/iop13xx_defconfig                 |    1 -
 arch/arm/configs/iop32x_defconfig                  |    2 --
 arch/arm/configs/iop33x_defconfig                  |    2 --
 arch/arm/configs/ixp4xx_defconfig                  |    2 --
 arch/arm/configs/ks8695_defconfig                  |    2 --
 arch/arm/configs/lart_defconfig                    |    4 ----
 arch/arm/configs/lpc32xx_defconfig                 |    1 -
 arch/arm/configs/lpd270_defconfig                  |    2 --
 arch/arm/configs/lubbock_defconfig                 |    2 --
 arch/arm/configs/mackerel_defconfig                |    3 ---
 arch/arm/configs/magician_defconfig                |    2 --
 arch/arm/configs/mainstone_defconfig               |    2 --
 arch/arm/configs/mini2440_defconfig                |    3 ---
 arch/arm/configs/mv78xx0_defconfig                 |    2 --
 arch/arm/configs/neponset_defconfig                |    2 --
 arch/arm/configs/netx_defconfig                    |    2 --
 arch/arm/configs/nuc910_defconfig                  |    3 ---
 arch/arm/configs/nuc950_defconfig                  |    3 ---
 arch/arm/configs/nuc960_defconfig                  |    3 ---
 arch/arm/configs/omap1_defconfig                   |    4 ----
 arch/arm/configs/orion5x_defconfig                 |    1 -
 arch/arm/configs/pcm027_defconfig                  |    2 --
 arch/arm/configs/pleb_defconfig                    |    2 --
 arch/arm/configs/pxa255-idp_defconfig              |    2 --
 arch/arm/configs/pxa3xx_defconfig                  |    2 --
 arch/arm/configs/raumfeld_defconfig                |    3 ---
 arch/arm/configs/realview-smp_defconfig            |    3 ---
 arch/arm/configs/realview_defconfig                |    3 ---
 arch/arm/configs/s3c2410_defconfig                 |    1 -
 arch/arm/configs/shannon_defconfig                 |    2 --
 arch/arm/configs/simpad_defconfig                  |    3 ---
 arch/arm/configs/spear13xx_defconfig               |    1 -
 arch/arm/configs/spear3xx_defconfig                |    1 -
 arch/arm/configs/spear6xx_defconfig                |    1 -
 arch/arm/configs/spitz_defconfig                   |    2 --
 arch/arm/configs/tct_hammer_defconfig              |    2 --
 arch/arm/configs/trizeps4_defconfig                |    2 --
 arch/arm/configs/viper_defconfig                   |    1 -
 arch/arm/configs/xcep_defconfig                    |    1 -
 arch/arm/configs/zeus_defconfig                    |    1 -
 arch/avr32/configs/atngw100_defconfig              |    1 -
 arch/avr32/configs/atngw100_evklcd100_defconfig    |    1 -
 arch/avr32/configs/atngw100_evklcd101_defconfig    |    1 -
 arch/avr32/configs/atngw100_mrmt_defconfig         |    1 -
 arch/avr32/configs/atngw100mkii_defconfig          |    1 -
 .../avr32/configs/atngw100mkii_evklcd100_defconfig |    1 -
 .../avr32/configs/atngw100mkii_evklcd101_defconfig |    1 -
 arch/avr32/configs/atstk1002_defconfig             |    1 -
 arch/avr32/configs/atstk1003_defconfig             |    1 -
 arch/avr32/configs/atstk1004_defconfig             |    1 -
 arch/avr32/configs/atstk1006_defconfig             |    1 -
 arch/avr32/configs/favr-32_defconfig               |    1 -
 arch/avr32/configs/hammerhead_defconfig            |    1 -
 arch/avr32/configs/merisc_defconfig                |    2 --
 arch/avr32/configs/mimc200_defconfig               |    1 -
 arch/blackfin/configs/BF518F-EZBRD_defconfig       |    1 -
 arch/blackfin/configs/BF527-TLL6527M_defconfig     |    1 -
 arch/blackfin/configs/BF533-EZKIT_defconfig        |    1 -
 arch/blackfin/configs/BF533-STAMP_defconfig        |    1 -
 arch/blackfin/configs/BF537-STAMP_defconfig        |    1 -
 arch/blackfin/configs/BF538-EZKIT_defconfig        |    1 -
 arch/blackfin/configs/BF561-ACVILON_defconfig      |    1 -
 arch/blackfin/configs/BF561-EZKIT-SMP_defconfig    |    1 -
 arch/blackfin/configs/BF561-EZKIT_defconfig        |    1 -
 arch/blackfin/configs/CM-BF527_defconfig           |    1 -
 arch/blackfin/configs/CM-BF533_defconfig           |    1 -
 arch/blackfin/configs/CM-BF537E_defconfig          |    1 -
 arch/blackfin/configs/CM-BF537U_defconfig          |    1 -
 arch/blackfin/configs/CM-BF548_defconfig           |    1 -
 arch/blackfin/configs/CM-BF561_defconfig           |    1 -
 arch/blackfin/configs/DNP5370_defconfig            |    3 ---
 arch/blackfin/configs/IP0X_defconfig               |    1 -
 arch/blackfin/configs/PNAV-10_defconfig            |    1 -
 arch/blackfin/configs/SRV1_defconfig               |    1 -
 arch/blackfin/configs/TCM-BF518_defconfig          |    1 -
 arch/blackfin/configs/TCM-BF537_defconfig          |    1 -
 arch/m32r/configs/m32700ut.smp_defconfig           |    1 -
 arch/m32r/configs/m32700ut.up_defconfig            |    1 -
 arch/m32r/configs/mappi.smp_defconfig              |    2 --
 arch/m32r/configs/mappi.up_defconfig               |    2 --
 arch/m32r/configs/mappi3.smp_defconfig             |    2 --
 arch/m32r/configs/usrv_defconfig                   |    3 ---
 arch/m68k/configs/m5208evb_defconfig               |    1 -
 arch/m68k/configs/m5249evb_defconfig               |    1 -
 arch/m68k/configs/m5272c3_defconfig                |    1 -
 arch/m68k/configs/m5275evb_defconfig               |    1 -
 arch/m68k/configs/m5307c3_defconfig                |    1 -
 arch/m68k/configs/m5407c3_defconfig                |    1 -
 arch/m68k/configs/m5475evb_defconfig               |    1 -
 arch/microblaze/configs/nommu_defconfig            |    1 -
 arch/mips/configs/ar7_defconfig                    |    1 -
 arch/mips/configs/cobalt_defconfig                 |    1 -
 arch/mips/configs/fuloong2e_defconfig              |    1 -
 arch/mips/configs/gpr_defconfig                    |    1 -
 arch/mips/configs/jmr3927_defconfig                |    1 -
 arch/mips/configs/lasat_defconfig                  |    1 -
 arch/mips/configs/markeins_defconfig               |    1 -
 arch/mips/configs/msp71xx_defconfig                |    1 -
 arch/mips/configs/mtx1_defconfig                   |    1 -
 arch/mips/configs/nlm_xlp_defconfig                |    1 -
 arch/mips/configs/pnx8335_stb225_defconfig         |    1 -
 arch/mips/configs/rb532_defconfig                  |    1 -
 arch/mips/configs/rbtx49xx_defconfig               |    1 -
 arch/mn10300/configs/asb2303_defconfig             |    3 ---
 arch/mn10300/configs/asb2364_defconfig             |    3 ---
 arch/powerpc/configs/40x/acadia_defconfig          |    1 -
 arch/powerpc/configs/40x/ep405_defconfig           |    1 -
 arch/powerpc/configs/40x/kilauea_defconfig         |    1 -
 arch/powerpc/configs/40x/makalu_defconfig          |    1 -
 arch/powerpc/configs/40x/obs600_defconfig          |    1 -
 arch/powerpc/configs/40x/walnut_defconfig          |    1 -
 arch/powerpc/configs/44x/arches_defconfig          |    1 -
 arch/powerpc/configs/44x/bluestone_defconfig       |    1 -
 arch/powerpc/configs/44x/canyonlands_defconfig     |    1 -
 arch/powerpc/configs/44x/currituck_defconfig       |    1 -
 arch/powerpc/configs/44x/ebony_defconfig           |    1 -
 arch/powerpc/configs/44x/eiger_defconfig           |    2 --
 arch/powerpc/configs/44x/icon_defconfig            |    1 -
 arch/powerpc/configs/44x/iss476-smp_defconfig      |    1 -
 arch/powerpc/configs/44x/katmai_defconfig          |    1 -
 arch/powerpc/configs/44x/rainier_defconfig         |    1 -
 arch/powerpc/configs/44x/redwood_defconfig         |    2 --
 arch/powerpc/configs/44x/sequoia_defconfig         |    1 -
 arch/powerpc/configs/44x/taishan_defconfig         |    1 -
 arch/powerpc/configs/44x/warp_defconfig            |    1 -
 arch/powerpc/configs/52xx/cm5200_defconfig         |    1 -
 arch/powerpc/configs/52xx/motionpro_defconfig      |    2 --
 arch/powerpc/configs/52xx/pcm030_defconfig         |    1 -
 arch/powerpc/configs/52xx/tqm5200_defconfig        |    2 --
 arch/powerpc/configs/83xx/asp8347_defconfig        |    1 -
 arch/powerpc/configs/83xx/kmeter1_defconfig        |    1 -
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |    1 -
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig    |    1 -
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig    |    1 -
 arch/powerpc/configs/83xx/sbc834x_defconfig        |    2 --
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |    1 -
 arch/powerpc/configs/85xx/ksi8560_defconfig        |    2 --
 arch/powerpc/configs/85xx/ppa8548_defconfig        |    2 --
 arch/powerpc/configs/85xx/sbc8548_defconfig        |    1 -
 arch/powerpc/configs/85xx/socrates_defconfig       |    2 --
 arch/powerpc/configs/85xx/tqm8540_defconfig        |    2 --
 arch/powerpc/configs/85xx/tqm8541_defconfig        |    2 --
 arch/powerpc/configs/85xx/tqm8548_defconfig        |    1 -
 arch/powerpc/configs/85xx/tqm8555_defconfig        |    2 --
 arch/powerpc/configs/85xx/tqm8560_defconfig        |    2 --
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    1 -
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig      |    2 --
 arch/powerpc/configs/86xx/gef_sbc310_defconfig     |    2 --
 arch/powerpc/configs/86xx/gef_sbc610_defconfig     |    2 --
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |    1 -
 arch/powerpc/configs/86xx/sbc8641d_defconfig       |    2 --
 arch/powerpc/configs/adder875_defconfig            |    1 -
 arch/powerpc/configs/c2k_defconfig                 |    2 --
 arch/powerpc/configs/corenet32_smp_defconfig       |    1 -
 arch/powerpc/configs/ep8248e_defconfig             |    1 -
 arch/powerpc/configs/ep88xc_defconfig              |    1 -
 arch/powerpc/configs/linkstation_defconfig         |    2 --
 arch/powerpc/configs/mgcoge_defconfig              |    1 -
 arch/powerpc/configs/mpc5200_defconfig             |    1 -
 arch/powerpc/configs/mpc8272_ads_defconfig         |    1 -
 arch/powerpc/configs/mpc83xx_defconfig             |    1 -
 arch/powerpc/configs/mpc85xx_defconfig             |    1 -
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    1 -
 arch/powerpc/configs/mpc885_ads_defconfig          |    1 -
 arch/powerpc/configs/ppc40x_defconfig              |    1 -
 arch/powerpc/configs/ppc44x_defconfig              |    1 -
 arch/powerpc/configs/pq2fads_defconfig             |    1 -
 arch/powerpc/configs/storcenter_defconfig          |    1 -
 arch/powerpc/configs/tqm8xx_defconfig              |    2 --
 arch/sh/configs/ap325rxa_defconfig                 |    3 ---
 arch/sh/configs/apsh4a3a_defconfig                 |    3 ---
 arch/sh/configs/ecovec24_defconfig                 |    3 ---
 arch/sh/configs/edosk7760_defconfig                |    4 ----
 arch/sh/configs/espt_defconfig                     |    2 --
 arch/sh/configs/kfr2r09_defconfig                  |    2 --
 arch/sh/configs/magicpanelr2_defconfig             |    2 --
 arch/sh/configs/migor_defconfig                    |    3 ---
 arch/sh/configs/polaris_defconfig                  |    2 --
 arch/sh/configs/r7780mp_defconfig                  |    1 -
 arch/sh/configs/rsk7201_defconfig                  |    3 ---
 arch/sh/configs/rsk7203_defconfig                  |    3 ---
 arch/sh/configs/rts7751r2dplus_defconfig           |    3 ---
 arch/sh/configs/sdk7786_defconfig                  |    1 -
 arch/sh/configs/se7206_defconfig                   |    3 ---
 arch/sh/configs/se7343_defconfig                   |    3 ---
 arch/sh/configs/se7619_defconfig                   |    3 ---
 arch/sh/configs/se7705_defconfig                   |    2 --
 arch/sh/configs/se7712_defconfig                   |    3 ---
 arch/sh/configs/se7721_defconfig                   |    3 ---
 arch/sh/configs/se7724_defconfig                   |    3 ---
 arch/sh/configs/se7750_defconfig                   |    2 --
 arch/sh/configs/se7751_defconfig                   |    1 -
 arch/sh/configs/se7780_defconfig                   |    2 --
 arch/sh/configs/secureedge5410_defconfig           |    2 --
 arch/sh/configs/sh7710voipgw_defconfig             |    2 --
 arch/sh/configs/sh7757lcr_defconfig                |    1 -
 arch/sh/configs/sh7763rdp_defconfig                |    1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig          |    3 ---
 arch/sh/configs/sh7785lcr_defconfig                |    3 ---
 arch/sh/configs/shmin_defconfig                    |    1 -
 arch/sh/configs/titan_defconfig                    |    2 --
 arch/sh/configs/ul2_defconfig                      |    3 ---
 arch/sh/configs/urquell_defconfig                  |    3 ---
 arch/unicore32/configs/unicore32_defconfig         |    2 --
 226 files changed, 364 deletions(-)

-- 
1.7.9.5
