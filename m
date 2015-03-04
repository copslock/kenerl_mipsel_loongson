Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2015 07:18:19 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49243 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006910AbbCDGRnBYh3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2015 07:17:43 +0100
Received: from localhost (unknown [166.170.43.162])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 60C85B0A;
        Wed,  4 Mar 2015 06:17:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Bruno Randolf <br1@einfach.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.18 068/151] MIPS: Alchemy: Fix cpu clock calculation
Date:   Tue,  3 Mar 2015 22:13:22 -0800
Message-Id: <20150304055508.567741091@linuxfoundation.org>
X-Mailer: git-send-email 2.3.1
In-Reply-To: <20150304055457.084276421@linuxfoundation.org>
References: <20150304055457.084276421@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46132
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manuel Lauss <manuel.lauss@gmail.com>

commit 69e4e63ec816a7e22cc3aa14bc7ef4ac734d370c upstream.

The current code uses bits 0-6 of the sys_cpupll register to calculate
core clock speed.  However this is only valid on Au1300, on all earlier
models the hardware only uses bits 0-5 to generate core clock.

This fixes clock calculation on the MTX1 (Au1500), where bit 6 of cpupll
is set as well, which ultimately lead the code to calculate a bogus cpu
core clock and also uart base clock down the line.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Reported-by: John Crispin <blogic@openwrt.org>
Tested-by: Bruno Randolf <br1@einfach.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/9279/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/alchemy/common/clock.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -128,6 +128,8 @@ static unsigned long alchemy_clk_cpu_rec
 		t = 396000000;
 	else {
 		t = alchemy_rdsys(AU1000_SYS_CPUPLL) & 0x7f;
+		if (alchemy_get_cputype() < ALCHEMY_CPU_AU1300)
+			t &= 0x3f;
 		t *= parent_rate;
 	}
 
