Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 15:36:50 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:8242 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011836AbcBOOgs1cYjJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 15:36:48 +0100
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O2L00C73F95SG40@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Mon, 15 Feb 2016 14:36:41 +0000 (GMT)
X-AuditID: cbfec7f5-f79b16d000005389-bc-56c1e278e12c
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 63.7D.21385.872E1C65; Mon,
 15 Feb 2016 14:36:40 +0000 (GMT)
Received: from AMDC1061.digital.local ([106.116.147.88])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O2L005QPF94GF00@eusync3.samsung.com>; Mon,
 15 Feb 2016 14:36:40 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>, coreteam@netfilter.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/7] fix IS_ERR_VALUE usage
Date:   Mon, 15 Feb 2016 15:35:18 +0100
Message-id: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsVy+t/xq7oVjw6GGbRet7K4te4cq8XGGetZ
        Lf7ubGe22PT4GqvFib4PrBaXd81hs+jZsJXVYsLUSewWM87vY7I4s7iX3WLRslZmi9/f/7Fa
        rD1yl93i2AIxiwnrTrE48HscXbmWyWPzknqP8zMWMnq8/X2CyaNvyypGj8+b5ALYorhsUlJz
        MstSi/TtErgy9s7nLuhUrWi5+omlgbFBoYuRk0NCwERi35THLBC2mMSFe+vZQGwhgaWMEt8W
        13cxcgHZTUwSpzqms4Ik2AQ0Jf5uvglWJCKgILG59xlYnFngPrPE2tlSILawgLbE8ob3zF2M
        HBwsAqoSPf22IGFeAWeJhR+/QO2Skzh5bDLrBEbuBYwMqxhFU0uTC4qT0nON9IoTc4tL89L1
        kvNzNzFCwu7rDsalx6wOMQpwMCrx8EacORAmxJpYVlyZe4hRgoNZSYTX4vTBMCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8M3e9DxESSE8sSc1OTS1ILYLJMnFwSjUwqrx43Ca0MlHk6MUFjCaV
        D5X/Ke7LYrkw4dJrOe3Lz7q5/Rq0GRO+XDd8WPncV6Y0+vTh/ZsueewTDGdOfdmy9i3raw2T
        xxcCX/y7unXT3ytqzVftj6jcupOytO3Eh9h9ySe69TcaqTzSX5Kx9ovyarkqq9tucqwbj64W
        nj1J8O4EdcbU0qtSr5RYijMSDbWYi4oTATV7D1g3AgAA
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

Hi,

This small set of independent patches tries to fix incorrect
IS_ERR_VALUE macro usage. It fixes most usages leading to errors
as described in [1]. It also follows conclusion from the discussion
[1][2] - IS_ERR_VALUE should be used only with unsigned long type,
signed types should use comparison 'ret < 0'.

The patchset does not fix errors present in net/ethernet/freescale
and soc/fsq/qe drivers - these drivers mixes different types:
dma_addr_t, u32, unsigned long, fixing it properly seems to me more
challenging, maybe maintainers or brave volunteers can look it.

The list of missing fixes:
drivers/net/ethernet/freescale/fs_enet/mac-scc.c:149:36-37: WARNING: incorrect argument type in IS_ERR_VALUE(fep -> ring_mem_addr)
drivers/net/ethernet/freescale/ucc_geth.c:2237:48-49: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> tx_bd_ring_offset [ j ])
drivers/net/ethernet/freescale/ucc_geth.c:2314:48-49: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> rx_bd_ring_offset [ j ])
drivers/net/ethernet/freescale/ucc_geth.c:2524:44-45: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> tx_glbl_pram_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2544:45-46: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> thread_dat_tx_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2571:46-47: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> send_q_mem_reg_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2612:42-43: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> scheduler_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2659:54-55: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> tx_fw_statistics_pram_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2696:44-45: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> rx_glbl_pram_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2715:45-46: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> thread_dat_rx_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2736:54-55: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> rx_fw_statistics_pram_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2756:53-54: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> rx_irq_coalescing_tbl_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2822:44-45: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> rx_bd_qs_tbl_offset)
drivers/net/ethernet/freescale/ucc_geth.c:2908:47-48: WARNING: incorrect argument type in IS_ERR_VALUE(ugeth -> exf_glbl_param_offset)
drivers/net/ethernet/freescale/ucc_geth.c:292:36-37: WARNING: incorrect argument type in IS_ERR_VALUE(init_enet_offset)
drivers/net/ethernet/freescale/ucc_geth.c:3042:39-40: WARNING: incorrect argument type in IS_ERR_VALUE(init_enet_pram_offset)
drivers/soc/fsl/qe/ucc_fast.c:271:60-61: WARNING: incorrect argument type in IS_ERR_VALUE(uccf -> ucc_fast_tx_virtual_fifo_base_offset)
drivers/soc/fsl/qe/ucc_fast.c:284:60-61: WARNING: incorrect argument type in IS_ERR_VALUE(uccf -> ucc_fast_rx_virtual_fifo_base_offset)
drivers/soc/fsl/qe/ucc_slow.c:186:38-39: WARNING: incorrect argument type in IS_ERR_VALUE(uccs -> us_pram_offset)
drivers/soc/fsl/qe/ucc_slow.c:213:38-39: WARNING: incorrect argument type in IS_ERR_VALUE(uccs -> rx_base_offset)
drivers/soc/fsl/qe/ucc_slow.c:224:38-39: WARNING: incorrect argument type in IS_ERR_VALUE(uccs -> tx_base_offset)
drivers/net/ethernet/freescale/fs_enet/mac-fcc.c:110:35-36: WARNING: unknown argument type in IS_ERR_VALUE(fpi -> dpram_offset)

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
[2]: http://permalink.gmane.org/gmane.linux.kernel/2150581

Regards
Andrzej


Andrzej Hajda (7):
  netfilter: fix IS_ERR_VALUE usage
  MIPS: module: fix incorrect IS_ERR_VALUE macro usages
  drivers: char: mem: fix IS_ERROR_VALUE usage
  atmel-isi: fix IS_ERR_VALUE usage
  serial: clps711x: fix IS_ERR_VALUE usage
  fbdev: exynos: fix IS_ERR_VALUE usage
  usb: gadget: fsl_qe_udc: fix IS_ERR_VALUE usage

 arch/mips/kernel/module-rela.c                |  2 +-
 arch/mips/kernel/module.c                     |  2 +-
 drivers/char/mem.c                            |  2 +-
 drivers/media/platform/soc_camera/atmel-isi.c |  4 ++--
 drivers/tty/serial/clps711x.c                 | 14 ++++++++------
 drivers/usb/gadget/udc/fsl_qe_udc.c           |  2 +-
 drivers/video/fbdev/exynos/exynos_mipi_dsi.c  |  6 +++---
 include/linux/netfilter/x_tables.h            |  6 +++---
 net/ipv4/netfilter/arp_tables.c               | 11 +++++++----
 net/ipv4/netfilter/ip_tables.c                | 12 ++++++++----
 net/ipv6/netfilter/ip6_tables.c               | 13 +++++++++----
 11 files changed, 44 insertions(+), 30 deletions(-)

-- 
1.9.1
