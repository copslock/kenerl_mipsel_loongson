Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 08:09:21 +0100 (BST)
Received: from mail.free-electrons.com ([88.191.76.200]:29381 "EHLO
	mail.free-electrons.com") by ftp.linux-mips.org with ESMTP
	id S32728777AbYIJHJS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Sep 2008 08:09:18 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
	id A586AE5C1; Tue,  9 Sep 2008 10:16:03 +0200 (CEST)
Received: from surf (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 30235E5AC;
	Tue,  9 Sep 2008 10:15:55 +0200 (CEST)
Received: from thomas by surf with local (Exim 4.69)
	(envelope-from <thomas.petazzoni@enix.org>)
	id 1KcyNi-0000vf-3E; Tue, 09 Sep 2008 10:15:26 +0200
From:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:	ralf@linux-mips.org
Cc:	ths@networkno.de, linux-mips@linux-mips.org,
	michael@free-electrons.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/1] mips: clear IV bit in CP0 cause if the CPU doesn't support divec
Date:	Tue,  9 Sep 2008 10:15:25 +0200
Message-Id: <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <>
References: <>
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
Precedence: bulk
X-list: linux-mips

When the kernel thinks that the CPU doesn't support the divec feature
(cpu_has_divec is false), reset the corresponding IV bit in the CP0
cause register, so that things will work correctly if the bootloader
had a different idea of the CPU support of the divec feature.

The problem has been found while trying to boot a 2.6.24 kernel for
the Qemu board using U-Boot inside Qemu. For the same CPU type, U-Boot
thinks that divec is supported, and the kernel doesn't. So U-Boot sets
the IV bit, but when the kernel boots and doesn't reset the IV bit,
things break when the first interrupts occur. The Qemu board has been
removed from the kernel in 2.6.25, but the problem might also occur
with other platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thiemo Seufer <ths@networkno.de>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/traps.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 6bee290..8b1e507 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1467,6 +1467,9 @@ void __cpuinit per_cpu_trap_init(void)
 		} else
 			set_c0_cause(CAUSEF_IV);
 	}
+	else {
+		clear_c0_cause(CAUSEF_IV);
+	}
 
 	/*
 	 * Before R2 both interrupt numbers were fixed to 7, so on R2 only:
-- 
1.5.4.3
