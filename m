Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2005 18:38:42 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:216.31.210.18]:48656 "EHLO
	MMS2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225742AbVFIRiT>; Thu, 9 Jun 2005 18:38:19 +0100
Received: from 10.10.64.121 by MMS2.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Thu, 09 Jun 2005 10:37:56 -0700
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Thu, 9 Jun 2005 10:37:54 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BDD75905; Thu, 9 Jun 2005 10:37:52 -0700 (PDT)
Received: from pcirvcttruong2 (dhcp-10-3-136-70.broadcom.com
 [10.3.136.70]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP id
 KAA22310 for <linux-mips@linux-mips.org>; Thu, 9 Jun 2005 10:37:52
 -0700 (PDT)
Message-ID: <200506091737.KAA22310@mon-irva-10.broadcom.com>
From:	"Ton Truong" <ttruong@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: Member sc_sigset gone in latest 2.6.12-rc5 breaks strace.
Date:	Thu, 9 Jun 2005 10:37:49 -0700
MIME-Version: 1.0
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050606121640.GB6651@linux-mips.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcVqkgC7jC5qXNd9RRyydNehJKhNKgChoSWg
X-WSS-ID: 6EB6A1FE1VO7019659-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <ttruong@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ttruong@broadcom.com
Precedence: bulk
X-list: linux-mips

 
I see that in the rc5 update, MIPS codes have now dropped 
sc_sigset[4] from struct sigcontext, defined in asm-mips/sigcontext.h.  I'd
appreciate it if someone provide a brief summary of what needs to be changed
for strace to compile or where I can find an strace port that work with the
new MIPS codes?

Much appreciated.

//TT
