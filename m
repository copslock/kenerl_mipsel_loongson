Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 00:05:58 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:216.31.210.18]:19214 "EHLO
	MMS2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225437AbVFVXD3>; Thu, 23 Jun 2005 00:03:29 +0100
Received: from 10.10.64.121 by MMS2.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 22 Jun 2005 16:02:13 -0700
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:02:05 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BFO30936; Wed, 22 Jun 2005 16:02:05 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id QAA02788 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005 16:02:04
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j5MN24ov008196 for <linux-mips@linux-mips.org>; Wed, 22 Jun 2005
 16:02:04 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j5MN23p17994 for linux-mips@linux-mips.org; Wed, 22 Jun 2005
 16:02:03 -0700
Date:	Wed, 22 Jun 2005 16:02:03 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [patch 5/5] SiByte fixes for 2.6.12
Message-ID: <20050622230203.GA17984@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20050622230003.GA17725@broadcom.com>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6EA7327F2782680308-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

Fix a stale comment in c-sb1.c.

Signed-Off-By: Andrew Isaacson <adi@broadcom.com>

Index: linux-2.6-work/arch/mips/mm/c-sb1.c
===================================================================
--- linux-2.6-work.orig/arch/mips/mm/c-sb1.c	2005-06-22 11:17:18.000000000 -0700
+++ linux-2.6-work/arch/mips/mm/c-sb1.c	2005-06-22 11:17:33.000000000 -0700
@@ -492,7 +492,7 @@
 }
 
 /*
- * This is called from loadmmu.c.  We have to set up all the
+ * This is called from cache.c.  We have to set up all the
  * memory management function pointers, as well as initialize
  * the caches and tlbs
  */

--
