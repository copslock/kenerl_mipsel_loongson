Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 00:34:01 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:1809 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903407Ab2IEWdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Sep 2012 00:33:08 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 05 Sep 2012 15:31:26 -0700
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Wed, 5 Sep 2012 15:32:14 -0700
Received: from stbsrv-and-2.and.broadcom.com (
 stbsrv-and-2.and.broadcom.com [10.32.128.96]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id C0D459F9F6; Wed, 5
 Sep 2012 15:32:50 -0700 (PDT)
From:   "Jim Quinlan" <jim2101024@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
cc:     ddaney.cavm@gmail.com, cernekee@gmail.com
Subject: [PATCH V4 0/3] MIPS: make funcs preempt-safe for non-mipsr2
 cpus
Date:   Wed, 5 Sep 2012 18:32:44 -0400
Message-ID: <1346884367-6906-1-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.7.6
MIME-Version: 1.0
X-WSS-ID: 7C590D343NK23809173-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-archive-position: 34430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

This is V4 of my submission.  Here is a list of requested changes:

  o Extra commit was added for changing an unsigned short to an int.
  o Use of EXTERN_SYMBOL was added to mips-atomic.c and bitops.c,
    as well as the removal of 'extern' in the functions' declarations.
  o Name of funcs changed from atomic_xxx to __mips_xxx in bitops.c.
  o The function comments in bitops.c were tweaked to please 
    scripts/kernel-doc.

Here is a list of requested changes that were not done (and why):

  o Suggested optimization of _MIPS_SZLONG and others was not needed
    as mips-atomic.c now includes <asm/irqflags.h>.
  o Suggested fixes to please checkpatch.pl for whitespace before 
    newlines in asm strings was attempted but the result made the 
    assembly code look more cluttered => no change made.

These were unrequested changes:
  o Changed order of func listings in irqflags.h so that only one 
    #ifdef/#endif pair was needed instead of three.

Jim Quinlan
