Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jul 2017 15:40:40 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994766AbdGCNi1YnpOi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jul 2017 15:38:27 +0200
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 411E292F;
        Mon,  3 Jul 2017 13:38:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, john@phrozen.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 043/101] MIPS: ralink: fix MT7628 pinmux typos
Date:   Mon,  3 Jul 2017 15:34:43 +0200
Message-Id: <20170703133341.696698681@linuxfoundation.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170703133334.237346187@linuxfoundation.org>
References: <20170703133334.237346187@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58995
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Álvaro Fernández Rojas <noltari@gmail.com>

commit d7146829c9da24e285cb1b1f2156b5b3e2d40c07 upstream.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Cc: john@phrozen.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/13306/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/mt7620.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/ralink/mt7620.c
+++ b/arch/mips/ralink/mt7620.c
@@ -223,9 +223,9 @@ static struct rt2880_pmx_func wled_an_gr
 #define MT7628_GPIO_MODE_GPIO		0
 
 static struct rt2880_pmx_group mt7628an_pinmux_data[] = {
-	GRP_G("pmw1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm1", pwm1_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM1),
-	GRP_G("pmw0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
+	GRP_G("pwm0", pwm0_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_PWM0),
 	GRP_G("uart2", uart2_grp_mt7628, MT7628_GPIO_MODE_MASK,
 				1, MT7628_GPIO_MODE_UART2),
