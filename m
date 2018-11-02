Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Nov 2018 03:08:12 +0100 (CET)
Received: from fudo.makrotopia.org ([IPv6:2a07:2ec0:3002::71]:53294 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992602AbeKBCH30wfH6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Nov 2018 03:07:29 +0100
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
         (Exim 4.90_1)
        (envelope-from <daniel@makrotopia.org>)
        id 1gIOrt-0001Bt-4d; Fri, 02 Nov 2018 03:07:25 +0100
Date:   Fri, 2 Nov 2018 03:07:19 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mips@linux-mips.org
Cc:     John Crispin <john@phrozen.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@freemail.hu>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH] mips: ralink: add accessors for MT7620 chipver and pkg
Message-ID: <20181102020713.GA880@makrotopia.org>
References: <20181016103806.GA1544@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016103806.GA1544@makrotopia.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <daniel@makrotopia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@makrotopia.org
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

The RT6352 wireless core included in all MT7620 chips is implemented
differently in MT7620A (TFBGA) and MT7620N (DR-QFN).
Hence provide accessor functions similar to the already existing
mt7620_get_eco() function which allow the rt2x00 wireless driver to
figure out which WiSoC it is being run on.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/mips/include/asm/mach-ralink/mt7620.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/mips/include/asm/mach-ralink/mt7620.h b/arch/mips/include/asm/mach-ralink/mt7620.h
index 66af4ccb5c6c..d0310a92a63f 100644
--- a/arch/mips/include/asm/mach-ralink/mt7620.h
+++ b/arch/mips/include/asm/mach-ralink/mt7620.h
@@ -137,4 +137,16 @@ static inline int mt7620_get_eco(void)
 	return rt_sysc_r32(SYSC_REG_CHIP_REV) & CHIP_REV_ECO_MASK;
 }
 
+static inline int mt7620_get_chipver(void)
+{
+	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_VER_SHIFT) &
+		CHIP_REV_VER_MASK;
+}
+
+static inline int mt7620_get_pkg(void)
+{
+	return (rt_sysc_r32(SYSC_REG_CHIP_REV) >> CHIP_REV_PKG_SHIFT) &
+		CHIP_REV_PKG_MASK;
+}
+
 #endif
-- 
2.19.1
