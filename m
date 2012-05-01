Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 23:39:36 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:38171 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903736Ab2EAVja (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 May 2012 23:39:30 +0200
Received: from yow-lpgnfs-02.corp.ad.wrs.com (yow-lpgnfs-02.wrs.com [128.224.149.8])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q41LdM9j022655;
        Tue, 1 May 2012 14:39:23 -0700 (PDT)
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] usb: [MIPS] fix unresolved err() reference in host/ohci-au1xxx.c
Date:   Tue,  1 May 2012 17:39:11 -0400
Message-Id: <1335908351-4981-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Commit af4e1ee04026908086d7ed252db2619a8ceaa333 (usb-next)

    "USB: remove err() macro"

was preceeded by a tree-wide cleanup of users, however this
one squeaked through the cracks because it had whitespace
between the function name and the bracket for the args.

Map it onto dev_err, just like all the "pre-commits" made
in advance of af4e1ee04026, such as the example seen in
the commit d57b177208b6ec20cacd7321ee32ef02f9f9e7fa:

    "USB: ohci-xls.c: remove err() usage"

Build tested with the MIPS gpr_defconfig settings.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 4ea63b2..c611699 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -37,7 +37,8 @@ static int __devinit ohci_au1xxx_start(struct usb_hcd *hcd)
 		return ret;
 
 	if ((ret = ohci_run(ohci)) < 0) {
-		err ("can't start %s", hcd->self.bus_name);
+		dev_err(hcd->self.controller, "can't start %s",
+			hcd->self.bus_name);
 		ohci_stop(hcd);
 		return ret;
 	}
-- 
1.7.9.1
