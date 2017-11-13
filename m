Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 13:57:03 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991935AbdKMM4f04leS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 13:56:35 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EF61AAE;
        Mon, 13 Nov 2017 12:56:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 3.18 25/28] MIPS: AR7: Ensure that serial ports are properly set up
Date:   Mon, 13 Nov 2017 13:55:19 +0100
Message-Id: <20171113125403.132407793@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125400.803506921@linuxfoundation.org>
References: <20171113125400.803506921@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60854
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

From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

commit b084116f8587b222a2c5ef6dcd846f40f24b9420 upstream.

Without UPF_FIXED_TYPE, the data from the PORT_AR7 uart_config entry is
never copied, resulting in a dead port.

Fixes: 154615d55459 ("MIPS: AR7: Use correct UART port type")
Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
[jonas.gorski: add Fixes tag]
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17543/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ar7/platform.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -581,6 +581,7 @@ static int __init ar7_register_uarts(voi
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
+	uart_port.flags		= UPF_FIXED_TYPE;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
