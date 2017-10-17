Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 20:29:04 +0200 (CEST)
Received: from resqmta-po-08v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:167]:57720
        "EHLO resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992312AbdJQS2yEmnPX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 20:28:54 +0200
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id 4WYbeGyrMlbN34WZKenGOV; Tue, 17 Oct 2017 18:26:22 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-02v.sys.comcast.net with SMTP
        id 4WZIeWpLUaGfo4WZJemdwZ; Tue, 17 Oct 2017 18:26:22 +0000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Use !pci_is_root_bus(bus) in ops-bridge.c
Message-ID: <b6ce129c-bedc-c458-4d1f-404e12c78c5b@gentoo.org>
Date:   Tue, 17 Oct 2017 14:26:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEXF1YCgdTIQPBk1NkproPaEcoab8cRYL72UNIpu02XoM6lHlM4OizfUo1/rSSbbGnyiWlSYZrMXLheF1MZzCOHmHjX1CD+ifjYGTWqxYIbZtw6XGzCT
 bsALRerZ6IFwauBw/gk6ZsbSQf4un6fLlPV8F59/pLrEgOpY4UerjZINEF8MzYoZrmj8acxxcAUY5HOJZRToh32r7ACFq6+/h8tZOSuTsBjzHkpP9jr7PzSL
 mBMqS+XSkK6XgR/L6MQy2A==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This is a manual cherrypick of commit c7ddc3d137b7 from Alastair
Bridgewater's IP35 tree that replaces two cases of
"if (bus->number > 0)" with a more correct "if (!pci_is_root_bus(bus))"
in arch/mips/pci/ops-bridge.c.

Cc: linux-mips@linux-mips.org
Cc: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Suggested-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/pci/ops-bridge.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/ops-bridge.c b/arch/mips/pci/ops-bridge.c
index 57e1463fcd02..a1d2c4ae0d1b 100644
--- a/arch/mips/pci/ops-bridge.c
+++ b/arch/mips/pci/ops-bridge.c
@@ -167,7 +167,7 @@ static int pci_conf1_read_config(struct pci_bus *bus, unsigned int devfn,
 static int pci_read_config(struct pci_bus *bus, unsigned int devfn,
 			   int where, int size, u32 * value)
 {
-	if (bus->number > 0)
+	if (!pci_is_root_bus(bus))
 		return pci_conf1_read_config(bus, devfn, where, size, value);
 
 	return pci_conf0_read_config(bus, devfn, where, size, value);
@@ -310,7 +310,7 @@ static int pci_conf1_write_config(struct pci_bus *bus, unsigned int devfn,
 static int pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	int where, int size, u32 value)
 {
-	if (bus->number > 0)
+	if (!pci_is_root_bus(bus))
 		return pci_conf1_write_config(bus, devfn, where, size, value);
 
 	return pci_conf0_write_config(bus, devfn, where, size, value);
