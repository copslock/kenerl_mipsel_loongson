Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 11:34:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35029 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010912AbaJIJefbxd5C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 11:34:35 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 8D866208D327C
        for <linux-mips@linux-mips.org>; Thu,  9 Oct 2014 10:34:26 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 9 Oct
 2014 10:34:28 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:28 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.56) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Oct 2014 10:34:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/3] Malta/SEAD3 kernel image size patches for 3.18
Date:   Thu, 9 Oct 2014 10:34:18 +0100
Message-ID: <1412847261-7930-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.56]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43115
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

A few patches to reduce the size of the kernel image for Malta and SEAD3 by
improving the dependencies on certain source files.

A different approach for i2c and led patches has been posted before:
http://patchwork.linux-mips.org/patch/5802/

Even though none of the original requests have been addressed, I still feel
these patches do not make things any worse.

Hopefully not too late for 3.18

Markos Chandras (3):
  MIPS: Malta: Do not build the malta-amon.c file if CMP is not enabled
  MIPS: sead3: Build the I2C related devices if CONFIG_I2C is enabled
  MIPS: sead3: Only build the led driver is LEDS_CLASS is enabled

 arch/mips/mti-malta/Makefile | 3 ++-
 arch/mips/mti-sead3/Makefile | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.1.2
