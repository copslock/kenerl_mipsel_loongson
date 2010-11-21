Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2010 01:15:21 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:59285 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491819Ab0KUAPO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Nov 2010 01:15:14 +0100
Received: by bwz5 with SMTP id 5so5239724bwz.36
        for <multiple recipients>; Sat, 20 Nov 2010 16:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:subject:to:cc
         :message-id:mime-version:content-type:content-disposition;
        bh=CflpetpbLumIqMJVAkzva+YYXntKLsMdzsPHjsM0d2U=;
        b=ez5B/Q2YolkZip6TSp+N6Vn7A9mKjeKnAOgxl5tQMTPSEb5x9FdNed9tiVECAeZqOO
         xnT6CaztZFucXD31tPKZBI2X0MnCY1mOr/cQ32yWOIlUOitMySnZf7TQI2clQ8YMFWlB
         0JgIjTpAy5ARIkXlBz5OaR7Z4wzF94dkv+MQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:subject:to:cc:message-id:mime-version:content-type
         :content-disposition;
        b=tB8BHwFJ1afzM5s5mT+55qHuwba36Kn1cLifFzAT+stCV+ZbSsiOWTAS5Y8ExRAWno
         KmJNb72VyPKMkkgnUcEO/kJOPfh+6cHzod+25ACWMcLhlHwB0zflF+e8sTyA4mFhPt1U
         oRP8WE2QU1GsoDYpmkwy428Ab963hmc6pGEu4=
Received: by 10.204.116.4 with SMTP id k4mr3634823bkq.187.1290298513254;
        Sat, 20 Nov 2010 16:15:13 -0800 (PST)
Received: from psycho-wlan.lan (dslc-082-083-253-034.pools.arcor-ip.net [82.83.253.34])
        by mx.google.com with ESMTPS id v25sm1606144bkt.6.2010.11.20.16.15.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 16:15:12 -0800 (PST)
Date:   Sun, 21 Nov 2010 01:15:11 +0100 (CET)
From:   shmprtd@googlemail.com
Subject: [PATCH] Add support for Realtek Media Player SoCs
To:     linux-mips@linux-mips.org
cc:     ralf@linux-mips.org
Message-ID: <tkrat.a6310f0563cae06d@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Return-Path: <shmprtd@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28436
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shmprtd@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi,

I added support for at least one of the Realtek "Galaxy" SoCs to recent
2.6.36 kernel. Most of the patch is based on existing linux-mips code and
a 2.6.12 kernel source released by some of Realtek customers.

Currently, this allows to start the kernel and setup serial console.
Further development/porting will have to be done for additional platform
devices.

This code is tested on a Realtek Mars SoC. Commercial product name
is rtd1073dd but cpu/soc id is 0x1283. Other SoCs (Venus,Jupiter,Neptune)
have not been tested, yet.

Please comment on the patch and feel free to suggest changes that need
to be done prior integration.

Sebastian



diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h
--- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-board.h	2010-11-19 18:20:47.000000000 +0100
@@ -0,0 +1,51 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#ifndef _RTD128X_BOARD_H_
+#define _RTD128X_BOARD_H_
+
+#include <linux/types.h>
+
+enum rtd128x_board_type {
+	RTD128X_BOARD_UNKNOWN = -1,
+	RTD128X_BOARD_EM7080 = 0,
+};
+
+struct rtd128x_board {
+	char name[16];
+	u32 ext_freq;
+	unsigned int has_eth0:1;
+	unsigned int has_pci:1;
+	unsigned int has_pccard:1;
+	unsigned int has_ohci0:1;
+	unsigned int has_ehci0:1;
+	unsigned int has_sata0:1;
+	unsigned int has_sata1:1;
+	unsigned int has_uart0:1;
+	unsigned int has_uart1:1;
+	unsigned int has_vfd:1;
+
+	void (*machine_restart) (char *);
+	void (*machine_halt) (void);
+	void (*machine_poweroff) (void);
+
+	/*
+	 * Autodetected / PROM values
+	 */
+
+	phys_t memory_size;
+	char bootrev[16];
+	u16 company_id;
+	u32 board_id;
+	u8 cpu_id;
+	u8 chip_rev;
+	u16 chip_id;
+};
+
+extern struct rtd128x_board rtd128x_board_info;
+
+#endif
diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-io.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-io.h
--- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-io.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-io.h	2010-11-19 18:20:10.000000000 +0100
@@ -0,0 +1,276 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#ifndef _RTD128X_IO_H_
+#define _RTD128X_IO_H_
+
+#define RTD128X_SYS_BASE_OFFSET     0x0000
+#define RTD128X_EHCI_BASE_OFFSET    0x3000
+#define RTD128X_UHCI_BASE_OFFSET    0x3400
+#define RTD128X_USBH_BASE_OFFSET    0x3800
+#define RTD128X_MCP_BASE_OFFSET     0x5100
+#define RTD128X_ETH_BASE_OFFSET     0x6000
+#define RTD128X_TVE_BASE_OFFSET     0x8000
+#define RTD128X_TVD_BASE_OFFSET     0x9000
+#define RTD128X_SB2_BASE_OFFSET     0xa000
+#define RTD128X_MISC_BASE_OFFSET    0xb000
+#define RTD128X_GPIO_BASE_OFFSET    0xb100
+#define RTD128X_UART_BASE_OFFSET    0xb200
+#define RTD128X_I2C0_BASE_OFFSET    0xb300
+#define RTD128X_IRDA_BASE_OFFSET    0xb400
+#define RTD128X_TIMR_BASE_OFFSET    0xb500
+#define RTD128X_RTC_BASE_OFFSET     0xb600
+#define RTD128X_VFDC_BASE_OFFSET    0xb700
+#define RTD128X_PCMCIA_BASE_OFFSET  0xb800
+#define RTD128X_CEC_BASE_OFFSET     0xb900
+#define RTD128X_SC0_BASE_OFFSET     0xba00
+#define RTD128X_I2C1_BASE_OFFSET    0xbb00
+#define RTD128X_SC1_BASE_OFFSET     0xbc00
+
+/*
+ * Misc (PLL, IRQ ??)
+ */
+
+#define RTD128X_MISC_PSELH_OFFSET            0x000
+#define RTD128X_MISC_PSELL_OFFSET            0x004
+#define RTD128X_MISC_UMSK_ISR_OFFSET         0x008
+#define RTD128X_MISC_ISR_OFFSET              0x00c
+#define RTD128X_MISC_UMSK_ISR_GP0A_OFFSET    0x010
+#define RTD128X_MISC_UMSK_ISR_GP0DA_OFFSET   0x014
+#define RTD128X_MISC_UMSK_ISR_KPADAH_OFFSET  0x018
+#define RTD128X_MISC_UMSK_ISR_KPADAL_OFFSET  0x01c
+#define RTD128X_MISC_UMSK_ISR_KPADDAH_OFFSET 0x020
+#define RTD128X_MISC_UMSK_ISR_KPADDAL_OFFSET 0x024
+#define RTD128X_MISC_UMSK_ISR_SW_OFFSET      0x028
+#define RTD128X_MISC_DBG_OFFSET              0x02c
+#define RTD128X_MISC_DUMMY_OFFSET            0x030
+#define RTD128X_MISC_PSEL2_OFFSET            0x034
+#define RTD128X_MISC_UMSK_ISR_GP1A_OFFSET    0x038
+#define RTD128X_MISC_UMSK_ISR_GP1DA_OFFSET   0x03c
+
+#define RTD128X_MISC_BASE             (RTD128X_MISC_BASE_OFFSET)
+#define RTD128X_MISC_PSELH            (RTD128X_MISC_BASE+RTD128X_MISC_PSELH_OFFSET)
+#define RTD128X_MISC_PSELL            (RTD128X_MISC_BASE+RTD128X_MISC_PSELL_OFFSET)
+#define RTD128X_MISC_UMSK_ISR         (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_OFFSET)
+#define RTD128X_MISC_ISR              (RTD128X_MISC_BASE+RTD128X_MISC_ISR_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_GP0A    (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_GP0A_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_GP0DA   (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_GP0DA_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_KPADAH  (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_KPADAH_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_KPADAL  (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_KPADAL_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_KPADDAH (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_KPADDAH_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_KPADDAL (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_KPADDAL_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_SW      (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_SW_OFFSET)
+#define RTD128X_MISC_DBG              (RTD128X_MISC_BASE+RTD128X_MISC_DBG_OFFSET)
+#define RTD128X_MISC_DUMMY            (RTD128X_MISC_BASE+RTD128X_MISC_DUMMY_OFFSET)
+#define RTD128X_MISC_PSEL2            (RTD128X_MISC_BASE+RTD128X_MISC_PSEL2_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_GP1A    (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_GP1A_OFFSET)
+#define RTD128X_MISC_UMSK_ISR_GP1DA   (RTD128X_MISC_BASE+RTD128X_MISC_UMSK_ISR_GP1DA_OFFSET)
+
+/*
+ * UART0/UART1 (8250 compatible)
+ */
+
+#define RTD128X_UART_U0RBR_THR_DLL_OFFSET 0x000
+#define RTD128X_UART_U0IER_DLH_OFFSET     0x004
+#define RTD128X_UART_U0IIR_FCR_OFFSET     0x008
+#define RTD128X_UART_U0LCR_OFFSET         0x00c
+#define RTD128X_UART_U0MCR_OFFSET         0x010
+#define RTD128X_UART_U0LSR_OFFSET         0x014
+#define RTD128X_UART_U0MSR_OFFSET         0x018
+#define RTD128X_UART_U0SCR_OFFSET         0x01c
+#define RTD128X_UART_U1RBR_THR_DLL_OFFSET 0x020
+#define RTD128X_UART_U1IER_DLH_OFFSET     0x024
+#define RTD128X_UART_U1IIR_FCR_OFFSET     0x028
+#define RTD128X_UART_U1LCR_OFFSET         0x02c
+#define RTD128X_UART_U1MCR_OFFSET         0x030
+#define RTD128X_UART_U1LSR_OFFSET         0x034
+#define RTD128X_UART_U1MSR_OFFSET         0x038
+#define RTD128X_UART_U1SCR_OFFSET         0x03c
+
+#define RTD128X_UART_BASE             (RTD128X_UART_BASE_OFFSET)
+#define RTD128X_UART_U0RBR_THR_DLL    (RTD128X_UART_BASE+RTD128X_UART_U0RBR_THR_DLL_OFFSET)
+#define RTD128X_UART_U0IER_DLH        (RTD128X_UART_BASE+RTD128X_UART_U0IER_DLH_OFFSET)
+#define RTD128X_UART_U0IIR_FCR        (RTD128X_UART_BASE+RTD128X_UART_U0IIR_FCR_OFFSET)
+#define RTD128X_UART_U0LCR            (RTD128X_UART_BASE+RTD128X_UART_U0LCR_OFFSET)
+#define RTD128X_UART_U0MCR            (RTD128X_UART_BASE+RTD128X_UART_U0MCR_OFFSET)
+#define RTD128X_UART_U0LSR            (RTD128X_UART_BASE+RTD128X_UART_U0LSR_OFFSET)
+#define RTD128X_UART_U0MSR            (RTD128X_UART_BASE+RTD128X_UART_U0MSR_OFFSET)
+#define RTD128X_UART_U0SCR            (RTD128X_UART_BASE+RTD128X_UART_U0SCR_OFFSET)
+#define RTD128X_UART_U1RBR_THR_DLL    (RTD128X_UART_BASE+RTD128X_UART_U1RBR_THR_DLL_OFFSET)
+#define RTD128X_UART_U1IER_DLH        (RTD128X_UART_BASE+RTD128X_UART_U1IER_DLH_OFFSET)
+#define RTD128X_UART_U1IIR_FCR        (RTD128X_UART_BASE+RTD128X_UART_U1IIR_FCR_OFFSET)
+#define RTD128X_UART_U1LCR            (RTD128X_UART_BASE+RTD128X_UART_U1LCR_OFFSET)
+#define RTD128X_UART_U1MCR            (RTD128X_UART_BASE+RTD128X_UART_U1MCR_OFFSET)
+#define RTD128X_UART_U1LSR            (RTD128X_UART_BASE+RTD128X_UART_U1LSR_OFFSET)
+#define RTD128X_UART_U1MSR            (RTD128X_UART_BASE+RTD128X_UART_U1MSR_OFFSET)
+#define RTD128X_UART_U1SCR            (RTD128X_UART_BASE+RTD128X_UART_U1SCR_OFFSET)
+
+#define RTD128X_UART0_BASE            RTD128X_UART_U0RBR_THR_DLL
+#define RTD128X_UART1_BASE            RTD128X_UART_U1RBR_THR_DLL
+
+/*
+ * Timer
+ */
+
+#define RTD128X_TIMR_TC0TVR_OFFSET            0x000
+#define RTD128X_TIMR_TC1TVR_OFFSET            0x004
+#define RTD128X_TIMR_TC2TVR_OFFSET            0x008
+#define RTD128X_TIMR_TC0CVR_OFFSET            0x00c
+#define RTD128X_TIMR_TC1CVR_OFFSET            0x010
+#define RTD128X_TIMR_TC2CVR_OFFSET            0x014
+#define RTD128X_TIMR_TC0CR_OFFSET             0x018
+#define RTD128X_TIMR_TC1CR_OFFSET             0x01c
+#define RTD128X_TIMR_TC2CR_OFFSET             0x020
+#define RTD128X_TIMR_TC0ICR_OFFSET            0x024
+#define RTD128X_TIMR_TC1ICR_OFFSET            0x028
+#define RTD128X_TIMR_TC2ICR_OFFSET            0x02c
+#define RTD128X_TIMR_TCWCR_OFFSET             0x030
+#define RTD128X_TIMR_TCWTR_OFFSET             0x034
+#define RTD128X_TIMR_CLK27M_CLK90K_CNT_OFFSET 0x038
+#define RTD128X_TIMR_CLK90K_TM_LO_OFFSET      0x03c
+#define RTD128X_TIMR_CLK90K_TM_HI_OFFSET      0x040
+
+#define RTD128X_TIMR_BASE              (RTD128X_TIMR_BASE_OFFSET)
+#define RTD128X_TIMR_TC0TVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC0TVR_OFFSET)
+#define RTD128X_TIMR_TC1TVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC1TVR_OFFSET)
+#define RTD128X_TIMR_TC2TVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC2TVR_OFFSET)
+#define RTD128X_TIMR_TC0CVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC0CVR_OFFSET)
+#define RTD128X_TIMR_TC1CVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC1CVR_OFFSET)
+#define RTD128X_TIMR_TC2CVR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC2CVR_OFFSET)
+#define RTD128X_TIMR_TC0CR             (RTD128X_TIMR_BASE+RTD128X_TIMR_TC0CR_OFFSET)
+#define RTD128X_TIMR_TC1CR             (RTD128X_TIMR_BASE+RTD128X_TIMR_TC1CR_OFFSET)
+#define RTD128X_TIMR_TC2CR             (RTD128X_TIMR_BASE+RTD128X_TIMR_TC2CR_OFFSET)
+#define RTD128X_TIMR_TC0ICR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC0ICR_OFFSET)
+#define RTD128X_TIMR_TC1ICR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC1ICR_OFFSET)
+#define RTD128X_TIMR_TC2ICR            (RTD128X_TIMR_BASE+RTD128X_TIMR_TC2ICR_OFFSET)
+#define RTD128X_TIMR_TCWCR             (RTD128X_TIMR_BASE+RTD128X_TIMR_TCWCR_OFFSET)
+#define RTD128X_TIMR_TCWTR             (RTD128X_TIMR_BASE+RTD128X_TIMR_TCWTR_OFFSET)
+#define RTD128X_TIMR_CLK27M_CLK90K_CNT (RTD128X_TIMR_BASE+RTD128X_TIMR_CLK27M_CLK90K_CNT_OFFSET)
+#define RTD128X_TIMR_CLK90K_TM_LO      (RTD128X_TIMR_BASE+RTD128X_TIMR_CLK90K_TM_LO_OFFSET)
+#define RTD128X_TIMR_CLK90K_TM_HI      (RTD128X_TIMR_BASE+RTD128X_TIMR_CLK90K_TM_HI_OFFSET)
+
+/*
+ * RTC
+ */
+
+#define RTD128X_RTC_SEC_OFFSET      0x000
+#define RTD128X_RTC_MIN_OFFSET      0x004
+#define RTD128X_RTC_HR_OFFSET       0x008
+#define RTD128X_RTC_DATE1_OFFSET    0x00c
+#define RTD128X_RTC_DATE2_OFFSET    0x010
+#define RTD128X_RTC_ALMMIN_OFFSET   0x014
+#define RTD128X_RTC_ALMHR_OFFSET    0x018
+#define RTD128X_RTC_ALMDATE1_OFFSET 0x01c
+#define RTD128X_RTC_ALMDATE2_OFFSET 0x020
+#define RTD128X_RTC_STOP_OFFSET     0x024
+#define RTD128X_RTC_ACR_OFFSET      0x028
+#define RTD128X_RTC_EN_OFFSET       0x02c
+#define RTD128X_RTC_CR_OFFSET       0x030
+
+#define RTD128X_RTC_BASE              (RTD128X_RTC_BASE_OFFSET)
+#define RTD128X_RTC_SEC               (RTD128X_RTC_BASE+RTD128X_RTC_SEC_OFFSET)
+#define RTD128X_RTC_MIN               (RTD128X_RTC_BASE+RTD128X_RTC_MIN_OFFSET)
+#define RTD128X_RTC_HR	            (RTD128X_RTC_BASE+RTD128X_RTC_HR_OFFSET)
+#define RTD128X_RTC_DATE1             (RTD128X_RTC_BASE+RTD128X_RTC_DATE1_OFFSET)
+#define RTD128X_RTC_DATE2             (RTD128X_RTC_BASE+RTD128X_RTC_DATE2_OFFSET)
+#define RTD128X_RTC_ALMMIN            (RTD128X_RTC_BASE+RTD128X_RTC_ALMMIN_OFFSET)
+#define RTD128X_RTC_ALMHR	            (RTD128X_RTC_BASE+RTD128X_RTC_ALMHR_OFFSET)
+#define RTD128X_RTC_ALMDATE1          (RTD128X_RTC_BASE+RTD128X_RTC_ALMDATE1_OFFSET)
+#define RTD128X_RTC_ALMDATE2          (RTD128X_RTC_BASE+RTD128X_RTC_ALMDATE2_OFFSET)
+#define RTD128X_RTC_STOP              (RTD128X_RTC_BASE+RTD128X_RTC_STOP_OFFSET)
+#define RTD128X_RTC_ACR               (RTD128X_RTC_BASE+RTD128X_RTC_ACR_OFFSET)
+#define RTD128X_RTC_EN	            (RTD128X_RTC_BASE+RTD128X_RTC_EN_OFFSET)
+#define RTD128X_RTC_CR	            (RTD128X_RTC_BASE+RTD128X_RTC_CR_OFFSET)
+
+/*
+ * SB2
+ */
+
+#define RTD128X_SB2_HD_SEM_OFFSET          0x000
+#define RTD128X_SB2_INV_INTEN_OFFSET       0x004
+#define RTD128X_SB2_INV_INTSTAT_OFFSET     0x008
+#define RTD128X_SB2_INV_ADDR_OFFSET        0x00c
+
+#define RTD128X_SB2_CHIP_ID_OFFSET         0x200
+#define RTD128X_SB2_CHIP_INFO_OFFSET       0x204
+
+#define RTD128X_SB2_DBG_START_REG0_OFFSET  0x458
+#define RTD128X_SB2_DBG_START_REG1_OFFSET  0x45c
+#define RTD128X_SB2_DBG_START_REG2_OFFSET  0x460
+#define RTD128X_SB2_DBG_START_REG3_OFFSET  0x464
+#define RTD128X_SB2_DBG_START_REG4_OFFSET  0x468
+#define RTD128X_SB2_DBG_START_REG5_OFFSET  0x46c
+#define RTD128X_SB2_DBG_START_REG6_OFFSET  0x470
+#define RTD128X_SB2_DBG_START_REG7_OFFSET  0x474
+
+#define RTD128X_SB2_DBG_END_REG0_OFFSET    0x478
+#define RTD128X_SB2_DBG_END_REG1_OFFSET    0x47c
+#define RTD128X_SB2_DBG_END_REG2_OFFSET    0x480
+#define RTD128X_SB2_DBG_END_REG3_OFFSET    0x484
+#define RTD128X_SB2_DBG_END_REG4_OFFSET    0x488
+#define RTD128X_SB2_DBG_END_REG5_OFFSET    0x48c
+#define RTD128X_SB2_DBG_END_REG6_OFFSET    0x490
+#define RTD128X_SB2_DBG_END_REG7_OFFSET    0x494
+
+#define RTD128X_SB2_DBG_CTRL_REG0_OFFSET   0x498
+#define RTD128X_SB2_DBG_CTRL_REG1_OFFSET   0x49c
+#define RTD128X_SB2_DBG_CTRL_REG2_OFFSET   0x4a0
+#define RTD128X_SB2_DBG_CTRL_REG3_OFFSET   0x4a4
+#define RTD128X_SB2_DBG_CTRL_REG4_OFFSET   0x4a8
+#define RTD128X_SB2_DBG_CTRL_REG5_OFFSET   0x4ac
+#define RTD128X_SB2_DBG_CTRL_REG6_OFFSET   0x4b0
+#define RTD128X_SB2_DBG_CTRL_REG7_OFFSET   0x4b4
+
+#define RTD128X_SB2_DBG_ADDR_AUDIO_OFFSET  0x4b8
+#define RTD128X_SB2_DBG_ADDR_VIDEO_OFFSET  0x4bc
+#define RTD128X_SB2_DBG_ADDR_SYSTEM_OFFSET 0x4c0
+
+#define RTD128X_SB2_DBG_INT_OFFSET         0x4e0
+
+#define RTD128X_SB2_BASE            (RTD128X_SB2_BASE_OFFSET)
+#define RTD128X_SB2_HD_SEM          (RTD128X_SB2_BASE+RTD128X_SB2_HD_SEM_OFFSET)
+#define RTD128X_SB2_INV_INTEN       (RTD128X_SB2_BASE+RTD128X_SB2_INV_INTEN_OFFSET)
+#define RTD128X_SB2_INV_INTSTAT     (RTD128X_SB2_BASE+RTD128X_SB2_INV_INTSTAT_OFFSET)
+#define RTD128X_SB2_INV_ADDR        (RTD128X_SB2_BASE+RTD128X_SB2_INV_ADDR_OFFSET)
+
+#define RTD128X_SB2_CHIP_ID         (RTD128X_SB2_BASE+RTD128X_SB2_CHIP_ID_OFFSET)
+#define RTD128X_SB2_CHIP_INFO       (RTD128X_SB2_BASE+RTD128X_SB2_CHIP_INFO_OFFSET)
+
+#define RTD128X_SB2_DBG_START_REG0  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG0_OFFSET)
+#define RTD128X_SB2_DBG_START_REG1  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG1_OFFSET)
+#define RTD128X_SB2_DBG_START_REG2  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG2_OFFSET)
+#define RTD128X_SB2_DBG_START_REG3  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG3_OFFSET)
+#define RTD128X_SB2_DBG_START_REG4  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG4_OFFSET)
+#define RTD128X_SB2_DBG_START_REG5  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG5_OFFSET)
+#define RTD128X_SB2_DBG_START_REG6  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG6_OFFSET)
+#define RTD128X_SB2_DBG_START_REG7  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_START_REG7_OFFSET)
+
+#define RTD128X_SB2_DBG_END_REG0    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG0_OFFSET)
+#define RTD128X_SB2_DBG_END_REG1    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG1_OFFSET)
+#define RTD128X_SB2_DBG_END_REG2    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG2_OFFSET)
+#define RTD128X_SB2_DBG_END_REG3    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG3_OFFSET)
+#define RTD128X_SB2_DBG_END_REG4    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG4_OFFSET)
+#define RTD128X_SB2_DBG_END_REG5    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG5_OFFSET)
+#define RTD128X_SB2_DBG_END_REG6    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG6_OFFSET)
+#define RTD128X_SB2_DBG_END_REG7    (RTD128X_SB2_BASE+RTD128X_SB2_DBG_END_REG7_OFFSET)
+
+#define RTD128X_SB2_DBG_CTRL_REG0   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG0_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG1   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG1_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG2   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG2_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG3   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG3_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG4   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG4_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG5   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG5_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG6   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG6_OFFSET)
+#define RTD128X_SB2_DBG_CTRL_REG7   (RTD128X_SB2_BASE+RTD128X_SB2_DBG_CTRL_REG7_OFFSET)
+
+#define RTD128X_SB2_DBG_ADDR_AUDIO  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_ADDR_AUDIO_OFFSET)
+#define RTD128X_SB2_DBG_ADDR_VIDEO  (RTD128X_SB2_BASE+RTD128X_SB2_DBG_ADDR_VIDEO_OFFSET)
+#define RTD128X_SB2_DBG_ADDR_SYSTEM (RTD128X_SB2_BASE+RTD128X_SB2_DBG_ADDR_SYSTEM_OFFSET)
+
+#define RTD128X_SB2_DBG_INT         (RTD128X_SB2_BASE+RTD128X_SB2_DBG_INT_OFFSET)
+
+#endif
diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-irq.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-irq.h
--- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-irq.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-irq.h	2010-11-19 18:20:21.000000000 +0100
@@ -0,0 +1,70 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#ifndef _RTD128X_IRQ_H
+#define _RTD128X_IRQ_H
+
+#define MIPS_CPU_IRQ_BASE        0
+
+#ifdef CONFIG_RTD128X_EXTERNAL_TIMER
+#define MIPS_CPU_TIMER_IRQ       RTD128X_IRQ_EXT_TIMER
+#else
+#define MIPS_CPU_TIMER_IRQ       RTD128X_IRQ_TIMER
+#endif
+
+#define RTD128X_IRQ_BASE           2
+#define RTD128X_INTERNAL_IRQ_BASE  8
+
+#define RTD128X_MISC_IRQ_UART0     2
+#define RTD128X_MISC_IRQ_UART1     3
+#define RTD128X_MISC_IRQ_I2C0      4
+#define RTD128X_MISC_IRQ_IRDA      5
+
+#define RTD128X_MISC_IRQ_TIMER2    8
+
+#define RTD128X_MISC_IRQ_VFD_DONE 14
+#define RTD128X_MISC_IRQ_KP_DOWN  15
+#define RTD128X_MISC_IRQ_KP_UP    16
+#define RTD128X_MISC_IRQ_SW_DOWN  17
+#define RTD128X_MISC_IRQ_SW_UP    18
+
+#define RTD128X_MISC_IRQ_GPIO     20
+#define RTD128X_MISC_IRQ_PCMCIA   21
+#define RTD128X_MISC_IRQ_CEC_TX   22
+#define RTD128X_MISC_IRQ_CEC_RX   23
+#define RTD128X_MISC_IRQ_SCARD0   24
+#define RTD128X_MISC_IRQ_SCARD1   25
+#define RTD128X_MISC_IRQ_I2C1     26
+
+#define RTD128X_IRQ_USB           (RTD128X_IRQ_BASE+0)
+#define RTD128X_IRQ_ETH           (RTD128X_IRQ_BASE+0)
+#define RTD128X_IRQ_MISC          (RTD128X_IRQ_BASE+1)
+#define RTD128X_IRQ_CP            (RTD128X_IRQ_BASE+1)
+#define RTD128X_IRQ_1394          (RTD128X_IRQ_BASE+2)
+#define RTD128X_IRQ_ATA           (RTD128X_IRQ_BASE+2)
+#define RTD128X_IRQ_AUD           (RTD128X_IRQ_BASE+3)
+#define RTD128X_IRQ_VID           (RTD128X_IRQ_BASE+3)
+#define RTD128X_IRQ_SE            (RTD128X_IRQ_BASE+3)
+#define RTD128X_IRQ_SB2           (RTD128X_IRQ_BASE+3)
+#define RTD128X_IRQ_EXT_TIMER     (RTD128X_IRQ_BASE+4)
+#define RTD128X_IRQ_TIMER         (RTD128X_IRQ_BASE+5)
+#define RTD128X_IRQ_RTC           (RTD128X_IRQ_BASE+5)
+
+#define RTD128X_IRQ_UART0         (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_UART0)
+#define RTD128X_IRQ_UART1         (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_UART1)
+#define RTD128X_IRQ_I2C0          (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_I2C0)
+
+#define RTD128X_IRQ_TIMER2        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_TIMER2)
+
+#define RTD128X_IRQ_PCMCIA        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_PCMCIA)
+#define RTD128X_IRQ_CEC_TX        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_CEC_TX)
+#define RTD128X_IRQ_CEC_RX        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_CEC_RX)
+#define RTD128X_IRQ_SCARD0        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_SCARD0)
+#define RTD128X_IRQ_SCARD1        (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_SCARD1)
+#define RTD128X_IRQ_I2C1          (RTD128X_INTERNAL_IRQ_BASE+RTD128X_MISC_IRQ_I2C1)
+
+#endif
diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-soc.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-soc.h
--- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/rtd128x-soc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/rtd128x-soc.h	2010-11-19 18:20:28.000000000 +0100
@@ -0,0 +1,41 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#ifndef _RTD128X_SOC_H_
+#define _RTD128X_SOC_H_
+
+#define RTD128X_DEFAULT_LEXRA_MEMBASE 0x01b00000
+#define RTD128X_DEFAULT_HIGHMEM_START 0x02000000
+
+#define RTD128X_IO_PORT_BASE          0x18010000
+
+#define RTD128X_CHIPID_VENUS     0x1281
+#define RTD128X_CHIPID_NEPTUNE   0x1282
+#define RTD128X_CHIPID_MARS      0x1283
+#define RTD128X_CHIPID_JUPITER   0x1284
+
+static inline int rtd128x_is_venus_soc(void)
+{
+	return (rtd128x_board_info.chip_id == RTD128X_CHIPID_VENUS);
+}
+
+static inline int rtd128x_is_neptune_soc(void)
+{
+	return (rtd128x_board_info.chip_id == RTD128X_CHIPID_NEPTUNE);
+}
+
+static inline int rtd128x_is_mars_soc(void)
+{
+	return (rtd128x_board_info.chip_id == RTD128X_CHIPID_MARS);
+}
+
+static inline int rtd128x_is_jupiter_soc(void)
+{
+	return (rtd128x_board_info.chip_id == RTD128X_CHIPID_JUPITER);
+}
+
+#endif
diff -uNr linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/war.h linux-2.6.36/arch/mips/include/asm/mach-rtd128x/war.h
--- linux-2.6.36-vanilla/arch/mips/include/asm/mach-rtd128x/war.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/include/asm/mach-rtd128x/war.h	2010-11-16 19:05:54.000000000 +0100
@@ -0,0 +1,26 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+
+#ifndef __ASM_MIPS_MACH_RTD128x_WAR_H
+#define __ASM_MIPS_MACH_RTD128x_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			0
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_RTD128x_WAR_H */
diff -uNr linux-2.6.36-vanilla/arch/mips/Kbuild.platforms linux-2.6.36/arch/mips/Kbuild.platforms
--- linux-2.6.36-vanilla/arch/mips/Kbuild.platforms	2010-10-20 23:23:01.000000000 +0200
+++ linux-2.6.36/arch/mips/Kbuild.platforms	2010-11-16 01:16:43.000000000 +0100
@@ -18,6 +18,7 @@
 platforms += pnx833x
 platforms += pnx8550
 platforms += powertv
+platforms += rtd128x
 platforms += rb532
 platforms += sgi-ip22
 platforms += sgi-ip27
diff -uNr linux-2.6.36-vanilla/arch/mips/Kconfig linux-2.6.36/arch/mips/Kconfig
--- linux-2.6.36-vanilla/arch/mips/Kconfig	2010-10-20 23:23:01.000000000 +0200
+++ linux-2.6.36/arch/mips/Kconfig	2010-11-16 01:16:43.000000000 +0100
@@ -706,6 +706,22 @@
 		Hikari
 	  Say Y here for most Octeon reference boards.
 
+config RTD128X
+	bool "Realtek Galaxy SoC based boards"
+	select CEVT_R4K
+	select CSRC_R4K
+	select IRQ_CPU
+	select GENERIC_ISA_DMA
+	select DMA_NONCOHERENT
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_ZBOOT_UART16550
+	help
+	  This options supports Realtek SoC based boards.
+	  Say Y here for Realtek SoC based boards.
+
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
@@ -721,6 +737,7 @@
 source "arch/mips/vr41xx/Kconfig"
 source "arch/mips/cavium-octeon/Kconfig"
 source "arch/mips/loongson/Kconfig"
+source "arch/mips/rtd128x/Kconfig"
 
 endmenu
 
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/board.c linux-2.6.36/arch/mips/rtd128x/common/board.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/board.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/board.c	2010-11-19 18:09:57.000000000 +0100
@@ -0,0 +1,137 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/string.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+
+#include <rtd128x-board.h>
+#include <rtd128x-soc.h>
+#include <rtd128x-io.h>
+
+struct rtd128x_board rtd128x_board_info;
+
+static struct rtd128x_board rtd128x_em7080_info = {
+	.name = "em7080",
+	.ext_freq = 27000000,
+	.has_eth0 = 1,
+	.has_pci = 0,
+	.has_pccard = 0,
+	.has_ohci0 = 1,
+	.has_ehci0 = 1,
+	.has_sata0 = 1,
+	.has_sata1 = 1,
+	.has_uart0 = 1,
+	.has_uart1 = 1,
+	.has_vfd = 0,
+	.machine_restart = NULL,
+	.machine_halt = NULL,
+	.machine_poweroff = NULL,
+};
+
+/*
+ * rtd128x reset and halt handlers
+ */
+
+static void rtd128x_common_machine_restart(char *cmd)
+{
+#ifdef CONFIG_RTD128X_WATCHDOG
+	/*
+	 * Use Watchdog to reset SoC
+	 */
+	kill_watchdog();
+#else
+	/*
+	 * TODO: Find a way to reset the SoC
+	 */
+	outl(0x0, RTD128X_TIMR_TCWCR);
+#endif
+	msleep(5000);
+}
+
+static void rtd128x_common_machine_halt(void)
+{
+	msleep(5000);
+}
+
+/*
+ * rtd128x soc
+ */
+
+static const char *rtd128x_get_soc_name(void)
+{
+	switch (rtd128x_board_info.chip_id) {
+	case RTD128X_CHIPID_VENUS:
+		return "Venus";
+	case RTD128X_CHIPID_NEPTUNE:
+		return "Neptune";
+	case RTD128X_CHIPID_MARS:
+		return "Mars";
+	case RTD128X_CHIPID_JUPITER:
+		return "Jupiter";
+	}
+	return "unknown";
+}
+
+void rtd128x_detect_soc(void)
+{
+	u32 id, rev;
+
+	id = inl(RTD128X_SB2_CHIP_ID);
+	rev = inl(RTD128X_SB2_CHIP_INFO);
+
+	rtd128x_board_info.chip_id = id & 0xffff;
+	rtd128x_board_info.chip_rev = (id >> 16) & 0xffff;
+
+	printk("Detected rtd%04x SoC, type %s rev %x\n",
+	       rtd128x_board_info.chip_id,
+	       rtd128x_get_soc_name(), rtd128x_board_info.chip_rev);
+}
+
+/*
+ * rtd128x boards
+ */
+
+static enum rtd128x_board_type rtd128x_detect_board(void)
+{
+	return RTD128X_BOARD_EM7080;
+
+	/*
+	 * TODO: Detect different board types
+	 */
+
+	return RTD128X_BOARD_UNKNOWN;
+}
+
+void rtd128x_board_setup(void)
+{
+	switch (rtd128x_detect_board()) {
+	case RTD128X_BOARD_EM7080:
+		memcpy(&rtd128x_board_info, &rtd128x_em7080_info,
+		       sizeof(struct rtd128x_board));
+		break;
+	default:
+		printk("Unknown rtd128x board.");
+		return;
+	}
+
+	if (rtd128x_board_info.machine_restart == NULL) {
+		rtd128x_board_info.machine_restart =
+		    rtd128x_common_machine_restart;
+	}
+
+	if (rtd128x_board_info.machine_halt == NULL) {
+		rtd128x_board_info.machine_halt = rtd128x_common_machine_halt;
+	}
+
+	if (rtd128x_board_info.machine_poweroff == NULL) {
+		rtd128x_board_info.machine_poweroff =
+		    rtd128x_common_machine_halt;
+	}
+
+	printk("Detected %s board\n", rtd128x_board_info.name);
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/irq.c linux-2.6.36/arch/mips/rtd128x/common/irq.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/irq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/irq.c	2010-11-19 18:10:09.000000000 +0100
@@ -0,0 +1,137 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/irq_cpu.h>
+#include <asm/processor.h>
+#include <asm/time.h>
+
+#include <rtd128x-board.h>
+#include <rtd128x-io.h>
+#include <rtd128x-irq.h>
+
+extern void rtd128x_sb2_setup(void);
+
+static int rtd128x_internal_irq_dispatch(void)
+{
+	u32 pending;
+	static int i;
+
+	pending = inl(RTD128X_MISC_ISR);
+
+	if (!pending)
+		return 0;
+
+	while (1) {
+		int to_call = i;
+
+		i = (i + 1) & 0x1f;
+		if (pending & (1 << to_call)) {
+			do_IRQ(to_call + RTD128X_INTERNAL_IRQ_BASE);
+			break;
+		}
+	}
+	return 1;
+}
+
+void plat_irq_dispatch(void)
+{
+	u32 cause;
+
+	cause = read_c0_cause() & read_c0_status() & CAUSEF_IP;
+
+	clear_c0_status(cause);
+
+	if (cause & CAUSEF_IP7)
+		do_IRQ(7);
+	if (cause & CAUSEF_IP2)
+		do_IRQ(2);
+	if ((cause & CAUSEF_IP3) && (!rtd128x_internal_irq_dispatch()))
+		do_IRQ(3);
+	if (cause & CAUSEF_IP4)
+		do_IRQ(4);
+	if (cause & CAUSEF_IP5)
+		do_IRQ(5);
+	if (cause & CAUSEF_IP6)
+		do_IRQ(6);
+}
+
+static inline void rtd128x_internal_irq_mask(unsigned int irq)
+{
+#if 0
+	u32 mask;
+
+	irq -= RTD128X_INTERNAL_IRQ_BASE;
+	mask = inl(RTD128X_MISC_UMSK_ISR);
+	mask &= ~(1 << irq);
+	outl(mask, RTD128X_MISC_UMSK_ISR);
+#endif
+}
+
+static void rtd128x_internal_irq_unmask(unsigned int irq)
+{
+#if 0
+	u32 mask;
+
+	irq -= RTD128X_INTERNAL_IRQ_BASE;
+	mask = inl(RTD128X_MISC_UMSK_ISR);
+	mask |= (1 << irq);
+	outl(mask, RTD128X__MISC_UMSK_ISR);
+#endif
+}
+
+static void rtd128x_internal_irq_ack(unsigned int irq)
+{
+	irq -= RTD128X_INTERNAL_IRQ_BASE;
+	outl((1 << irq), RTD128X_MISC_ISR);
+}
+
+static void rtd128x_internal_irq_mask_ack(unsigned int irq)
+{
+	rtd128x_internal_irq_mask(irq);
+	rtd128x_internal_irq_ack(irq);
+}
+
+static unsigned int rtd128x_internal_irq_startup(unsigned int irq)
+{
+	rtd128x_internal_irq_unmask(irq);
+	return 0;
+}
+
+static struct irq_chip rtd128x_internal_irq_chip = {
+	.name = "rtd128x-irq",
+	.startup = rtd128x_internal_irq_startup,
+	.shutdown = rtd128x_internal_irq_mask,
+	.ack = rtd128x_internal_irq_ack,
+	.mask = rtd128x_internal_irq_mask,
+	.mask_ack = rtd128x_internal_irq_mask_ack,
+	.unmask = rtd128x_internal_irq_unmask,
+};
+
+void __init arch_init_irq(void)
+{
+	int i;
+
+	/* disable RTC interrupts */
+	outl(0x0000, RTD128X_RTC_CR);
+
+	/* clear device interrupts */
+	outl(0x3ffc, RTD128X_MISC_ISR);
+
+	mips_cpu_irq_init();
+
+	for (i = 0; i < 32; ++i)
+		set_irq_chip_and_handler(RTD128X_INTERNAL_IRQ_BASE + i,
+					 &rtd128x_internal_irq_chip,
+					 handle_level_irq);
+
+	set_c0_status(1 << (RTD128X_IRQ_MISC + 8));
+
+	rtd128x_sb2_setup();
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/Makefile linux-2.6.36/arch/mips/rtd128x/common/Makefile
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/Makefile	2010-11-16 01:16:43.000000000 +0100
@@ -0,0 +1,10 @@
+obj-$(CONFIG_RTD128X) += platform.o
+obj-$(CONFIG_RTD128X) += irq.o
+obj-$(CONFIG_RTD128X) += memory.o
+obj-$(CONFIG_RTD128X) += prom.o
+obj-$(CONFIG_RTD128X) += setup.o
+obj-$(CONFIG_RTD128X) += time.o
+obj-$(CONFIG_RTD128X) += board.o
+obj-$(CONFIG_RTD128X) += printk.o
+obj-$(CONFIG_RTD128X) += sb2.o
+
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/memory.c linux-2.6.36/arch/mips/rtd128x/common/memory.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/memory.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/memory.c	2010-11-19 18:10:26.000000000 +0100
@@ -0,0 +1,202 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/bootmem.h>
+#include <linux/pfn.h>
+#include <linux/string.h>
+
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/sections.h>
+
+#include <asm/mips-boards/prom.h>
+#include <rtd128x-board.h>
+#include <rtd128x-soc.h>
+
+//#define DEBUG
+
+enum yamon_memtypes {
+	yamon_dontuse,
+	yamon_prom,
+	yamon_free,
+};
+static struct prom_pmemblock mdesc[PROM_MAX_PMEMBLOCKS];
+
+#ifdef DEBUG
+static char *mtypes[3] = {
+	"Dont use memory",
+	"YAMON PROM memory",
+	"Free memmory",
+};
+#endif
+
+/* determined physical memory size, not overridden by command line args  */
+unsigned long physical_memsize = 0L;
+unsigned long lexra_membase = 0L;
+
+static struct prom_pmemblock *__init prom_getmdesc(void)
+{
+	char *memsize_str;
+	unsigned int memsize;
+	char *ptr;
+	static char cmdline[COMMAND_LINE_SIZE] __initdata;
+
+	/* otherwise look in the environment */
+	memsize_str = prom_getenv("memsize");
+	if (!memsize_str) {
+		printk(KERN_WARNING
+		       "memsize not set in boot prom, set to default (32Mb)\n");
+		physical_memsize = 0x02000000;
+	} else {
+#ifdef DEBUG
+		pr_debug("prom_memsize = %s\n", memsize_str);
+#endif
+		physical_memsize = simple_strtol(memsize_str, NULL, 0);
+	}
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	/* SOC-it swaps, or perhaps doesn't swap, when DMA'ing the last
+	   word of physical memory */
+	physical_memsize -= PAGE_SIZE;
+#endif
+
+	/* Check the command line for a memsize directive that overrides
+	   the physical/default amount */
+	strcpy(cmdline, arcs_cmdline);
+	ptr = strstr(cmdline, "memsize=");
+	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " memsize=");
+
+	if (ptr)
+		memsize = memparse(ptr + 8, &ptr);
+	else
+		memsize = physical_memsize;
+
+	/* Check the command line for lexra_membase directive that overrides
+	   the default base address */
+	ptr = strstr(cmdline, "lexra_membase=");
+	if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
+		ptr = strstr(ptr, " lexra_membase=");
+
+	if (ptr)
+		lexra_membase = memparse(ptr + 8, &ptr);
+	else
+		lexra_membase = RTD128X_DEFAULT_LEXRA_MEMBASE;
+
+	lexra_membase = CPHYSADDR(PFN_ALIGN(lexra_membase));
+
+	memset(mdesc, 0, sizeof(mdesc));
+
+	/*
+	 * free pre-kernel memory
+	 */
+	mdesc[0].type = yamon_free;
+	mdesc[0].base = 0x00000000;
+	mdesc[0].size = CPHYSADDR(PFN_ALIGN(&_text));
+
+	/*
+	 * protect kernel memory
+	 */
+	mdesc[1].type = yamon_dontuse;
+	mdesc[1].base = CPHYSADDR(PFN_ALIGN(&_text));
+	mdesc[1].size = CPHYSADDR(PFN_ALIGN(&_end)) - mdesc[1].base;
+
+	/*
+	 * free post-kernel memory
+	 */
+	mdesc[2].type = yamon_free;
+	mdesc[2].base = CPHYSADDR(PFN_ALIGN(&_end));
+	mdesc[2].size = lexra_membase - mdesc[2].base;
+
+	/*
+	 * protect lexra memory
+	 */
+	mdesc[3].type = yamon_dontuse;
+	mdesc[3].base = lexra_membase;
+	mdesc[3].size = RTD128X_DEFAULT_HIGHMEM_START - mdesc[3].base;
+
+	/*
+	 * kernel high memory
+	 */
+	mdesc[4].type = yamon_free;
+	mdesc[4].base = RTD128X_DEFAULT_HIGHMEM_START;
+	mdesc[4].size = memsize - mdesc[4].base;
+
+	return &mdesc[0];
+}
+
+static int __init prom_memtype_classify(unsigned int type)
+{
+	switch (type) {
+	case yamon_free:
+		return BOOT_MEM_RAM;
+	case yamon_prom:
+		return BOOT_MEM_ROM_DATA;
+	default:
+		return BOOT_MEM_RESERVED;
+	}
+}
+
+void __init prom_meminit(void)
+{
+	struct prom_pmemblock *p;
+
+	p = prom_getmdesc();
+	while (p->size) {
+		long type;
+		unsigned long base, size;
+
+		type = prom_memtype_classify(p->type);
+		base = p->base;
+		size = p->size;
+		add_memory_region(base, size, type);
+		p++;
+	}
+}
+
+void __init prom_free_prom_memory(void)
+{
+	unsigned long addr;
+	unsigned long recl = 0;
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		if (boot_mem_map.map[i].type != BOOT_MEM_ROM_DATA)
+			continue;
+
+		addr = boot_mem_map.map[i].addr;
+		free_init_pages("prom memory",
+				addr, addr + boot_mem_map.map[i].size);
+		recl +=
+		    (1 +
+		     (boot_mem_map.map[i].size >> PAGE_SHIFT)) << PAGE_SHIFT;
+	}
+
+	printk("Freeing PROM memory: %luk\n", recl / 1024);
+
+#ifdef CONFIG_RTD128X_RECLAIM_BOOT_MEMORY
+	{
+		unsigned long addr = 0;
+		unsigned long dest = 0;
+
+		if (rtd138x_is_mars_cpu()) {
+			addr = F_ADDR2;
+			dest = (debug_flag) ? T_ADDR1 : T_ADDR3;
+		} else {
+			addr = F_ADDR1;
+			dest = (debug_flag) ? T_ADDR1 : T_ADDR2;
+		}
+
+		free_init_pages("bootloader memory", addr, dest);
+		recl = dest - addr;
+		recl = (1 + (recl >> PAGE_SHIFT)) << PAGE_SHIFT;
+		printk("Reclaimed bootloader memory: %luk\n", recl);
+	}
+#endif
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/platform.c linux-2.6.36/arch/mips/rtd128x/common/platform.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/platform.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/platform.c	2010-11-19 18:10:34.000000000 +0100
@@ -0,0 +1,103 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <asm/time.h>
+
+#include <rtd128x-board.h>
+#include <rtd128x-soc.h>
+#include <rtd128x-irq.h>
+#include <rtd128x-io.h>
+
+/*
+ * rtd128x uart
+ */
+
+static unsigned int rtd128x_serial_in(struct uart_port *p, int offset)
+{
+	offset <<= p->regshift;
+	return readl(p->membase + offset) & 0xff;
+}
+
+static void rtd128x_serial_out(struct uart_port *p, int offset, int value)
+{
+	offset <<= p->regshift;
+	writel(value & 0xff, p->membase + offset);
+}
+
+static struct plat_serial8250_port rtd128x_serial_data[] = {
+	[0] = {},
+	[1] = {},
+	{}
+};
+
+static struct platform_device rtd128x_serial8250_device = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = rtd128x_serial_data,
+		},
+};
+
+static void __init rtd128x_register_uart(void)
+{
+	int n = 0;
+
+	if (rtd128x_board_info.has_uart0) {
+		rtd128x_serial_data[n].iobase = RTD128X_UART0_BASE;
+		rtd128x_serial_data[n].membase =
+		    (unsigned char __iomem *)KSEG1ADDR(RTD128X_IO_PORT_BASE +
+						       RTD128X_UART0_BASE);
+		rtd128x_serial_data[n].mapbase =
+		    RTD128X_IO_PORT_BASE + RTD128X_UART0_BASE;
+		rtd128x_serial_data[n].irq = RTD128X_IRQ_UART0;
+		rtd128x_serial_data[1].uartclk = rtd128x_board_info.ext_freq;
+		rtd128x_serial_data[n].iotype = UPIO_MEM;
+		rtd128x_serial_data[n].flags = UPF_BOOT_AUTOCONF;
+		rtd128x_serial_data[n].regshift = 2;
+		rtd128x_serial_data[n].serial_in = &rtd128x_serial_in;
+		rtd128x_serial_data[n].serial_out = &rtd128x_serial_out;
+		n++;
+	}
+
+	if (rtd128x_board_info.has_uart1) {
+		rtd128x_serial_data[n].iobase = RTD128X_UART1_BASE;
+		rtd128x_serial_data[n].membase =
+		    (unsigned char __iomem *)KSEG1ADDR(RTD128X_IO_PORT_BASE +
+						       RTD128X_UART1_BASE);
+		rtd128x_serial_data[n].mapbase =
+		    RTD128X_IO_PORT_BASE + RTD128X_UART1_BASE;
+		rtd128x_serial_data[n].irq = RTD128X_IRQ_UART1;
+		rtd128x_serial_data[0].uartclk = rtd128x_board_info.ext_freq;
+		rtd128x_serial_data[n].iotype = UPIO_MEM;
+		rtd128x_serial_data[n].flags = UPF_BOOT_AUTOCONF;
+		rtd128x_serial_data[n].regshift = 2;
+		rtd128x_serial_data[n].serial_in = &rtd128x_serial_in;
+		rtd128x_serial_data[n].serial_out = &rtd128x_serial_out;
+		n++;
+	}
+
+	if (n)
+		platform_device_register(&rtd128x_serial8250_device);
+}
+
+/*
+ * platform and device init
+ */
+
+void __init platform_init(void)
+{
+}
+
+static int __init rtd128x_devinit(void)
+{
+	rtd128x_register_uart();
+	return 0;
+}
+
+device_initcall(rtd128x_devinit);
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/printk.c linux-2.6.36/arch/mips/rtd128x/common/printk.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/printk.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/printk.c	2010-11-19 18:10:44.000000000 +0100
@@ -0,0 +1,33 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <asm/io.h>
+#include <rtd128x-io.h>
+
+#define UART_LSR_TEMT		0x40	/* Transmitter empty */
+#define UART_LSR_THRE		0x20	/* Transmit-hold-register empty */
+
+static void __init wait_xfered(void)
+{
+	unsigned int val;
+
+	/* wait for any previous char to be transmitted */
+	do {
+		val = inl(RTD128X_UART_U0LSR);
+		if ((val & (UART_LSR_TEMT | UART_LSR_THRE)) ==
+		    (UART_LSR_TEMT | UART_LSR_THRE))
+			break;
+	} while (1);
+}
+
+void __init prom_putchar(char c)
+{
+	wait_xfered();
+	outl(c, RTD128X_UART_U0RBR_THR_DLL);
+	wait_xfered();
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/prom.c linux-2.6.36/arch/mips/rtd128x/common/prom.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/prom.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/prom.c	2010-11-19 18:11:05.000000000 +0100
@@ -0,0 +1,250 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+#include <asm/bootinfo.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <asm/cacheflush.h>
+#include <asm/traps.h>
+
+#include <rtd128x-board.h>
+#include <rtd128x-soc.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/mips-boards/generic.h>
+
+extern void platform_init(void);
+extern void platform_setup(void);
+extern void prom_putchar(char);
+extern void rtd128x_detect_soc(void);
+
+//#define DEBUG
+
+void prom_puts(char *s)
+{
+	while (*s != '\0') {
+		if (*s == '\n') {
+			prom_putchar(*s++);
+			prom_putchar('\r');
+		} else
+			prom_putchar(*s++);
+	}
+}
+
+void prom_puthex(unsigned long l)
+{
+	char n;
+	int i;
+	prom_putchar('0');
+	prom_putchar('x');
+	for (i = 7; i >= 0; i--) {
+		n = (char)((l >> (4 * i)) & 0xf);
+		switch (n) {
+		case 10:
+			prom_putchar('a');
+			break;
+		case 11:
+			prom_putchar('b');
+			break;
+		case 12:
+			prom_putchar('c');
+			break;
+		case 13:
+			prom_putchar('d');
+			break;
+		case 14:
+			prom_putchar('e');
+			break;
+		case 15:
+			prom_putchar('f');
+			break;
+		default:
+			prom_putchar(0x30 + n);
+		}
+	}
+}
+
+int prom_argc;
+int *_prom_argv, *_prom_envp;
+unsigned long _prom_memsize;
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension, if running in 64-bit mode.
+ */
+#define prom_envp(index) ((char *)(long)_prom_envp[(index)])
+
+char *prom_getenv(char *envname)
+{
+	char *result = NULL;
+
+	if (_prom_envp != NULL) {
+		/*
+		 * Return a pointer to the given environment variable.
+		 * In 64-bit mode: we're using 64-bit pointers, but all pointers
+		 * in the PROM structures are only 32-bit, so we need some
+		 * workarounds, if we are running in 64-bit mode.
+		 */
+		int i, index = 0;
+
+		i = strlen(envname);
+
+		while (prom_envp(index)) {
+			if (strncmp(envname, prom_envp(index), i) == 0) {
+				result = prom_envp(index + 1);
+				break;
+			}
+			index += 2;
+		}
+	}
+
+	return result;
+}
+
+/*
+ * YAMON (32-bit PROM) pass arguments and environment as 32-bit pointer.
+ * This macro take care of sign extension.
+ */
+#define prom_argv(index) ((char *)(long)_prom_argv[(index)])
+
+char *__init prom_getcmdline(void)
+{
+	return &(arcs_cmdline[0]);
+}
+
+void __init prom_init_cmdline(void)
+{
+	char *cp;
+	int actr;
+
+	actr = 1;		/* Always ignore argv[0] */
+
+	cp = &(arcs_cmdline[0]);
+	while (actr < prom_argc) {
+		strcpy(cp, prom_argv(actr));
+		cp += strlen(prom_argv(actr));
+		*cp++ = ' ';
+		actr++;
+	}
+	if (cp != &(arcs_cmdline[0])) {
+		/* get rid of trailing space */
+		--cp;
+		*cp = '\0';
+	}
+}
+
+/* TODO: Verify on linux-mips mailing list that the following two  */
+/* functions are correct                                           */
+/* TODO: Copy NMI and EJTAG exception vectors to memory from the   */
+/* BootROM exception vectors. Flush their cache entries. test it.  */
+
+static void __init mips_nmi_setup(void)
+{
+	void *base;
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+	    (void *)(CAC_BASE + 0xa80) : (void *)(CAC_BASE + 0x380);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00000;
+#else
+#error NMI exception handler address not defined
+#endif
+}
+
+static void __init mips_ejtag_setup(void)
+{
+	void *base;
+
+#if defined(CONFIG_CPU_MIPS32_R1)
+	base = cpu_has_veic ?
+	    (void *)(CAC_BASE + 0xa00) : (void *)(CAC_BASE + 0x300);
+#elif defined(CONFIG_CPU_MIPS32_R2)
+	base = (void *)0xbfc00480;
+#else
+#error EJTAG exception handler address not defined
+#endif
+}
+
+void __init rtd128x_env_get_bootrev(void)
+{
+	char *envp;
+	unsigned short v0, v1, v2;
+
+	envp = prom_getenv("bootrev");
+	if (envp) {
+		strcpy(rtd128x_board_info.bootrev, envp);
+		sscanf(envp, "%hx.%hx.%hx", &v0, &v1, &v2);
+
+		rtd128x_board_info.company_id = v0;
+		rtd128x_board_info.board_id = (v0 << 16) | v1;
+
+		/* old bootrev format : aa.bb.ccc */
+		/* new bootrev format : aaaa.bbbb.cccc */
+		if (envp[2] == '.')
+			rtd128x_board_info.cpu_id = (v1 & 0xf0) >> 4;
+		else
+			rtd128x_board_info.cpu_id = (v1 & 0xff00) >> 8;
+#ifdef DEBUG
+		printk
+		    ("bootrev = '%s' => company_id = %04x, cpu_id = %02x, board_id = %08x\n",
+		     rtd128x_board_info.bootrev, rtd128x_board_info.company_id,
+		     rtd128x_board_info.cpu_id, rtd128x_board_info.board_id);
+#endif
+	}
+}
+
+void __init prom_init(void)
+{
+	int i;
+	prom_argc = fw_arg0;
+	_prom_argv = (int *)fw_arg1;
+	_prom_envp = (int *)fw_arg2;
+	_prom_memsize = (unsigned long)fw_arg3;
+
+	board_nmi_handler_setup = mips_nmi_setup;
+	board_ejtag_handler_setup = mips_ejtag_setup;
+
+	rtd128x_board_info.memory_size = _prom_memsize;
+
+	rtd128x_env_get_bootrev();
+
+	set_io_port_base(KSEG1ADDR(RTD128X_IO_PORT_BASE));
+	rtd128x_detect_soc();
+
+	platform_init();
+	prom_init_cmdline();
+	prom_meminit();
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/sb2.c linux-2.6.36/arch/mips/rtd128x/common/sb2.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/sb2.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/sb2.c	2010-11-19 18:11:12.000000000 +0100
@@ -0,0 +1,46 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+#include <rtd128x-io.h>
+#include <rtd128x-irq.h>
+
+static irqreturn_t rtd128x_sb2_irq_handler(int irq, void *dev_id)
+{
+	unsigned int addr;
+
+	if (!(inl(RTD128X_SB2_INV_INTSTAT) & 0x2))
+		return IRQ_NONE;
+
+	/* 
+	 * The seems to be a problem on Mars with prefetching
+	 * specific memory regions. This patch should circumvent
+	 * this bug.
+	 */
+	addr = inl(RTD128X_SB2_INV_ADDR);
+	if (addr > 0x8001000 && ((addr & 0xfffff000) != 0x1800c000)) {
+		printk("Access to invalid hw address 0x%x\n", addr);
+	}
+	outl(0xE, RTD128X_SB2_INV_INTSTAT);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction rtd128x_sb2_irq_action = {
+	.handler = rtd128x_sb2_irq_handler,
+	.flags = IRQF_SHARED,
+	.name = "rtd128x-sb2",
+};
+
+void __init rtd128x_sb2_setup(void)
+{
+	outl(0x3, RTD128X_SB2_INV_INTEN);
+	outl(0xe, RTD128X_SB2_INV_INTSTAT);
+	setup_irq(RTD128X_IRQ_SB2, &rtd128x_sb2_irq_action);
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/setup.c linux-2.6.36/arch/mips/rtd128x/common/setup.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/setup.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/setup.c	2010-11-19 18:11:21.000000000 +0100
@@ -0,0 +1,179 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/screen_info.h>
+#include <linux/notifier.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/ctype.h>
+#include <linux/cpu.h>
+#include <linux/time.h>
+
+#include <asm/bootinfo.h>
+#include <asm/irq.h>
+#include <asm/mips-boards/generic.h>
+#include <asm/mips-boards/prom.h>
+#include <asm/dma.h>
+#include <asm/time.h>
+#include <asm/asm.h>
+#include <asm/traps.h>
+#include <asm/reboot.h>
+#include <asm/asm-offsets.h>
+
+#include <rtd128x-board.h>
+
+extern void rtd128x_board_setup(void);
+
+#define VAL(n)		STR(n)
+
+/*
+ * Macros for loading addresses and storing registers:
+ * LONG_L_	Stringified version of LONG_L for use in asm() statement
+ * LONG_S_	Stringified version of LONG_S for use in asm() statement
+ * PTR_LA_	Stringified version of PTR_LA for use in asm() statement
+ * REG_SIZE	Number of 8-bit bytes in a full width register
+ */
+#define LONG_L_		VAL(LONG_L) " "
+#define LONG_S_		VAL(LONG_S) " "
+#define PTR_LA_		VAL(PTR_LA) " "
+
+#ifdef CONFIG_64BIT
+#warning TODO: 64-bit code needs to be verified
+#define REG_SIZE	"8"	/* In bytes */
+#endif
+
+#ifdef CONFIG_32BIT
+#define REG_SIZE	"4"	/* In bytes */
+#endif
+
+static void register_panic_notifier(void);
+static int panic_handler(struct notifier_block *notifier_block,
+			 unsigned long event, void *cause_string);
+
+/*
+ * Install a panic notifier for platform-specific diagnostics
+ */
+static void register_panic_notifier()
+{
+	static struct notifier_block panic_notifier = {
+		.notifier_call = panic_handler,
+		.next = NULL,
+		.priority = INT_MAX
+	};
+	atomic_notifier_chain_register(&panic_notifier_list, &panic_notifier);
+}
+
+static int panic_handler(struct notifier_block *notifier_block,
+			 unsigned long event, void *cause_string)
+{
+	struct pt_regs my_regs;
+
+	/* Save all of the registers */
+	{
+		unsigned long at, v0, v1;	/* Must be on the stack */
+
+		/* Start by saving $at and v0 on the stack. We use $at
+		 * ourselves, but it looks like the compiler may use v0 or v1
+		 * to load the address of the pt_regs structure. We'll come
+		 * back later to store the registers in the pt_regs
+		 * structure. */
+		__asm__ __volatile__(".set	noat\n"
+				     LONG_S_ "$at, %[at]\n"
+				     LONG_S_ "$2, %[v0]\n"
+				     LONG_S_ "$3, %[v1]\n":
+				     [at] "=m"(at),[v0] "=m"(v0),[v1] "=m"(v1)
+				     ::"at");
+
+		__asm__ __volatile__(".set	noat\n"
+				     "move		$at, %[pt_regs]\n"
+				     /* Argument registers */
+				     LONG_S_ "$4, " VAL(PT_R4) "($at)\n"
+				     LONG_S_ "$5, " VAL(PT_R5) "($at)\n"
+				     LONG_S_ "$6, " VAL(PT_R6) "($at)\n"
+				     LONG_S_ "$7, " VAL(PT_R7) "($at)\n"
+				     /* Temporary regs */
+				     LONG_S_ "$8, " VAL(PT_R8) "($at)\n"
+				     LONG_S_ "$9, " VAL(PT_R9) "($at)\n"
+				     LONG_S_ "$10, " VAL(PT_R10) "($at)\n"
+				     LONG_S_ "$11, " VAL(PT_R11) "($at)\n"
+				     LONG_S_ "$12, " VAL(PT_R12) "($at)\n"
+				     LONG_S_ "$13, " VAL(PT_R13) "($at)\n"
+				     LONG_S_ "$14, " VAL(PT_R14) "($at)\n"
+				     LONG_S_ "$15, " VAL(PT_R15) "($at)\n"
+				     /* "Saved" registers */
+				     LONG_S_ "$16, " VAL(PT_R16) "($at)\n"
+				     LONG_S_ "$17, " VAL(PT_R17) "($at)\n"
+				     LONG_S_ "$18, " VAL(PT_R18) "($at)\n"
+				     LONG_S_ "$19, " VAL(PT_R19) "($at)\n"
+				     LONG_S_ "$20, " VAL(PT_R20) "($at)\n"
+				     LONG_S_ "$21, " VAL(PT_R21) "($at)\n"
+				     LONG_S_ "$22, " VAL(PT_R22) "($at)\n"
+				     LONG_S_ "$23, " VAL(PT_R23) "($at)\n"
+				     /* Add'l temp regs */
+				     LONG_S_ "$24, " VAL(PT_R24) "($at)\n"
+				     LONG_S_ "$25, " VAL(PT_R25) "($at)\n"
+				     /* Kernel temp regs */
+				     LONG_S_ "$26, " VAL(PT_R26) "($at)\n"
+				     LONG_S_ "$27, " VAL(PT_R27) "($at)\n"
+				     /* Global pointer, stack pointer, frame pointer and
+				      * return address */
+				     LONG_S_ "$gp, " VAL(PT_R28) "($at)\n"
+				     LONG_S_ "$sp, " VAL(PT_R29) "($at)\n"
+				     LONG_S_ "$fp, " VAL(PT_R30) "($at)\n"
+				     LONG_S_ "$ra, " VAL(PT_R31) "($at)\n"
+				     /* Now we can get the $at and v0 registers back and
+				      * store them */
+				     LONG_L_ "$8, %[at]\n"
+				     LONG_S_ "$8, " VAL(PT_R1) "($at)\n"
+				     LONG_L_ "$8, %[v0]\n"
+				     LONG_S_ "$8, " VAL(PT_R2) "($at)\n"
+				     LONG_L_ "$8, %[v1]\n"
+				     LONG_S_ "$8, " VAL(PT_R3) "($at)\n"::
+				     [at] "m"(at),
+				     [v0] "m"(v0),
+				     [v1] "m"(v1),[pt_regs] "r"(&my_regs)
+				     :"at", "t0");
+
+		/* Set the current EPC value to be the current location in this
+		 * function */
+		__asm__ __volatile__(".set	noat\n"
+				     "1:\n"
+				     PTR_LA_ "$at, 1b\n"
+				     LONG_S_ "$at, %[cp0_epc]\n":
+				     [cp0_epc] "=m"(my_regs.cp0_epc)
+				     ::"at");
+
+		my_regs.cp0_cause = read_c0_cause();
+		my_regs.cp0_status = read_c0_status();
+	}
+
+	pr_crit("I'm feeling a bit sleepy. hmmmmm... perhaps a nap would... "
+		"zzzz... \n");
+
+	return NOTIFY_DONE;
+}
+
+const char *get_system_type(void)
+{
+	return rtd128x_board_info.name;
+}
+
+void __init plat_mem_setup(void)
+{
+	panic_on_oops = 1;
+	register_panic_notifier();
+
+	_machine_restart = rtd128x_board_info.machine_restart;
+	_machine_halt = rtd128x_board_info.machine_halt;
+	pm_power_off = rtd128x_board_info.machine_poweroff;
+
+	rtd128x_board_setup();
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/common/time.c linux-2.6.36/arch/mips/rtd128x/common/time.c
--- linux-2.6.36-vanilla/arch/mips/rtd128x/common/time.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/common/time.c	2010-11-19 18:11:27.000000000 +0100
@@ -0,0 +1,87 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel_stat.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+#include <asm/mipsregs.h>
+#include <asm/mipsmtregs.h>
+#include <asm/hardirq.h>
+#include <asm/irq.h>
+#include <asm/div64.h>
+#include <asm/cpu.h>
+#include <asm/time.h>
+
+#include <rtd128x-io.h>
+#include <rtd128x-irq.h>
+#include <rtd128x-board.h>
+
+extern void platform_setup(void);
+
+unsigned long cpu_khz;
+
+/*
+ * Estimate CPU frequency.  Sets mips_hpt_frequency as a side-effect
+ */
+static unsigned int __init estimate_cpu_frequency(void)
+{
+	unsigned long flags;
+	unsigned int count;
+	unsigned int cause;
+
+	local_irq_save(flags);
+
+	cause = read_c0_cause();
+	write_c0_cause(cause & ~0x08000000);
+	outl(0, RTD128X_TIMR_TC2CR);
+	outl(0x80000000, RTD128X_TIMR_TC2CR);
+
+	write_c0_count(0);
+
+	while (inl(RTD128X_TIMR_TC2CVR) < (rtd128x_board_info.ext_freq / HZ)) ;
+
+	count = read_c0_count();
+
+	write_c0_cause(cause);
+	outl(0, RTD128X_TIMR_TC2CR);
+
+	local_irq_restore(flags);
+
+	count *= HZ;
+	count *= 2;
+	count += 5000;		/* round */
+	count -= count % 10000;
+
+	return count;
+}
+
+unsigned int __init get_c0_compare_int(void)
+{
+	return RTD128X_IRQ_TIMER;
+}
+
+void __init plat_time_init(void)
+{
+	unsigned int est_freq;
+
+	est_freq = estimate_cpu_frequency();
+
+	printk("CPU frequency %d.%02d MHz\n", est_freq / 1000000,
+	       (est_freq % 1000000) * 100 / 1000000);
+
+	write_c0_count(0);
+	write_c0_compare(0xffff);
+	write_c0_cause(read_c0_cause() & ~0x08000000);
+
+	mips_hpt_frequency = est_freq;
+}
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/Kconfig linux-2.6.36/arch/mips/rtd128x/Kconfig
--- linux-2.6.36-vanilla/arch/mips/rtd128x/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/Kconfig	2010-11-19 18:09:41.000000000 +0100
@@ -0,0 +1,14 @@
+config RTD128X_RECLAIM_BOOT_MEMORY
+        bool "reclaim memory from bootloader"
+
+#
+# FIXME: do we really need this?
+#
+#config RTD128X_EXTERNAL_TIMER
+#        bool "use external timer interrupt"
+
+#
+# TODO
+#
+#config RTD128X_WATCHDOG
+#        bool "use internal watchdog"
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/Makefile linux-2.6.36/arch/mips/rtd128x/Makefile
--- linux-2.6.36-vanilla/arch/mips/rtd128x/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/Makefile	2010-11-16 01:16:43.000000000 +0100
@@ -0,0 +1 @@
+obj-$(CONFIG_RTD128X) += common/
diff -uNr linux-2.6.36-vanilla/arch/mips/rtd128x/Platform linux-2.6.36/arch/mips/rtd128x/Platform
--- linux-2.6.36-vanilla/arch/mips/rtd128x/Platform	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.36/arch/mips/rtd128x/Platform	2010-11-16 01:16:43.000000000 +0100
@@ -0,0 +1,8 @@
+#
+# Realtek Galaxy SoC boards
+#
+
+platform-${CONFIG_RTD128X} += rtd128x/
+cflags-${CONFIG_RTD128X}   += -I$(srctree)/arch/mips/include/asm/mach-rtd128x/
+load-${CONFIG_RTD128X}     := 0xffffffff80100000
+all-$(CONFIG_RTD128X)      := $(COMPRESSION_FNAME).bin
