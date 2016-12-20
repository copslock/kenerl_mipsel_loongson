Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2016 19:14:15 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44292 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993315AbcLTSMiUlGO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Dec 2016 19:12:38 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 4/7] arch: mips: ralink: fix a typo in the pinmux setup
Date:   Tue, 20 Dec 2016 19:12:43 +0100
Message-Id: <1482257566-61035-5-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1482257566-61035-1-git-send-email-john@phrozen.org>
References: <1482257566-61035-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

There is a typo inside the pinmux setup code. The function is really
called utif and not util. This was recently discovered when people were
trying to make the UTIF interface work.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ralink/mt7620.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
index 2503878..76416b4 100644
--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -180,7 +180,7 @@
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
-	FUNC("util", 2, 14, 4),
+	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
@@ -194,28 +194,28 @@
 
 static struct rt2880_pmx_func p4led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 30, 1),
-	FUNC("util", 2, 30, 1),
+	FUNC("utif", 2, 30, 1),
 	FUNC("gpio", 1, 30, 1),
 	FUNC("p4led_kn", 0, 30, 1),
 };
 
 static struct rt2880_pmx_func p3led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 31, 1),
-	FUNC("util", 2, 31, 1),
+	FUNC("utif", 2, 31, 1),
 	FUNC("gpio", 1, 31, 1),
 	FUNC("p3led_kn", 0, 31, 1),
 };
 
 static struct rt2880_pmx_func p2led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 32, 1),
-	FUNC("util", 2, 32, 1),
+	FUNC("utif", 2, 32, 1),
 	FUNC("gpio", 1, 32, 1),
 	FUNC("p2led_kn", 0, 32, 1),
 };
 
 static struct rt2880_pmx_func p1led_kn_grp_mt7628[] = {
 	FUNC("jtag", 3, 33, 1),
-	FUNC("util", 2, 33, 1),
+	FUNC("utif", 2, 33, 1),
 	FUNC("gpio", 1, 33, 1),
 	FUNC("p1led_kn", 0, 33, 1),
 };
@@ -236,28 +236,28 @@
 
 static struct rt2880_pmx_func p4led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 39, 1),
-	FUNC("util", 2, 39, 1),
+	FUNC("utif", 2, 39, 1),
 	FUNC("gpio", 1, 39, 1),
 	FUNC("p4led_an", 0, 39, 1),
 };
 
 static struct rt2880_pmx_func p3led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 40, 1),
-	FUNC("util", 2, 40, 1),
+	FUNC("utif", 2, 40, 1),
 	FUNC("gpio", 1, 40, 1),
 	FUNC("p3led_an", 0, 40, 1),
 };
 
 static struct rt2880_pmx_func p2led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 41, 1),
-	FUNC("util", 2, 41, 1),
+	FUNC("utif", 2, 41, 1),
 	FUNC("gpio", 1, 41, 1),
 	FUNC("p2led_an", 0, 41, 1),
 };
 
 static struct rt2880_pmx_func p1led_an_grp_mt7628[] = {
 	FUNC("jtag", 3, 42, 1),
-	FUNC("util", 2, 42, 1),
+	FUNC("utif", 2, 42, 1),
 	FUNC("gpio", 1, 42, 1),
 	FUNC("p1led_an", 0, 42, 1),
 };
-- 
1.7.10.4
