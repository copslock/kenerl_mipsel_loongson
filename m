Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 10:53:33 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993869AbdJFIwhbCxno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 10:52:37 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2DE04728;
        Fri,  6 Oct 2017 08:52:31 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Crispin <john@phrozen.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.9 012/104] MIPS: ralink: Fix a typo in the pinmux setup.
Date:   Fri,  6 Oct 2017 10:50:50 +0200
Message-Id: <20171006083842.576161168@linuxfoundation.org>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171006083840.743659740@linuxfoundation.org>
References: <20171006083840.743659740@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Crispin <john@phrozen.org>


[ Upstream commit 58181a117d353427127a2e7afc7cf1ab44759828 ]

There is a typo inside the pinmux setup code. The function is really
called utif and not util. This was recently discovered when people were
trying to make the UTIF interface work.

Signed-off-by: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14899/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/ralink/mt7620.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -176,7 +176,7 @@ static struct rt2880_pmx_func spi_cs1_gr
 
 static struct rt2880_pmx_func spis_grp_mt7628[] = {
 	FUNC("pwm_uart2", 3, 14, 4),
-	FUNC("util", 2, 14, 4),
+	FUNC("utif", 2, 14, 4),
 	FUNC("gpio", 1, 14, 4),
 	FUNC("spis", 0, 14, 4),
 };
@@ -190,28 +190,28 @@ static struct rt2880_pmx_func gpio_grp_m
 
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
@@ -232,28 +232,28 @@ static struct rt2880_pmx_func wled_kn_gr
 
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
