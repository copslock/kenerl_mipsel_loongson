Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 00:47:55 +0000 (GMT)
Received: from nssinet2.co-nss.co.jp ([IPv6:::ffff:150.96.0.5]:35320 "EHLO
	nssinet2.co-nss.co.jp") by linux-mips.org with ESMTP
	id <S8225192AbVCVArl>; Tue, 22 Mar 2005 00:47:41 +0000
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id JAA01608
	for <linux-mips@linux-mips.org>; Tue, 22 Mar 2005 09:41:07 +0900 (JST)
Received: from nssnet.co-nss.co.jp (nssnet.co-nss.co.jp [150.96.64.250])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id JAA01604
	for <linux-mips@linux-mips.org>; Tue, 22 Mar 2005 09:41:07 +0900 (JST)
Received: from NUNOE ([150.96.160.60])
	by nssnet.co-nss.co.jp (8.9.3+Sun/3.7W) with SMTP id JAA04644
	for <linux-mips@linux-mips.org>; Tue, 22 Mar 2005 09:33:09 +0900 (JST)
Message-ID: <006501c52e78$bb081730$3ca06096@NUNOE>
From:	"Hdei Nunoe" <nunoe@co-nss.co.jp>
To:	<linux-mips@linux-mips.org>
Subject: PSCHED_JSCALE 
Date:	Tue, 22 Mar 2005 09:47:31 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Return-Path: <nunoe@co-nss.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nunoe@co-nss.co.jp
Precedence: bulk
X-list: linux-mips

Hi there,

Has anyone known about the background information about
the following change?  

  The PSCHED_JSCALE in the net/sched/sch_api.c is defined in the
　include/net/pkt_sched.h.  If I set HZ to 1000 - PSCHED_JSCALE
  is 0 - what would happen?

　#if HZ == 100
　#define PSCHED_JSCALE 13
　#elif HZ == 1024
　#define PSCHED_JSCALE 10
　#else
　#define PSCHED_JSCALE 0
　#endif
　
　The code is updated in 2.4.27 as follows.
  The PSCHED_JSCALE becomes 10 in this case.
  What problems would it fix?  Or what behaivior would change?

　#if HZ < 96
　#define PSCHED_JSCALE 14
　#elif HZ >= 96 && HZ < 192
　#define PSCHED_JSCALE 13
　#elif HZ >= 192 && HZ < 384
　#define PSCHED_JSCALE 12
　#elif HZ >= 384 && HZ < 768
　#define PSCHED_JSCALE 11
　#elif HZ >= 768
　#define PSCHED_JSCALE 10
　#endif


---
Hdei Nunoe
