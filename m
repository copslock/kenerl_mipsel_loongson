Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2012 08:21:51 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:15723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823123Ab2KOHVuXyMmg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Nov 2012 08:21:50 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 14 Nov 2012 23:21:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,254,1352102400"; 
   d="scan'208";a="247318316"
Received: from bee.sh.intel.com (HELO localhost) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 14 Nov 2012 23:21:42 -0800
Received: from [192.168.1.143] (helo=hive.lkp.intel.com)
        by localhost with smtp (Exim 4.80)
        (envelope-from <fengguang.wu@intel.com>)
        id 1TYtlO-000VZv-Fn; Thu, 15 Nov 2012 15:21:26 +0800
Date:   Thu, 15 Nov 2012 15:22:02 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: [mips-sjhill:mti-next 6/21] {standard input}:118: Error: opcode
 not supported on this processor: loongson2e (mips3) `ldx $2,$2($3)'
Message-ID: <50a4981a.1jznXCnVJTTsEjeO%fengguang.wu@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.143
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on localhost); SAEximRunCond expanded to false
X-archive-position: 35008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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

tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill mti-next
head:   e96eec97d092418a7b156d7fab0c3f03860031ba
commit: d45d402ceecc8b4882e639abc3a26649605c68a4 [6/21] MIPS: dsp: Add assembler support for DSP ASEs.
config: make ARCH=mips fuloong2e_defconfig

All error/warnings:

Assembler messages:
Warning: mips3 ISA does not support DSP ASE
{standard input}:118: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($3)'
{standard input}:181: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $3,$3($4)'
{standard input}:182: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:212: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $3,$3($4)'
{standard input}:213: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:243: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:272: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:317: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $3,$3($4)'
{standard input}:342: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($3)'
{standard input}:471: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:500: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:548: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $2,$2($4)'
{standard input}:579: Error: opcode not supported on this processor: loongson2e (mips3) `ldx $7,$7($4)'

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
