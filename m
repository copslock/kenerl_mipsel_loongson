Return-Path: <SRS0=K/c0=Q7=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A093C43381
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B73C20661
	for <linux-mips@archiver.kernel.org>; Sun, 24 Feb 2019 07:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfBXHPA (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 24 Feb 2019 02:15:00 -0500
Received: from smtpbgau1.qq.com ([54.206.16.166]:36322 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfBXHO7 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 24 Feb 2019 02:14:59 -0500
X-QQ-mid: bizesmtp3t1550992487t89g48b0i
Received: from localhost.localdomain (unknown [116.236.177.50])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 24 Feb 2019 15:14:43 +0800 (CST)
X-QQ-SSF: 01400000002000C0EF92B00A0000000
X-QQ-FEAT: R3tZgSt770MAtl3QlDCoa4HBzFgRnDeEnB8SALHnMoDwpqcMZ4+rzP6TYvNYo
        u69H9usKHJX2O6Ev1LJY6bg27Y2Bh1KLq1I6MCR+h671q4xw0GaGlp/FSblbfsCUu8YxeFi
        IsJIZgO92QyIHOz91O7BXCvRp5STxGP61OJOLSisjIZ6SlUS8wjS65LIffDk+ms3CcMG2em
        gYhXOLknsW/nRbqWRkzuu99a5QUyqTCOArXOMsirBLm0l608SirbQVPjQ49BAR1i1QgFMIw
        PsV7Oi7WOH/Gxn
X-QQ-GoodBg: 2
From:   Wang Xuerui <wangxuerui@qiniu.com>
To:     linux-mips@vger.kernel.org
Cc:     Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alex Belits <alex.belits@cavium.com>,
        James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 0/4] MIPS: support 47-bit userland VM space
Date:   Sun, 24 Feb 2019 15:13:51 +0800
Message-Id: <20190224071355.14488-1-wangxuerui@qiniu.com>
X-Mailer: git-send-email 2.16.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:qiniu.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

This is my patchset to support 47-bit userland virtual memory space on
MIPS, for better application compatibility with x86_64.  The
implementation is entirely shared with the previous 48-bit virtual
memory space work.

The existing mechanism is first refactored to accommodate extensions,
then 47-bit support is added as an additional case of the
now-generalized large VA support.  I have been running an earlier
uncleaned version of this code for over 2 years, on Loongson 3A2000 and
3A3000, without any problem so far.  This is my first patchset to
Linux/MIPS, so any review or comment is greatly appreciated!

Wang Xuerui (4):
  MIPS: simplify definition of TASK_SIZE64
  MIPS: refactor virtual address size selection
  MIPS: define virtual address size in Kconfig
  MIPS: support 47-bit userland VM space

 arch/mips/Kconfig                  | 59 +++++++++++++++++++++++++++++++++++---
 arch/mips/include/asm/pgtable-64.h | 10 +++----
 arch/mips/include/asm/processor.h  |  5 ++--
 3 files changed, 63 insertions(+), 11 deletions(-)

-- 
2.16.1



