Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 19:51:06 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:39437 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S3465590AbWAQTum (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 19:50:42 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 11:54:08 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 91ABB67426; Tue, 17 Jan 2006 11:54:08 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 43C6667424 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:54:08 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK37807; Tue, 17 Jan 2006 11:54:06 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 949F620501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:54:06
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 11:54:06 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HJrW8u019555
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 11:53:38 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HJrP9n019554 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 11:53:25 -0800
Resent-Message-ID: <200601171953.k0HJrP9n019554@localhost.localdomain>
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 10:57:42 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HIvE2e018670;
 Tue, 17 Jan 2006 10:57:18 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HIv3fq018667; Tue, 17 Jan 2006 10:57:03
 -0800
Date:	Tue, 17 Jan 2006 10:57:03 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
cc:	mason@broadcom.com
Subject: [patch] sb1 oprofile support
Message-ID: <20060117185703.GB18567@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 18:57:42.0365 (UTC)
 FILETIME=[E50F88D0:01C61B97]
Resent-From: mason@broadcom.com
Resent-Date: Tue, 17 Jan 2006 11:53:25 -0800
Resent-To: linux-mips@linux-mips.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34334344344133352E303031322D412D;
 ENG=IBF; TS=20060117195409; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD394EA41W1844558-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips

Hello,

The following patch provides oprofile support for the SB1 processors.
[Please apply - lol]

/Mark


diff --git a/arch/mips/oprofile/Makefile b/arch/mips/oprofile/Makefile
--- a/arch/mips/oprofile/Makefile
+++ b/arch/mips/oprofile/Makefile
@@ -12,4 +12,5 @@ oprofile-y				:= $(DRIVER_OBJS) common.o
 
 oprofile-$(CONFIG_CPU_MIPS32)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_MIPS64)		+= op_model_mipsxx.o
+oprofile-$(CONFIG_CPU_SB1)		+= op_model_mipsxx.o
 oprofile-$(CONFIG_CPU_RM9000)		+= op_model_rm9000.o
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -79,6 +79,8 @@ int __init oprofile_arch_init(struct opr
 	case CPU_20KC:
 	case CPU_24K:
 	case CPU_25KF:
+	case CPU_SB1:
+	case CPU_SB1A:
 		lmodel = &op_model_mipsxx;
 		break;
 
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -205,6 +205,11 @@ static int __init mipsxx_init(void)
 		op_model_mipsxx.cpu_type = "mips/5K";
 		break;
 
+	case CPU_SB1:
+	case CPU_SB1A:
+		op_model_mipsxx.cpu_type = "mips/sb1";
+		break;
+
 	default:
 		printk(KERN_ERR "Profiling unsupported for this CPU\n");
 
