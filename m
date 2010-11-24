Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2010 15:04:36 +0100 (CET)
Received: from ozlabs.org ([203.10.76.45]:40127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492094Ab0KXOEb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Nov 2010 15:04:31 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by ozlabs.org (Postfix) with ESMTP id B623AB70A3;
        Thu, 25 Nov 2010 01:04:22 +1100 (EST)
Subject: RFC: Mega rename of device tree routines from of_*() to dt_*()
From:   Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-JDzmQwvM41SWq1NXRo6r"
Date:   Thu, 25 Nov 2010 01:03:33 +1100
Message-ID: <1290607413.12457.44.camel@concordia>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Return-Path: <michael@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@ellerman.id.au
Precedence: bulk
X-list: linux-mips


--=-JDzmQwvM41SWq1NXRo6r
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

There were some murmurings on IRC last week about renaming the of_*()
routines. I was procrastinating at the time and said I'd have a look at
it, so here I am.

The thinking is that on many platforms that use the of_() routines
OpenFirmware is not involved at all, this is true even on many powerpc
platforms. Also for folks who don't know the OpenFirmware connection it
reads as "of", as in "a can of worms".

Personally I'm a bit ambivalent about it, the OF name is a bit wrong so
it would be nice to get rid of, but it's a lot of churn.

So I'm hoping people with either say "YES this is a great idea", or "NO
this is stupid".

As step one I've just renamed as many routines as I could find to see
what the resulting patch looks like, so we can quantify the churn. I
also did device.of_node, which is used quite a bit.

Thoughts?

of -> dt most places I could think of (done mechanically):

 Documentation/powerpc/booting-without-of.txt       |    2 +-
 arch/microblaze/include/asm/cpuinfo.h              |    2 +-
 arch/microblaze/include/asm/prom.h                 |   12 +-
 arch/microblaze/kernel/cpu/cpuinfo.c               |    2 +-
 arch/microblaze/kernel/head.S                      |    2 +-
 arch/microblaze/kernel/heartbeat.c                 |    6 +-
 arch/microblaze/kernel/intc.c                      |    8 +-
 arch/microblaze/kernel/irq.c                       |    6 +-
 arch/microblaze/kernel/prom.c                      |   38 ++--
 arch/microblaze/kernel/prom_parse.c                |   28 ++--
 arch/microblaze/kernel/reset.c                     |   12 +-
 arch/microblaze/kernel/setup.c                     |    6 +-
 arch/microblaze/kernel/timer.c                     |   10 +-
 arch/microblaze/pci/pci-common.c                   |   26 ++--
 arch/microblaze/pci/pci_32.c                       |   34 ++--
 arch/microblaze/pci/xilinx_pci.c                   |   14 +-
 arch/microblaze/platform/platform.c                |    6 +-
 arch/mips/kernel/prom.c                            |   32 ++--
 arch/powerpc/boot/of.c                             |    2 +-
 arch/powerpc/boot/ofconsole.c                      |    2 +-
 arch/powerpc/boot/oflib.c                          |    2 +-
 arch/powerpc/include/asm/cpm.h                     |    2 +-
 arch/powerpc/include/asm/ibmebus.h                 |    4 +-
 arch/powerpc/include/asm/irq.h                     |    8 +-
 arch/powerpc/include/asm/kvm_para.h                |    6 +-
 arch/powerpc/include/asm/macio.h                   |    6 +-
 arch/powerpc/include/asm/msi_bitmap.h              |    6 +-
 arch/powerpc/include/asm/parport.h                 |    6 +-
 arch/powerpc/include/asm/pmac_feature.h            |    2 +-
 arch/powerpc/include/asm/prom.h                    |   16 +-
 arch/powerpc/kernel/btext.c                        |   28 ++--
 arch/powerpc/kernel/cacheinfo.c                    |   20 +-
 arch/powerpc/kernel/dma-swiotlb.c                  |    2 +-
 arch/powerpc/kernel/ibmebus.c                      |   38 ++--
 arch/powerpc/kernel/irq.c                          |   22 +-
 arch/powerpc/kernel/isa-bridge.c                   |   14 +-
 arch/powerpc/kernel/kvm.c                          |    6 +-
 arch/powerpc/kernel/legacy_serial.c                |  104 +++++-----
 arch/powerpc/kernel/lparcfg.c                      |   24 +-
 arch/powerpc/kernel/machine_kexec.c                |   12 +-
 arch/powerpc/kernel/machine_kexec_64.c             |   16 +-
 arch/powerpc/kernel/of_platform.c                  |   24 +-
 arch/powerpc/kernel/pci-common.c                   |   24 +-
 arch/powerpc/kernel/pci_32.c                       |   34 ++--
 arch/powerpc/kernel/pci_64.c                       |    6 +-
 arch/powerpc/kernel/pci_dn.c                       |    6 +-
 arch/powerpc/kernel/pci_of_scan.c                  |   22 +-
 arch/powerpc/kernel/proc_powerpc.c                 |    2 +-
 arch/powerpc/kernel/prom.c                         |   92 +++++-----
 arch/powerpc/kernel/prom_parse.c                   |   28 ++--
 arch/powerpc/kernel/rtas-proc.c                    |    6 +-
 arch/powerpc/kernel/rtas.c                         |   34 ++--
 arch/powerpc/kernel/rtas_pci.c                     |   22 +-
 arch/powerpc/kernel/setup-common.c                 |   58 +++---
 arch/powerpc/kernel/setup_32.c                     |    4 +-
 arch/powerpc/kernel/setup_64.c                     |   24 +-
 arch/powerpc/kernel/smp.c                          |   14 +-
 arch/powerpc/kernel/time.c                         |    8 +-
 arch/powerpc/kernel/vio.c                          |   80 ++++----
 arch/powerpc/mm/hash_native_64.c                   |    6 +-
 arch/powerpc/mm/hash_utils_64.c                    |   26 ++--
 arch/powerpc/mm/numa.c                             |   62 +++---
 arch/powerpc/platforms/40x/ep405.c                 |   16 +-
 arch/powerpc/platforms/40x/hcu4.c                  |   10 +-
 arch/powerpc/platforms/40x/ppc40x_simple.c         |   10 +-
 arch/powerpc/platforms/40x/virtex.c                |   10 +-
 arch/powerpc/platforms/40x/walnut.c                |   10 +-
 arch/powerpc/platforms/44x/ebony.c                 |   10 +-
 arch/powerpc/platforms/44x/idle.c                  |    2 +-
 arch/powerpc/platforms/44x/iss4xx.c                |   18 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c         |   10 +-
 arch/powerpc/platforms/44x/sam440ep.c              |   10 +-
 arch/powerpc/platforms/44x/virtex.c                |   10 +-
 arch/powerpc/platforms/44x/warp.c                  |   44 ++--
 arch/powerpc/platforms/512x/clock.c                |   20 +-
 arch/powerpc/platforms/512x/mpc5121_ads.c          |    6 +-
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c     |   14 +-
 arch/powerpc/platforms/512x/mpc5121_generic.c      |    6 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   44 ++--
 arch/powerpc/platforms/512x/pdm360ng.c             |   14 +-
 arch/powerpc/platforms/52xx/efika.c                |   24 +-
 arch/powerpc/platforms/52xx/lite5200.c             |   28 ++--
 arch/powerpc/platforms/52xx/lite5200_pm.c          |   10 +-
 arch/powerpc/platforms/52xx/media5200.c            |   18 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    4 +-
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   50 +++---
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c         |   40 ++--
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |   32 ++--
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |   18 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c          |   10 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   16 +-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c           |   10 +-
 arch/powerpc/platforms/82xx/ep8248e.c              |   36 ++--
 arch/powerpc/platforms/82xx/mgcoge.c               |   14 +-
 arch/powerpc/platforms/82xx/mpc8272_ads.c          |   20 +-
 arch/powerpc/platforms/82xx/pq2.c                  |    4 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c       |   16 +-
 arch/powerpc/platforms/82xx/pq2fads.c              |   20 +-
 arch/powerpc/platforms/83xx/asp834x.c              |   14 +-
 arch/powerpc/platforms/83xx/kmeter1.c              |   40 ++--
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |   10 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c          |   16 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c          |   14 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |   38 ++--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |   38 ++--
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |   12 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |   18 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |   50 +++---
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |   18 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c          |   28 ++--
 arch/powerpc/platforms/83xx/mpc837x_rdb.c          |   18 +-
 arch/powerpc/platforms/83xx/sbc834x.c              |   14 +-
 arch/powerpc/platforms/83xx/suspend.c              |   18 +-
 arch/powerpc/platforms/83xx/usb.c                  |   54 +++---
 arch/powerpc/platforms/85xx/corenet_ds.c           |   14 +-
 arch/powerpc/platforms/85xx/ksi8560.c              |   28 ++--
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |   24 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   24 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   30 ++--
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   46 ++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   98 +++++-----
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   28 ++--
 arch/powerpc/platforms/85xx/p1022_ds.c             |   30 ++--
 arch/powerpc/platforms/85xx/p3041_ds.c             |    6 +-
 arch/powerpc/platforms/85xx/p4080_ds.c             |    6 +-
 arch/powerpc/platforms/85xx/p5020_ds.c             |    6 +-
 arch/powerpc/platforms/85xx/sbc8548.c              |   30 ++--
 arch/powerpc/platforms/85xx/sbc8560.c              |   36 ++--
 arch/powerpc/platforms/85xx/smp.c                  |    6 +-
 arch/powerpc/platforms/85xx/socrates.c             |   22 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c    |    6 +-
 arch/powerpc/platforms/85xx/stx_gp3.c              |   26 ++--
 arch/powerpc/platforms/85xx/tqm85xx.c              |   40 ++--
 arch/powerpc/platforms/85xx/xes_mpc85xx.c          |   48 +++---
 arch/powerpc/platforms/86xx/gef_gpio.c             |   22 +-
 arch/powerpc/platforms/86xx/gef_pic.c              |    4 +-
 arch/powerpc/platforms/86xx/gef_ppc9a.c            |   20 +-
 arch/powerpc/platforms/86xx/gef_sbc310.c           |   20 +-
 arch/powerpc/platforms/86xx/gef_sbc610.c           |   20 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c         |   32 ++--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   16 +-
 arch/powerpc/platforms/86xx/pic.c                  |   14 +-
 arch/powerpc/platforms/86xx/sbc8641d.c             |   10 +-
 arch/powerpc/platforms/8xx/adder875.c              |   10 +-
 arch/powerpc/platforms/8xx/ep88xc.c                |   16 +-
 arch/powerpc/platforms/8xx/m8xx_setup.c            |   10 +-
 arch/powerpc/platforms/8xx/mgsuvd.c                |   10 +-
 arch/powerpc/platforms/8xx/mpc86xads_setup.c       |   16 +-
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |   26 ++--
 arch/powerpc/platforms/8xx/tqm8xx_setup.c          |   14 +-
 arch/powerpc/platforms/amigaone/setup.c            |   22 +-
 arch/powerpc/platforms/cell/axon_msi.c             |   40 ++--
 arch/powerpc/platforms/cell/beat_interrupt.c       |    2 +-
 arch/powerpc/platforms/cell/beat_iommu.c           |    6 +-
 arch/powerpc/platforms/cell/cbe_cpufreq.c          |    6 +-
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c      |    2 +-
 arch/powerpc/platforms/cell/cbe_powerbutton.c      |    2 +-
 arch/powerpc/platforms/cell/cbe_regs.c             |   28 ++--
 arch/powerpc/platforms/cell/celleb_pci.c           |   32 ++--
 arch/powerpc/platforms/cell/celleb_scc_epci.c      |    4 +-
 arch/powerpc/platforms/cell/celleb_scc_pciex.c     |    8 +-
 arch/powerpc/platforms/cell/celleb_scc_sio.c       |   10 +-
 arch/powerpc/platforms/cell/celleb_setup.c         |   22 +-
 arch/powerpc/platforms/cell/interrupt.c            |   22 +-
 arch/powerpc/platforms/cell/iommu.c                |   54 +++---
 arch/powerpc/platforms/cell/qpace_setup.c          |   16 +-
 arch/powerpc/platforms/cell/ras.c                  |   12 +-
 arch/powerpc/platforms/cell/setup.c                |   34 ++--
 arch/powerpc/platforms/cell/spider-pci.c           |    4 +-
 arch/powerpc/platforms/cell/spider-pic.c           |   36 ++--
 arch/powerpc/platforms/cell/spu_manage.c           |   54 +++---
 arch/powerpc/platforms/cell/spufs/inode.c          |    4 +-
 arch/powerpc/platforms/chrp/nvram.c                |    8 +-
 arch/powerpc/platforms/chrp/pci.c                  |   32 ++--
 arch/powerpc/platforms/chrp/setup.c                |   72 ++++----
 arch/powerpc/platforms/chrp/time.c                 |   10 +-
 arch/powerpc/platforms/embedded6xx/c2k.c           |   22 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c   |   12 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c      |   10 +-
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c      |    8 +-
 arch/powerpc/platforms/embedded6xx/holly.c         |   28 ++--
 arch/powerpc/platforms/embedded6xx/linkstation.c   |   18 +-
 arch/powerpc/platforms/embedded6xx/ls_uart.c       |    6 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |   18 +-
 arch/powerpc/platforms/embedded6xx/prpmc2800.c     |   22 +-
 arch/powerpc/platforms/embedded6xx/storcenter.c    |   22 +-
 arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c |    8 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   16 +-
 arch/powerpc/platforms/fsl_uli1575.c               |    6 +-
 arch/powerpc/platforms/iseries/iommu.c             |    6 +-
 arch/powerpc/platforms/iseries/pci.c               |   18 +-
 arch/powerpc/platforms/iseries/setup.c             |    4 +-
 arch/powerpc/platforms/iseries/vio.c               |   22 +-
 arch/powerpc/platforms/iseries/viopath.c           |    6 +-
 arch/powerpc/platforms/maple/pci.c                 |   34 ++--
 arch/powerpc/platforms/maple/setup.c               |   62 +++---
 arch/powerpc/platforms/maple/time.c                |    4 +-
 arch/powerpc/platforms/pasemi/cpufreq.c            |   22 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |    6 +-
 arch/powerpc/platforms/pasemi/gpio_mdio.c          |   30 ++--
 arch/powerpc/platforms/pasemi/iommu.c              |    4 +-
 arch/powerpc/platforms/pasemi/misc.c               |   10 +-
 arch/powerpc/platforms/pasemi/pci.c                |    8 +-
 arch/powerpc/platforms/pasemi/setup.c              |   36 ++--
 arch/powerpc/platforms/powermac/backlight.c        |    8 +-
 arch/powerpc/platforms/powermac/cpufreq_32.c       |   48 +++---
 arch/powerpc/platforms/powermac/cpufreq_64.c       |   52 +++---
 arch/powerpc/platforms/powermac/feature.c          |  172 ++++++++--------
 arch/powerpc/platforms/powermac/low_i2c.c          |   54 +++---
 arch/powerpc/platforms/powermac/nvram.c            |   12 +-
 arch/powerpc/platforms/powermac/pci.c              |   78 ++++----
 arch/powerpc/platforms/powermac/pfunc_base.c       |   32 ++--
 arch/powerpc/platforms/powermac/pfunc_core.c       |   14 +-
 arch/powerpc/platforms/powermac/pic.c              |   72 ++++----
 arch/powerpc/platforms/powermac/setup.c            |   96 +++++-----
 arch/powerpc/platforms/powermac/smp.c              |   54 +++---
 arch/powerpc/platforms/powermac/time.c             |   20 +-
 arch/powerpc/platforms/powermac/udbg_adb.c         |    8 +-
 arch/powerpc/platforms/powermac/udbg_scc.c         |   34 ++--
 arch/powerpc/platforms/ps3/os-area.c               |   18 +-
 arch/powerpc/platforms/ps3/setup.c                 |    4 +-
 arch/powerpc/platforms/ps3/system-bus.c            |    2 +-
 arch/powerpc/platforms/pseries/dlpar.c             |   30 ++--
 arch/powerpc/platforms/pseries/eeh.c               |   20 +-
 arch/powerpc/platforms/pseries/eeh_driver.c        |    4 +-
 arch/powerpc/platforms/pseries/eeh_event.c         |    2 +-
 arch/powerpc/platforms/pseries/event_sources.c     |    8 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |    8 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   18 +-
 arch/powerpc/platforms/pseries/iommu.c             |   18 +-
 arch/powerpc/platforms/pseries/lpar.c              |   16 +-
 arch/powerpc/platforms/pseries/mobility.c          |   14 +-
 arch/powerpc/platforms/pseries/msi.c               |   18 +-
 arch/powerpc/platforms/pseries/nvram.c             |    8 +-
 arch/powerpc/platforms/pseries/pci.c               |    2 +-
 arch/powerpc/platforms/pseries/phyp_dump.c         |   14 +-
 arch/powerpc/platforms/pseries/pseries.h           |    2 +-
 arch/powerpc/platforms/pseries/ras.c               |    8 +-
 arch/powerpc/platforms/pseries/reconfig.c          |   38 ++--
 arch/powerpc/platforms/pseries/setup.c             |   52 +++---
 arch/powerpc/platforms/pseries/xics.c              |   18 +-
 arch/powerpc/sysdev/axonram.c                      |   18 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |   32 ++--
 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h       |    2 +-
 arch/powerpc/sysdev/bestcomm/sram.c                |   10 +-
 arch/powerpc/sysdev/cpm1.c                         |   58 +++---
 arch/powerpc/sysdev/cpm2.c                         |    2 +-
 arch/powerpc/sysdev/cpm_common.c                   |   36 ++--
 arch/powerpc/sysdev/dart_iommu.c                   |   16 +-
 arch/powerpc/sysdev/dcr.c                          |   30 ++--
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |    8 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   16 +-
 arch/powerpc/sysdev/fsl_gtm.c                      |   12 +-
 arch/powerpc/sysdev/fsl_lbc.c                      |   14 +-
 arch/powerpc/sysdev/fsl_msi.c                      |   26 ++--
 arch/powerpc/sysdev/fsl_pci.c                      |   14 +-
 arch/powerpc/sysdev/fsl_pmc.c                      |   10 +-
 arch/powerpc/sysdev/fsl_rio.c                      |   44 ++--
 arch/powerpc/sysdev/fsl_soc.c                      |   56 +++---
 arch/powerpc/sysdev/grackle.c                      |    4 +-
 arch/powerpc/sysdev/i8259.c                        |    2 +-
 arch/powerpc/sysdev/ipic.c                         |    4 +-
 arch/powerpc/sysdev/mmio_nvram.c                   |    6 +-
 arch/powerpc/sysdev/mpc5xxx_clocks.c               |   12 +-
 arch/powerpc/sysdev/mpc8xx_pic.c                   |    8 +-
 arch/powerpc/sysdev/mpc8xxx_gpio.c                 |   40 ++--
 arch/powerpc/sysdev/mpic.c                         |   16 +-
 arch/powerpc/sysdev/mpic_msi.c                     |    8 +-
 arch/powerpc/sysdev/mpic_pasemi_msi.c              |    4 +-
 arch/powerpc/sysdev/mpic_u3msi.c                   |    4 +-
 arch/powerpc/sysdev/msi_bitmap.c                   |   28 ++--
 arch/powerpc/sysdev/mv64x60_dev.c                  |  122 ++++++------
 arch/powerpc/sysdev/mv64x60_pci.c                  |   10 +-
 arch/powerpc/sysdev/mv64x60_pic.c                  |   14 +-
 arch/powerpc/sysdev/mv64x60_udbg.c                 |   22 +-
 arch/powerpc/sysdev/of_rtc.c                       |    6 +-
 arch/powerpc/sysdev/pmi.c                          |   18 +-
 arch/powerpc/sysdev/ppc4xx_gpio.c                  |   22 +-
 arch/powerpc/sysdev/ppc4xx_pci.c                   |   74 ++++----
 arch/powerpc/sysdev/ppc4xx_soc.c                   |   30 ++--
 arch/powerpc/sysdev/qe_lib/gpio.c                  |   36 ++--
 arch/powerpc/sysdev/qe_lib/qe.c                    |   58 +++---
 arch/powerpc/sysdev/qe_lib/qe_ic.c                 |    8 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c                 |   12 +-
 arch/powerpc/sysdev/rtc_cmos_setup.c               |   12 +-
 arch/powerpc/sysdev/simple_gpio.c                  |   20 +-
 arch/powerpc/sysdev/tsi108_dev.c                   |   36 ++--
 arch/powerpc/sysdev/tsi108_pci.c                   |    4 +-
 arch/powerpc/sysdev/uic.c                          |   14 +-
 arch/powerpc/sysdev/xilinx_intc.c                  |   16 +-
 arch/powerpc/sysdev/xilinx_pci.c                   |   12 +-
 arch/sparc/include/asm/fb.h                        |    2 +-
 arch/sparc/include/asm/floppy_32.h                 |    4 +-
 arch/sparc/include/asm/floppy_64.h                 |   16 +-
 arch/sparc/include/asm/openprom.h                  |    2 +-
 arch/sparc/include/asm/parport.h                   |   10 +-
 arch/sparc/include/asm/prom.h                      |    4 +-
 arch/sparc/kernel/apc.c                            |   10 +-
 arch/sparc/kernel/auxio_32.c                       |    4 +-
 arch/sparc/kernel/auxio_64.c                       |   10 +-
 arch/sparc/kernel/central.c                        |   18 +-
 arch/sparc/kernel/chmc.c                           |   32 ++--
 arch/sparc/kernel/devices.c                        |    2 +-
 arch/sparc/kernel/ioport.c                         |    4 +-
 arch/sparc/kernel/irq_64.c                         |    4 +-
 arch/sparc/kernel/leon_kernel.c                    |    8 +-
 arch/sparc/kernel/of_device_32.c                   |   84 ++++----
 arch/sparc/kernel/of_device_64.c                   |  120 ++++++------
 arch/sparc/kernel/of_device_common.c               |   28 ++--
 arch/sparc/kernel/of_device_common.h               |    8 +-
 arch/sparc/kernel/pci.c                            |   34 ++--
 arch/sparc/kernel/pci_common.c                     |   10 +-
 arch/sparc/kernel/pci_fire.c                       |   14 +-
 arch/sparc/kernel/pci_impl.h                       |    2 +-
 arch/sparc/kernel/pci_msi.c                        |   18 +-
 arch/sparc/kernel/pci_psycho.c                     |   14 +-
 arch/sparc/kernel/pci_sabre.c                      |   18 +-
 arch/sparc/kernel/pci_schizo.c                     |   24 +-
 arch/sparc/kernel/pci_sun4v.c                      |   20 +-
 arch/sparc/kernel/pcic.c                           |    2 +-
 arch/sparc/kernel/pmc.c                            |   10 +-
 arch/sparc/kernel/power.c                          |   14 +-
 arch/sparc/kernel/prom_32.c                        |   24 +-
 arch/sparc/kernel/prom_64.c                        |   38 ++--
 arch/sparc/kernel/prom_common.c                    |    6 +-
 arch/sparc/kernel/prom_irqtrans.c                  |   34 ++--
 arch/sparc/kernel/psycho_common.c                  |    2 +-
 arch/sparc/kernel/sbus.c                           |   24 +-
 arch/sparc/kernel/sun4c_irq.c                      |   18 +-
 arch/sparc/kernel/sun4d_irq.c                      |   10 +-
 arch/sparc/kernel/sun4m_irq.c                      |   16 +-
 arch/sparc/kernel/time_32.c                        |   14 +-
 arch/sparc/kernel/time_64.c                        |   28 ++--
 arch/sparc/kernel/vio.c                            |    6 +-
 arch/sparc/mm/init_64.c                            |    2 +-
 arch/sparc/mm/io-unit.c                            |    6 +-
 arch/sparc/mm/iommu.c                              |    6 +-
 drivers/ata/pata_macio.c                           |   32 ++--
 drivers/ata/pata_mpc52xx.c                         |   20 +-
 drivers/ata/pata_of_platform.c                     |   24 +-
 drivers/ata/sata_dwc_460ex.c                       |   18 +-
 drivers/ata/sata_fsl.c                             |   14 +-
 drivers/ata/sata_svw.c                             |    2 +-
 drivers/atm/fore200e.c                             |   28 ++--
 drivers/base/platform.c                            |    8 +-
 drivers/block/swim3.c                              |    6 +-
 drivers/block/xsysace.c                            |   22 +-
 drivers/cdrom/viocd.c                              |    8 +-
 drivers/char/agp/uninorth-agp.c                    |    8 +-
 drivers/char/briq_panel.c                          |    8 +-
 drivers/char/bsr.c                                 |   20 +-
 drivers/char/hvc_beat.c                            |    2 +-
 drivers/char/hvc_iseries.c                         |   10 +-
 drivers/char/hvc_vio.c                             |   10 +-
 drivers/char/hvsi.c                                |   10 +-
 drivers/char/hw_random/n2-drv.c                    |   14 +-
 drivers/char/hw_random/pasemi-rng.c                |   14 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |   26 ++--
 drivers/char/rtc.c                                 |    6 +-
 drivers/char/tpm/tpm_atmel.h                       |   14 +-
 drivers/char/viotape.c                             |    8 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |   22 +-
 drivers/crypto/amcc/crypto4xx_core.c               |   24 +-
 drivers/crypto/n2_core.c                           |   34 ++--
 drivers/crypto/talitos.c                           |   30 ++--
 drivers/dma/fsldma.c                               |   28 ++--
 drivers/dma/mpc512x_dma.c                          |   18 +-
 drivers/dma/ppc4xx/adma.c                          |   62 +++---
 drivers/edac/cell_edac.c                           |    4 +-
 drivers/edac/cpc925_edac.c                         |   16 +-
 drivers/edac/mpc85xx_edac.c                        |   40 ++--
 drivers/edac/mv64x60_edac.c                        |    4 +-
 drivers/edac/ppc4xx_edac.c                         |   30 ++--
 drivers/gpio/gpiolib.c                             |    6 +-
 drivers/gpio/pca953x.c                             |   10 +-
 drivers/gpio/xilinx_gpio.c                         |   30 ++--
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    6 +-
 drivers/gpu/drm/nouveau/nouveau_state.c            |    2 +-
 drivers/gpu/drm/radeon/radeon_clocks.c             |    8 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |   44 ++--
 drivers/hwmon/ltc4245.c                            |    4 +-
 drivers/hwmon/ultra45_env.c                        |   10 +-
 drivers/i2c/busses/i2c-cpm.c                       |   36 ++--
 drivers/i2c/busses/i2c-ibm_iic.c                   |   32 ++--
 drivers/i2c/busses/i2c-mpc.c                       |   50 +++---
 drivers/i2c/busses/i2c-powermac.c                  |   10 +-
 drivers/i2c/i2c-core.c                             |    6 +-
 drivers/ide/pdc202xx_new.c                         |    2 +-
 drivers/ide/pmac.c                                 |   36 ++--
 drivers/infiniband/hw/ehca/ehca_main.c             |   14 +-
 drivers/input/misc/sparcspkr.c                     |   22 +-
 drivers/input/serio/i8042-sparcio.h                |   20 +-
 drivers/input/serio/xilinx_ps2.c                   |   20 +-
 drivers/leds/leds-gpio.c                           |   28 ++--
 drivers/macintosh/adb.c                            |    4 +-
 drivers/macintosh/ams/ams-core.c                   |   22 +-
 drivers/macintosh/ams/ams-i2c.c                    |    2 +-
 drivers/macintosh/ams/ams-pmu.c                    |    4 +-
 drivers/macintosh/ams/ams.h                        |    4 +-
 drivers/macintosh/ans-lcd.c                        |    6 +-
 drivers/macintosh/macio-adb.c                      |   14 +-
 drivers/macintosh/macio_asic.c                     |   56 +++---
 drivers/macintosh/macio_sysfs.c                    |    8 +-
 drivers/macintosh/mediabay.c                       |    6 +-
 drivers/macintosh/rack-meter.c                     |   24 +-
 drivers/macintosh/smu.c                            |   46 ++--
 drivers/macintosh/therm_adt746x.c                  |   28 ++--
 drivers/macintosh/therm_pm72.c                     |   52 +++---
 drivers/macintosh/therm_windtunnel.c               |   26 ++--
 drivers/macintosh/via-cuda.c                       |   10 +-
 drivers/macintosh/via-pmu-backlight.c              |    8 +-
 drivers/macintosh/via-pmu-led.c                    |   10 +-
 drivers/macintosh/via-pmu.c                        |   50 +++---
 drivers/macintosh/windfarm_core.c                  |    6 +-
 drivers/macintosh/windfarm_cpufreq_clamp.c         |    6 +-
 drivers/macintosh/windfarm_lm75_sensor.c           |   14 +-
 drivers/macintosh/windfarm_max6690_sensor.c        |   12 +-
 drivers/macintosh/windfarm_pm112.c                 |    4 +-
 drivers/macintosh/windfarm_pm121.c                 |    2 +-
 drivers/macintosh/windfarm_pm81.c                  |    4 +-
 drivers/macintosh/windfarm_pm91.c                  |    2 +-
 drivers/macintosh/windfarm_smu_controls.c          |   26 ++--
 drivers/macintosh/windfarm_smu_sat.c               |   16 +-
 drivers/macintosh/windfarm_smu_sensors.c           |   22 +-
 drivers/media/video/fsl-viu.c                      |   14 +-
 drivers/mmc/host/mmc_spi.c                         |    2 +-
 drivers/mmc/host/of_mmc_spi.c                      |   16 +-
 drivers/mmc/host/sdhci-of-core.c                   |   30 ++--
 drivers/mmc/host/sdhci-of-esdhc.c                  |    2 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |    2 +-
 drivers/mtd/devices/m25p80.c                       |    4 +-
 drivers/mtd/maps/physmap_of.c                      |   36 ++--
 drivers/mtd/maps/sun_uflash.c                      |   18 +-
 drivers/mtd/nand/fsl_elbc_nand.c                   |    8 +-
 drivers/mtd/nand/fsl_upm.c                         |   32 ++--
 drivers/mtd/nand/mpc5121_nfc.c                     |   40 ++--
 drivers/mtd/nand/ndfc.c                            |   24 +-
 drivers/mtd/nand/pasemi_nand.c                     |   16 +-
 drivers/mtd/nand/socrates_nand.c                   |   14 +-
 drivers/mtd/ofpart.c                               |   16 +-
 drivers/net/bmac.c                                 |    8 +-
 drivers/net/can/mscan/mpc5xxx_can.c                |   42 ++--
 drivers/net/can/sja1000/sja1000_of_platform.c      |   30 ++--
 drivers/net/ehea/ehea_main.c                       |   38 ++--
 drivers/net/fec_mpc52xx.c                          |   38 ++--
 drivers/net/fec_mpc52xx_phy.c                      |   16 +-
 drivers/net/fs_enet/fs_enet-main.c                 |   32 ++--
 drivers/net/fs_enet/mac-fcc.c                      |   10 +-
 drivers/net/fs_enet/mac-fec.c                      |    6 +-
 drivers/net/fs_enet/mac-scc.c                      |    8 +-
 drivers/net/fs_enet/mii-bitbang.c                  |   22 +-
 drivers/net/fs_enet/mii-fec.c                      |   16 +-
 drivers/net/fsl_pq_mdio.c                          |   70 ++++----
 drivers/net/gianfar.c                              |   72 ++++----
 drivers/net/greth.c                                |   14 +-
 drivers/net/ibm_newemac/core.c                     |   98 +++++-----
 drivers/net/ibm_newemac/core.h                     |    2 +-
 drivers/net/ibm_newemac/debug.c                    |    8 +-
 drivers/net/ibm_newemac/debug.h                    |    2 +-
 drivers/net/ibm_newemac/mal.c                      |   36 ++--
 drivers/net/ibm_newemac/rgmii.c                    |   22 +-
 drivers/net/ibm_newemac/tah.c                      |   16 +-
 drivers/net/ibm_newemac/zmii.c                     |   18 +-
 drivers/net/ll_temac.h                             |    2 +-
 drivers/net/ll_temac_main.c                        |   48 +++---
 drivers/net/ll_temac_mdio.c                        |   14 +-
 drivers/net/mace.c                                 |   10 +-
 drivers/net/myri_sbus.c                            |   20 +-
 drivers/net/niu.c                                  |   30 ++--
 drivers/net/pasemi_mac.c                           |   12 +-
 drivers/net/phy/mdio-gpio.c                        |   20 +-
 drivers/net/spider_net.c                           |    4 +-
 drivers/net/sunbmac.c                              |   18 +-
 drivers/net/sungem.c                               |   14 +-
 drivers/net/sungem.h                               |    2 +-
 drivers/net/sungem_phy.c                           |    4 +-
 drivers/net/sunhme.c                               |   26 ++--
 drivers/net/sunlance.c                             |   24 +-
 drivers/net/sunqe.c                                |   18 +-
 drivers/net/tg3.c                                  |    2 +-
 drivers/net/tulip/dmfe.c                           |    4 +-
 drivers/net/tulip/tulip_core.c                     |    4 +-
 drivers/net/ucc_geth.c                             |   46 ++--
 drivers/net/wireless/orinoco/airport.c             |    4 +-
 drivers/net/xilinx_emaclite.c                      |   38 ++--
 drivers/of/address.c                               |  114 ++++++------
 drivers/of/base.c                                  |   14 +-
 drivers/of/device.c                                |   36 ++--
 drivers/of/fdt.c                                   |    4 +-
 drivers/of/gpio.c                                  |   32 ++--
 drivers/of/irq.c                                   |    4 +-
 drivers/of/of_i2c.c                                |   18 +-
 drivers/of/of_mdio.c                               |   16 +-
 drivers/of/of_spi.c                                |   12 +-
 drivers/of/pdt.c                                   |    4 +-
 drivers/of/platform.c                              |  212 ++++++++++------=
----
 drivers/parport/parport_sunbpp.c                   |   12 +-
 drivers/pci/hotplug/rpadlpar_core.c                |    6 +-
 drivers/pci/hotplug/rpaphp_core.c                  |   12 +-
 drivers/pcmcia/electra_cf.c                        |   26 ++--
 drivers/pcmcia/m8xx_pcmcia.c                       |   18 +-
 drivers/rtc/rtc-mpc5121.c                          |   18 +-
 drivers/sbus/char/bbc_envctrl.c                    |    8 +-
 drivers/sbus/char/bbc_i2c.c                        |   18 +-
 drivers/sbus/char/bbc_i2c.h                        |    4 +-
 drivers/sbus/char/display7seg.c                    |   18 +-
 drivers/sbus/char/envctrl.c                        |   30 ++--
 drivers/sbus/char/flash.c                          |   16 +-
 drivers/sbus/char/openprom.c                       |   24 +-
 drivers/sbus/char/uctrl.c                          |   14 +-
 drivers/scsi/ibmvscsi/ibmvfc.c                     |   14 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |    6 +-
 drivers/scsi/ibmvscsi/ibmvstgt.c                   |   12 +-
 drivers/scsi/ibmvscsi/rpa_vscsi.c                  |    8 +-
 drivers/scsi/mac53c94.c                            |    6 +-
 drivers/scsi/mesh.c                                |    6 +-
 drivers/scsi/qla2xxx/qla_init.c                    |    8 +-
 drivers/scsi/qlogicpti.c                           |   26 ++--
 drivers/scsi/sun_esp.c                             |   32 ++--
 drivers/serial/apbuart.c                           |   32 ++--
 drivers/serial/cpm_uart/cpm_uart_core.c            |   46 ++--
 drivers/serial/cpm_uart/cpm_uart_cpm1.c            |    4 +-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c            |    2 +-
 drivers/serial/mpc52xx_uart.c                      |   44 ++--
 drivers/serial/nwpserial.c                         |   10 +-
 drivers/serial/of_serial.c                         |   28 ++--
 drivers/serial/pmac_zilog.c                        |   60 +++---
 drivers/serial/suncore.c                           |    6 +-
 drivers/serial/sunhv.c                             |   12 +-
 drivers/serial/sunsab.c                            |   18 +-
 drivers/serial/sunsu.c                             |   28 ++--
 drivers/serial/sunzilog.c                          |   22 +-
 drivers/serial/uartlite.c                          |   24 +-
 drivers/serial/ucc_uart.c                          |   40 ++--
 drivers/spi/mpc512x_psc_spi.c                      |   24 +-
 drivers/spi/mpc52xx_psc_spi.c                      |   22 +-
 drivers/spi/mpc52xx_spi.c                          |   26 ++--
 drivers/spi/spi.c                                  |    8 +-
 drivers/spi/spi_fsl_espi.c                         |   24 +-
 drivers/spi/spi_fsl_lib.c                          |   16 +-
 drivers/spi/spi_fsl_lib.h                          |    2 +-
 drivers/spi/spi_fsl_spi.c                          |   40 ++--
 drivers/spi/spi_ppc4xx.c                           |   40 ++--
 drivers/spi/xilinx_spi.c                           |    2 +-
 drivers/spi/xilinx_spi_of.c                        |   22 +-
 drivers/usb/core/hcd-pci.c                         |    8 +-
 drivers/usb/gadget/fsl_qe_udc.c                    |   24 +-
 drivers/usb/host/ehci-hcd.c                        |   12 +-
 drivers/usb/host/ehci-ppc-of.c                     |   36 ++--
 drivers/usb/host/ehci-xilinx-of.c                  |   20 +-
 drivers/usb/host/fhci-hcd.c                        |   34 ++--
 drivers/usb/host/fsl-mph-dr-of.c                   |   28 ++--
 drivers/usb/host/isp1760-if.c                      |   34 ++--
 drivers/usb/host/ohci-hcd.c                        |    6 +-
 drivers/usb/host/ohci-ppc-of.c                     |   26 ++--
 drivers/video/aty/aty128fb.c                       |   14 +-
 drivers/video/aty/atyfb_base.c                     |    8 +-
 drivers/video/aty/radeon_backlight.c               |    6 +-
 drivers/video/aty/radeon_base.c                    |   12 +-
 drivers/video/aty/radeon_monitor.c                 |   12 +-
 drivers/video/aty/radeon_pm.c                      |   16 +-
 drivers/video/aty/radeonfb.h                       |    2 +-
 drivers/video/bw2.c                                |   14 +-
 drivers/video/cg14.c                               |   12 +-
 drivers/video/cg3.c                                |   16 +-
 drivers/video/cg6.c                                |   12 +-
 drivers/video/controlfb.c                          |   16 +-
 drivers/video/ffb.c                                |   12 +-
 drivers/video/fsl-diu-fb.c                         |   30 ++--
 drivers/video/leo.c                                |   12 +-
 drivers/video/mb862xx/mb862xxfb.c                  |   16 +-
 drivers/video/mb862xx/mb862xxfb_accel.c            |    2 +-
 drivers/video/nvidia/nv_of.c                       |   10 +-
 drivers/video/offb.c                               |   64 +++---
 drivers/video/p9100.c                              |   12 +-
 drivers/video/platinumfb.c                         |   18 +-
 drivers/video/riva/fbdev.c                         |    4 +-
 drivers/video/sbuslib.c                            |    2 +-
 drivers/video/sunxvr1000.c                         |   24 +-
 drivers/video/sunxvr2500.c                         |   14 +-
 drivers/video/sunxvr500.c                          |   20 +-
 drivers/video/tcx.c                                |   14 +-
 drivers/video/valkyriefb.c                         |    4 +-
 drivers/video/xilinxfb.c                           |   32 ++--
 drivers/watchdog/cpwd.c                            |   22 +-
 drivers/watchdog/gef_wdt.c                         |   14 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |   14 +-
 drivers/watchdog/pika_wdt.c                        |   14 +-
 drivers/watchdog/riowd.c                           |   12 +-
 fs/openpromfs/inode.c                              |    2 +-
 fs/proc/proc_devtree.c                             |   10 +-
 include/asm-generic/gpio.h                         |    2 +-
 include/linux/device.h                             |    4 +-
 include/linux/dt.h                                 |    8 +-
 include/linux/dt_address.h                         |    2 +-
 include/linux/dt_device.h                          |   12 +-
 include/linux/dt_irq.h                             |    2 +-
 include/linux/dt_mdio.h                            |    2 +-
 include/linux/dt_platform.h                        |   26 ++--
 include/linux/dt_spi.h                             |    2 +-
 include/linux/fs_enet_pd.h                         |    2 +-
 include/linux/i2c.h                                |    6 +-
 include/linux/mod_devicetable.h                    |    2 +-
 scripts/coccinelle/iterators/fen.cocci             |   10 +-
 scripts/mod/file2alias.c                           |    4 +-
 sound/aoa/codecs/onyx.c                            |   12 +-
 sound/aoa/codecs/tas.c                             |   12 +-
 sound/aoa/core/gpio-feature.c                      |   14 +-
 sound/aoa/fabrics/layout.c                         |   12 +-
 sound/aoa/soundbus/core.c                          |   12 +-
 sound/aoa/soundbus/i2sbus/control.c                |    2 +-
 sound/aoa/soundbus/i2sbus/core.c                   |   30 ++--
 sound/aoa/soundbus/soundbus.h                      |    2 +-
 sound/aoa/soundbus/sysfs.c                         |    4 +-
 sound/ppc/awacs.c                                  |   24 +-
 sound/ppc/burgundy.c                               |    4 +-
 sound/ppc/pmac.c                                   |   82 ++++----
 sound/ppc/tumbler.c                                |   50 +++---
 sound/soc/fsl/efika-audio-fabric.c                 |    6 +-
 sound/soc/fsl/fsl_dma.c                            |   30 ++--
 sound/soc/fsl/fsl_ssi.c                            |   28 ++--
 sound/soc/fsl/mpc5200_dma.c                        |   20 +-
 sound/soc/fsl/mpc5200_psc_ac97.c                   |   12 +-
 sound/soc/fsl/mpc5200_psc_i2s.c                    |   14 +-
 sound/soc/fsl/mpc8610_hpcd.c                       |   46 ++--
 sound/soc/fsl/p1022_ds.c                           |   48 +++---
 sound/soc/fsl/pcm030-audio-fabric.c                |    6 +-
 sound/sparc/amd7930.c                              |   12 +-
 sound/sparc/cs4231.c                               |   22 +-
 sound/sparc/dbri.c                                 |   14 +-
 630 files changed, 6267 insertions(+), 6267 deletions(-)


--=-JDzmQwvM41SWq1NXRo6r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkztGzAACgkQdSjSd0sB4dJBMwCdEEolFP3dFBLY8ptjmJuTX56v
JK8AoJ89L1/3EKW2n5p0Hxn1seUzknQ1
=MHR5
-----END PGP SIGNATURE-----

--=-JDzmQwvM41SWq1NXRo6r--
