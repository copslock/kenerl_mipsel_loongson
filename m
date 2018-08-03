Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 05:05:51 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:32821 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994565AbeHCDE0EjApH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 05:04:26 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 20:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="251328318"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2018 20:04:21 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 13/18] serial: intel: Replace clk_enable/clk_disable with clk generic API
Date:   Fri,  3 Aug 2018 11:02:32 +0800
Message-Id: <20180803030237.3366-14-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180803030237.3366-1-songjun.wu@linux.intel.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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

The clk driver has introduced new clock APIs that replace
the existing clk_enable and clk_disable.
 -clk_enable() APIs is replaced with clk_prepare_enable().
 -clk_disable() API is replaced with clk_disable_unprepare().

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

Changes in v2: None

 drivers/tty/serial/lantiq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 28086d52e980..36479d66fb7c 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -309,7 +309,7 @@ lqasc_startup(struct uart_port *port)
 	int retval;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	asc_update_bits(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
@@ -377,7 +377,7 @@ lqasc_shutdown(struct uart_port *port)
 	asc_update_bits(ASCTXFCON_TXFEN, ASCTXFCON_TXFFLU,
 		port->membase + LTQ_ASC_TXFCON);
 	if (!IS_ERR(ltq_port->clk))
-		clk_disable(ltq_port->clk);
+		clk_disable_unprepare(ltq_port->clk);
 }
 
 static void
@@ -631,7 +631,7 @@ lqasc_console_setup(struct console *co, char *options)
 	port = &ltq_port->port;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 
 	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
-- 
2.11.0
