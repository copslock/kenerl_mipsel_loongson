Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Mar 2005 10:49:10 +0000 (GMT)
Received: from coderock.org ([IPv6:::ffff:193.77.147.115]:18347 "EHLO
	trashy.coderock.org") by linux-mips.org with ESMTP
	id <S8225464AbVCFKqU>; Sun, 6 Mar 2005 10:46:20 +0000
Received: by trashy.coderock.org (Postfix, from userid 780)
	id CF5901F240; Sun,  6 Mar 2005 11:46:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id C7E761F204;
	Sun,  6 Mar 2005 11:46:16 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by trashy.coderock.org (Postfix) with ESMTP id 594361F203;
	Sun,  6 Mar 2005 11:45:57 +0100 (CET)
Subject: [patch 4/8] delete unused file include_asm_mips_mach_au1x00_au1100_mmc.h
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, domen@coderock.org
From:	domen@coderock.org
Date:	Sun, 06 Mar 2005 11:45:57 +0100
Message-Id: <20050306104557.594361F203@trashy.coderock.org>
Return-Path: <domen@coderock.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen@coderock.org
Precedence: bulk
X-list: linux-mips


Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj/include/asm-mips/mach-au1x00/au1100_mmc.h |  205 ---------------------------
 1 files changed, 205 deletions(-)

diff -L include/asm-mips/mach-au1x00/au1100_mmc.h -puN include/asm-mips/mach-au1x00/au1100_mmc.h~remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h /dev/null
--- kj/include/asm-mips/mach-au1x00/au1100_mmc.h
+++ /dev/null	2005-03-02 11:34:59.000000000 +0100
@@ -1,205 +0,0 @@
-/*
- * BRIEF MODULE DESCRIPTION
- *	Defines for using the MMC/SD controllers on the
- *      Alchemy Au1100 mips processor.
- *
- * Copyright (c) 2003 Embedded Edge, LLC.
- * Author: Embedded Edge, LLC.
- *         	dan@embeddededge.com or tim@embeddededge.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- */
-/*
- * AU1100 MMC/SD definitions.
- *
- * From "AMD Alchemy Solutions Au1100 Processor Data Book - Preliminary"
- *    June, 2003
- */
-
-#ifndef __ASM_AU1100_MMC_H
-#define __ASM_AU1100_MMC_H
-
-
-#define NUM_AU1100_MMC_CONTROLLERS	2
-
-
-#define AU1100_SD_IRQ	2
-
-
-#define SD0_BASE	0xB0600000
-#define SD1_BASE	0xB0680000
-
-
-/*
- *  Register offsets.
- */
-#define SD_TXPORT	(0x0000)
-#define SD_RXPORT	(0x0004)
-#define SD_CONFIG	(0x0008)
-#define SD_ENABLE	(0x000C)
-#define SD_CONFIG2	(0x0010)
-#define SD_BLKSIZE	(0x0014)
-#define SD_STATUS	(0x0018)
-#define SD_DEBUG	(0x001C)
-#define SD_CMD		(0x0020)
-#define SD_CMDARG	(0x0024)
-#define SD_RESP3	(0x0028)
-#define SD_RESP2	(0x002C)
-#define SD_RESP1	(0x0030)
-#define SD_RESP0	(0x0034)
-#define SD_TIMEOUT	(0x0038)
-
-
-/*
- *  SD_TXPORT bit definitions.
- */
-#define SD_TXPORT_TXD	(0x000000ff)
-
-
-/*
- *  SD_RXPORT bit definitions.
- */
-#define SD_RXPORT_RXD	(0x000000ff)
-
-
-/*
- *  SD_CONFIG bit definitions.
- */
-#define SD_CONFIG_DIV	(0x000001ff)
-#define SD_CONFIG_DE	(0x00000200)
-#define SD_CONFIG_NE	(0x00000400)
-#define SD_CONFIG_TU	(0x00000800)
-#define SD_CONFIG_TO	(0x00001000)
-#define SD_CONFIG_RU	(0x00002000)
-#define SD_CONFIG_RO	(0x00004000)
-#define SD_CONFIG_I	(0x00008000)
-#define SD_CONFIG_CR	(0x00010000)
-#define SD_CONFIG_RAT	(0x00020000)
-#define SD_CONFIG_DD	(0x00040000)
-#define SD_CONFIG_DT	(0x00080000)
-#define SD_CONFIG_SC	(0x00100000)
-#define SD_CONFIG_RC	(0x00200000)
-#define SD_CONFIG_WC	(0x00400000)
-#define SD_CONFIG_xxx	(0x00800000)
-#define SD_CONFIG_TH	(0x01000000)
-#define SD_CONFIG_TE	(0x02000000)
-#define SD_CONFIG_TA	(0x04000000)
-#define SD_CONFIG_RH	(0x08000000)
-#define SD_CONFIG_RA	(0x10000000)
-#define SD_CONFIG_RF	(0x20000000)
-#define SD_CONFIG_CD	(0x40000000)
-#define SD_CONFIG_SI	(0x80000000)
-
-
-/*
- *  SD_ENABLE bit definitions.
- */
-#define SD_ENABLE_CE	(0x00000001)
-#define SD_ENABLE_R	(0x00000002)
-
-
-/*
- *  SD_CONFIG2 bit definitions.
- */
-#define SD_CONFIG2_EN	(0x00000001)
-#define SD_CONFIG2_FF	(0x00000002)
-#define SD_CONFIG2_xx1	(0x00000004)
-#define SD_CONFIG2_DF	(0x00000008)
-#define SD_CONFIG2_DC	(0x00000010)
-#define SD_CONFIG2_xx2	(0x000000e0)
-#define SD_CONFIG2_WB	(0x00000100)
-#define SD_CONFIG2_RW	(0x00000200)
-
-
-/*
- *  SD_BLKSIZE bit definitions.
- */
-#define SD_BLKSIZE_BS	(0x000007ff)
-#define SD_BLKSIZE_BS_SHIFT	 (0)
-#define SD_BLKSIZE_BC	(0x01ff0000)
-#define SD_BLKSIZE_BC_SHIFT	(16)
-
-
-/*
- *  SD_STATUS bit definitions.
- */
-#define SD_STATUS_DCRCW	(0x00000007)
-#define SD_STATUS_xx1	(0x00000008)
-#define SD_STATUS_CB	(0x00000010)
-#define SD_STATUS_DB	(0x00000020)
-#define SD_STATUS_CF	(0x00000040)
-#define SD_STATUS_D3	(0x00000080)
-#define SD_STATUS_xx2	(0x00000300)
-#define SD_STATUS_NE	(0x00000400)
-#define SD_STATUS_TU	(0x00000800)
-#define SD_STATUS_TO	(0x00001000)
-#define SD_STATUS_RU	(0x00002000)
-#define SD_STATUS_RO	(0x00004000)
-#define SD_STATUS_I	(0x00008000)
-#define SD_STATUS_CR	(0x00010000)
-#define SD_STATUS_RAT	(0x00020000)
-#define SD_STATUS_DD	(0x00040000)
-#define SD_STATUS_DT	(0x00080000)
-#define SD_STATUS_SC	(0x00100000)
-#define SD_STATUS_RC	(0x00200000)
-#define SD_STATUS_WC	(0x00400000)
-#define SD_STATUS_xx3	(0x00800000)
-#define SD_STATUS_TH	(0x01000000)
-#define SD_STATUS_TE	(0x02000000)
-#define SD_STATUS_TA	(0x04000000)
-#define SD_STATUS_RH	(0x08000000)
-#define SD_STATUS_RA	(0x10000000)
-#define SD_STATUS_RF	(0x20000000)
-#define SD_STATUS_CD	(0x40000000)
-#define SD_STATUS_SI	(0x80000000)
-
-
-/*
- *  SD_CMD bit definitions.
- */
-#define SD_CMD_GO	(0x00000001)
-#define SD_CMD_RY	(0x00000002)
-#define SD_CMD_xx1	(0x0000000c)
-#define SD_CMD_CT_MASK	(0x000000f0)
-#define SD_CMD_CT_0	(0x00000000)
-#define SD_CMD_CT_1	(0x00000010)
-#define SD_CMD_CT_2	(0x00000020)
-#define SD_CMD_CT_3	(0x00000030)
-#define SD_CMD_CT_4	(0x00000040)
-#define SD_CMD_CT_5	(0x00000050)
-#define SD_CMD_CT_6	(0x00000060)
-#define SD_CMD_CT_7	(0x00000070)
-#define SD_CMD_CI	(0x0000ff00)
-#define SD_CMD_CI_SHIFT		(8)
-#define SD_CMD_RT_MASK	(0x00ff0000)
-#define SD_CMD_RT_0	(0x00000000)
-#define SD_CMD_RT_1	(0x00010000)
-#define SD_CMD_RT_2	(0x00020000)
-#define SD_CMD_RT_3	(0x00030000)
-#define SD_CMD_RT_4	(0x00040000)
-#define SD_CMD_RT_5	(0x00050000)
-#define SD_CMD_RT_6	(0x00060000)
-#define SD_CMD_RT_1B	(0x00810000)
-
-
-#endif /* __ASM_AU1100_MMC_H */
-
_
