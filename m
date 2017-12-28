Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 18:13:33 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40051 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdL1RNXh4CqB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 18:13:23 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eUbk2-0005Yu-LJ; Thu, 28 Dec 2017 17:13:14 +0000
Received: from ben by deadeye with local (Exim 4.90_RC3)
        (envelope-from <ben@decadent.org.uk>)
        id 1eUbjy-0007Nt-ED; Thu, 28 Dec 2017 17:13:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Yoshihiro YUNOMAE" <yoshihiro.yunomae.ez@hitachi.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>,
        linux-mips@linux-mips.org, "James Hogan" <jhogan@kernel.org>,
        "Jonas Gorski" <jonas.gorski@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Nicolas Schichan" <nschichan@freebox.fr>
Date:   Thu, 28 Dec 2017 16:59:12 +0000
Message-ID: <lsq.1514480352.53205939@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 82/94] MIPS: AR7: Ensure that serial ports are
 properly set up
In-Reply-To: <lsq.1514480348.981935392@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.97-rc1 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/ar7/platform.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -541,6 +541,7 @@ static int __init ar7_register_uarts(voi
 	uart_port.type		= PORT_AR7;
 	uart_port.uartclk	= clk_get_rate(bus_clk) / 2;
 	uart_port.iotype	= UPIO_MEM32;
+	uart_port.flags		= UPF_FIXED_TYPE;
 	uart_port.regshift	= 2;
 
 	uart_port.line		= 0;
