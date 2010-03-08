Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2010 20:42:37 +0100 (CET)
Received: from mail-fx0-f217.google.com ([209.85.220.217]:47010 "EHLO
        mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492485Ab0CHTmd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Mar 2010 20:42:33 +0100
Received: by fxm9 with SMTP id 9so1912814fxm.24
        for <linux-mips@linux-mips.org>; Mon, 08 Mar 2010 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=p3kMDNbK4c798AvhRYFxaKkauU7l6S2I/XmUt6pJ71U=;
        b=BNAfPScKpN2RUuBGyBJXyZw1ASxPWN6Rz6f/+3dohcUUMemq/QXwVCu08yHXqdkur7
         K/b8POAImVaYYewHF1lviTIr4QyIMZuTBw7cyBH6dENZsNBm0eMr4x91zNXE9xVOyEdq
         eEmR5H8rHv8SBfs6wTYL8EyGV9gwLxlvZwmVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VG7hrc9sjA6vuUc0hcjCsG5Kv8KurRefjzeD1HeVapP/N3xqECeMykwHQG1IC+Crt9
         t09ZuPCnK38H3T/piDEWepair/UG4aNg2WRDg2833NCdqLKhGSBKaj+Xkr6vj4jgtiZv
         MD+f7TzwXLL6zF0aamw5FGX7ZDmJOceAcgDjw=
Received: by 10.87.63.8 with SMTP id q8mr3661232fgk.3.1268077347576;
        Mon, 08 Mar 2010 11:42:27 -0800 (PST)
Received: from localhost.localdomain (p5496CE16.dip.t-dialin.net [84.150.206.22])
        by mx.google.com with ESMTPS id p9sm9071894fkb.33.2010.03.08.11.42.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 11:42:26 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] USB: ehci-au1xxx does not need EHCI IO watchdog
Date:   Mon,  8 Mar 2010 20:43:32 +0100
Message-Id: <1268077412-29804-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.7.0.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

I've been running variations of this patch for well over a year now;
my usual zoo of test devices didn't trigger any ill effects even
under heavy load.  As a nice sideeffect idle-wakeups are reduced
from 20/s to about 2/s (EHCI hub with mouse and kbd).

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/usb/host/ehci-au1xxx.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-au1xxx.c b/drivers/usb/host/ehci-au1xxx.c
index e3a74e7..7a27b7c 100644
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -69,6 +69,15 @@ static void au1xxx_stop_ehc(void)
 	au_sync();
 }
 
+static int au1xxx_ehci_setup(struct usb_hcd *hcd)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	int ret = ehci_init(hcd);
+
+	ehci->need_io_watchdog = 0;
+	return ret;
+}
+
 static const struct hc_driver ehci_au1xxx_hc_driver = {
 	.description		= hcd_name,
 	.product_desc		= "Au1xxx EHCI",
@@ -86,7 +95,7 @@ static const struct hc_driver ehci_au1xxx_hc_driver = {
 	 * FIXME -- ehci_init() doesn't do enough here.
 	 * See ehci-ppc-soc for a complete implementation.
 	 */
-	.reset			= ehci_init,
+	.reset			= au1xxx_ehci_setup,
 	.start			= ehci_run,
 	.stop			= ehci_stop,
 	.shutdown		= ehci_shutdown,
-- 
1.7.0.2
