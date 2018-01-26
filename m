Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2018 10:39:24 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.15]:53890 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990410AbeAZJjR5jf2U (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 26 Jan 2018 10:39:17 +0100
Received: from localhost.localdomain ([91.19.49.181]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LfC00-1f7QJ90oOW-00omfI; Fri, 26 Jan 2018 10:38:03 +0100
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 1AABA80246; Fri, 26 Jan 2018 10:38:01 +0100 (CET)
From:   Sven Joachim <svenjoac@gmx.de>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org
Cc:     James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ssb: Do not disable PCI host on non-Mips
Date:   Fri, 26 Jan 2018 10:38:01 +0100
Message-ID: <87vafpq7t2.fsf@turtle.gmx.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K0:jtgTnu0Jezl3r5RBIodA2ir/P27wamC4T4p/BlYc5dj747xCG1N
 3EUCv0MP8ua/Mp3TeJg/BL0KUQH0Psi3/E/9QyUTI0g9zMcxEXzIqjy0LnQp+JpGkHVL0RT
 mCxTS5WUVHTAwGpuplRYd9NigsnyxMn2O7fKWI1BJjkSV2P0dxppc6kJNNiNDD3qiCS3H8F
 RtTkqWiV2EBS/RGDFPS/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wRMKN4FfiwE=:necFyDST/b33l+2Un7HmEM
 kWuJeYHRl3GyfKv1+lcfMdaMVX+1I+sP5ojGcSl3plOyI0aGnvZh7/dS2M1/O1vqR8ryG3mOV
 UQNO9a9s8Q+f68RZ4i9fqxJRnbzsMcfy82owhe7tiVvtDj+yBLQKshCKH+LlRPHNN33vOGKG+
 vV/Oyyp4HALoCqmN+MqmDx/u+uC5DDKyYyyKMDE9ok4BDVRXuapAkYSdL0Ty5cd4qOyb0d7uP
 lf+djfCgPdhThY/j3TcdZOv8LK8w6k/Mqwa4DXbGb/yaarR8F4jqXbS556ns8Px9AciYy6Qra
 Dp5SMBBYmkOSaHyzSpShcTYBj0g1h3tCyK0zBI06kf/KKWY8nroFpYi7JIG5s1/72u4XuAU8R
 qVY6XhhOjUkCGBJLhOVaJCSQtL9ZveQ2WLIyutEcgiSZK5JrgH+MXxOwpQkBXdsgd1iMNM+uj
 Z9PGZW/X7No3xebXWspB3MaN2/P1DcV5kJACi8CeReOYaz33Bw9wdpfpjxodLSggXZYEspoiR
 V9y/q1mWFM3vfUiTBqFW1nrK0K7EmSeQATDPRSlAN7tQNfIb45PNNavWn95Y35YZOQIYdQrLJ
 XjZCMAD1ImyHRYTu+R03W7FKstvWV/vkoDp1TZlf3UQCr+fQ9sJcAnVnRYWS5YtQs2Kks9yaQ
 Gkb23KgRyawzJuIAvhaGA1MuB9eG6s4qobznp/YhiOVKEQhFofp7ZoTNNIEX8s1Q9W9Hn16iV
 S4HGv2q2/907oQED07LX8wl/z1U6Tw4sKe/cdb3xUqGBAF4FGrkmAOtMfA1YgytDXSYao4kIk
 +XXeDrS4iF1GvyafS0DDtQfTep+HyqZuqNpMe6UZUNTbQYejcI=
Return-Path: <svenjoac@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: svenjoac@gmx.de
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

After upgrading an old laptop to 4.15-rc9, I found that the eth0 and
wlan0 interfaces had disappeared.  It turns out that the b43 and b44
drivers require SSB_PCIHOST_POSSIBLE which depends on
PCI_DRIVERS_LEGACY, a config option that only exists on Mips.

Fixes: 58eae1416b80 ("ssb: Disable PCI host for PCI_DRIVERS_GENERIC")
Cc: stable@vger.org
Signed-off-by: Sven Joachim <svenjoac@gmx.de>
---
 drivers/ssb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 71c73766ee22..65af12c3bdb2 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -32,7 +32,7 @@ config SSB_BLOCKIO
 
 config SSB_PCIHOST_POSSIBLE
 	bool
-	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
+	depends on SSB && (PCI = y || PCI = SSB) && (PCI_DRIVERS_LEGACY || !MIPS)
 	default y
 
 config SSB_PCIHOST
-- 
2.15.1
