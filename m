Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2012 19:48:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54403 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903365Ab2IWRsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Sep 2012 19:48:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8NHmqtB007486;
        Sun, 23 Sep 2012 19:48:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8NHmpAb007485;
        Sun, 23 Sep 2012 19:48:51 +0200
Date:   Sun, 23 Sep 2012 19:48:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: fix CPU/DDR frequency calculation for SRIF
 PLLs
Message-ID: <20120923174851.GG13842@linux-mips.org>
References: <1347105741-23091-1-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1347105741-23091-1-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Sep 08, 2012 at 02:02:21PM +0200, Gabor Juhos wrote:

Applied but I had to fix a conflict:

@@ -65,6 +65,8 @@
 #define AR934X_WMAC_SIZE	0x20000
 #define AR934X_EHCI_BASE	0x1b000000
 #define AR934X_EHCI_SIZE	0x200
+#define AR934X_SRIF_BASE	(AR71XX_APB_BASE + 0x00116000)
+#define AR934X_SRIF_SIZE	0x1000
 
 /*
  * DDR_CTRL block

The EHCI lines don't exist yet.  Seems harmless though.

  Ralf
