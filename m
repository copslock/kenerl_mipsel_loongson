Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Apr 2016 19:19:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46282 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025160AbcDVRTgni0sU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Apr 2016 19:19:36 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id EBB57C78BDBE5;
        Fri, 22 Apr 2016 18:19:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:30 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 22 Apr 2016 18:19:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] MIPS: Guest timekeeping improvements
Date:   Fri, 22 Apr 2016 18:19:13 +0100
Message-ID: <1461345557-2763-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

These patches improve timekeeping of MIPS/Malta kernels running in a KVM
guest.

Patch 2 fixes malta frequency calculation under virtualisation,
especially on very slow targets (FPGA / emulators). Patch 1 is a minor
fix for something I noticed while writing patch 2.

Patch 3 drops the use of the PIT timer for Malta, which is slow to
emulate with KVM + QEMU.

Finally patch 4 calculates min_delta_ns of cevt-r4k dynamically to
handle virtualised environments with software emulated Count/Compare,
and where Count frequency may not be directly related to actual CPU
speed (and so the static value of 0x300 may be no good).

James Hogan (4):
  MIPS: malta-time: Start GIC count before syncing to RTC
  MIPS: malta-time: Take seconds into account
  MIPS: malta-time: Don't use PIT timer for cevt/csrc
  MIPS: cevt-r4k: Dynamically calculate min_delta_ns

 arch/mips/Kconfig                |  1 -
 arch/mips/kernel/cevt-r4k.c      | 82 +++++++++++++++++++++++++++++++++++++++-
 arch/mips/mti-malta/malta-time.c | 50 +++++++++++++++---------
 3 files changed, 113 insertions(+), 20 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
-- 
2.4.10
