Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2015 10:52:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27723 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006697AbbFXIwQGF0vx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2015 10:52:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B9F88749E7447
        for <linux-mips@linux-mips.org>; Wed, 24 Jun 2015 09:52:08 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Jun 2015 09:52:10 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.48) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 24 Jun 2015 09:52:09 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/2] Branch emulation fixes for MIPS R6
Date:   Wed, 24 Jun 2015 09:51:59 +0100
Message-ID: <1435135921-7090-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.4.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

A few fixes for MIPS R6 branch and jump instruction emulation.

Markos Chandras (2):
  MIPS: Fix branch emulation for BLTC and BGEC instructions
  MIPS: Fix erroneous JR emulation for MIPS R6

 arch/mips/kernel/branch.c   | 4 ++--
 arch/mips/math-emu/cp1emu.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.4.4
