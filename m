Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 20:01:44 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:55313 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133470AbWAQUBZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 20:01:25 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 12:04:47 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 3E9B467421; Tue, 17 Jan 2006 12:04:47 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 101E967420 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:04:47 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK42012; Tue, 17 Jan 2006 12:04:46 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 E73A620501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:04:45
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 12:04:45 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HK4Ddp019687
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:04:20 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HK47jw019685 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 12:04:07 -0800
Date:	Tue, 17 Jan 2006 12:04:07 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch] power-down linkage fix
Message-ID: <20060117200407.GC19531@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 20:04:45.0673 (UTC)
 FILETIME=[43239D90:01C61BA1]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34334344344342352E303031322D412D;
 ENG=IBF; TS=20060117200449; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD3925541W1847507-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

The last git import created a dependency on pm_power_down.  Borrowing from
ARM the following patch provides definitions of the needed variables in
order for kernels to link.

Please apply
/Mark


diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -41,6 +41,15 @@
 #include <asm/inst.h>
 
 /*
+ * The following aren't currently used.
+ */
+void (*pm_idle)(void);
+EXPORT_SYMBOL(pm_idle);
+
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+/*
  * The idle thread. There's no useful work to be done, so just try to conserve
  * power and have a low exit latency (ie sit in a loop waiting for somebody to
  * say that they'd like to reschedule)
