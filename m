Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 20:04:04 +0000 (GMT)
Received: from mms3.broadcom.com ([216.31.210.19]:59922 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133470AbWAQUDr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 20:03:47 +0000
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Tue, 17 Jan 2006 12:07:12 -0800
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 2D45B67422; Tue, 17 Jan 2006 12:07:11 -0800 (PST)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 724EA67422 for
 <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:07:11 -0800 (PST)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CSK43005; Tue, 17 Jan 2006 12:07:10 -0800 (PST)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 DDC8920501 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:07:09
 -0800 (PST)
Received: from localhost.localdomain ([10.9.253.119]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 17 Jan 2006 12:07:09 -0800
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k0HK6cXc019744
 for <linux-mips@linux-mips.org>; Tue, 17 Jan 2006 12:06:44 -0800
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k0HK6WAs019742 for linux-mips@linux-mips.org;
 Tue, 17 Jan 2006 12:06:32 -0800
Date:	Tue, 17 Jan 2006 12:06:32 -0800
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch] sb1 oprofile
Message-ID: <20060117200632.GE19531@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Jan 2006 20:07:09.0690 (UTC)
 FILETIME=[98FADDA0:01C61BA1]
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006011707; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34334344344434342E303032422D412D;
 ENG=IBF; TS=20060117200713; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006011707_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6FD391FA41W1848266-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9956
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
 
