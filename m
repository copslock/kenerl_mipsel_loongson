Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:47:12 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:45611 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992998AbdKNPquqhjl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 16:46:50 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 15:46:37 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 07:45:37 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 2/2] MIPS: RB532: Avoid undefined mac_pton without GENERIC_NET_UTILS
Date:   Tue, 14 Nov 2017 15:44:23 +0000
Message-ID: <1510674263-14065-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1510674263-14065-1-git-send-email-matt.redfearn@mips.com>
References: <1510674263-14065-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510674389-321459-22243-73736-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186917
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Currently MIPS allnoconfig with CONFIG_MIKROTIK_RB532=y fails to link
due to missing support for mac_pton():

  LD      vmlinux
arch/mips/rb532/devices.o: In function `setup_kmac':
devices.c:(.init.text+0xc): undefined reference to `mac_pton'

Rather than adding dependencies to the platform to force inclusion of
GENERIC_NET_UTILS which is selected by CONFIG_NET, just exclude the
setup of the MAC address if CONFIG_NET is not selected in the kernel
config.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/rb532/devices.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
index 32ea3e6731d6..354d258396ff 100644
--- a/arch/mips/rb532/devices.c
+++ b/arch/mips/rb532/devices.c
@@ -310,6 +310,8 @@ static int __init plat_setup_devices(void)
 	return platform_add_devices(rb532_devs, ARRAY_SIZE(rb532_devs));
 }
 
+#ifdef CONFIG_NET
+
 static int __init setup_kmac(char *s)
 {
 	printk(KERN_INFO "korina mac = %s\n", s);
@@ -322,4 +324,6 @@ static int __init setup_kmac(char *s)
 
 __setup("kmac=", setup_kmac);
 
+#endif /* CONFIG_NET */
+
 arch_initcall(plat_setup_devices);
-- 
2.7.4
