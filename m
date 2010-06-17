Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jun 2010 13:33:38 +0200 (CEST)
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:39640 "EHLO
        tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490962Ab0FQLde (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jun 2010 13:33:34 +0200
Received: from mailgate3.nec.co.jp ([10.7.69.192])
        by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o5HBXR2p021466
        for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:33:27 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
        id o5HBXRO00121 for linux-mips@linux-mips.org; Thu, 17 Jun 2010 20:33:27 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.54]) by vgate02.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
        id o5HBXR915996 for <linux-mips@linux-mips.org>; Thu, 17 Jun 2010 20:33:27 +0900 (JST)
Received: from realmbox31.aps.necel.com ([10.29.19.28] [10.29.19.28]) by relay31.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:33:27 +0900
Received: from [10.114.180.181] ([10.114.180.181] [10.114.180.181]) by mbox02.aps.necel.com with ESMTP; Thu, 17 Jun 2010 20:33:27 +0900
Message-ID: <4C1A0801.60405@renesas.com>
Date:   Thu, 17 Jun 2010 20:33:21 +0900
From:   Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.9) Gecko/20100317 Lightning/1.0b1 Thunderbird/3.0.4
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: [PATCH] EMMA2RH: tivial cleanups
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shinya.kuribayashi.px@renesas.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 11953

Hi,

Today I was going to prepare a patch titled '[PATCH] MIPS: Move EMMA2RH
Makefile to its own Platform file', fetched and took a look at -queue
repo, and found that Ralf already fixed it up!  Many thanks, Ralf :-)

So here're remaining trivial cleanups supposed to be sent along with
the Platform patch.  In the future, I'm planning to sort out interrupt
routines first, PCI driver generization, and more, but I still couldn't
find enough spare time for it.  I'll try my best (I'd likt to play with
the latest kernel, anyway).


Shinya Kuribayashi (4):
      MIPS: EMMA2RH: Remove useless CPU_IRQ_BASE
      MIPS: EMMA2RH: Remove EMMA2RH_CPU_CASCADE
      MIPS: EMMA2RH: Replace EMMA2RH_IRQ_INTxx with EMMA2RH_IRQ_INT(n)
      MIPS: EMMA2RH: Replace EMMA2RH_SW_IRQ_INTxx with EMMA2RH_SW_IRQ(n)

 arch/mips/emma/markeins/irq.c         |    8 ++--
 arch/mips/include/asm/emma/emma2rh.h  |   84 ++++-----------------------------
 arch/mips/include/asm/emma/markeins.h |   37 +-------------
 3 files changed, 16 insertions(+), 113 deletions(-)

P.S. Feel free to squash!

-- 
Shinya Kuribayashi
Renesas Electronics
