Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 19:03:52 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:30729 "EHLO
	nt_server.stellartec.com") by linux-mips.org with ESMTP
	id <S8225221AbTDXSDt>; Thu, 24 Apr 2003 19:03:49 +0100
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA286;
          Thu, 24 Apr 2003 11:03:31 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Jun Sun'" <jsun@mvista.com>
Cc: <linux-mips@linux-mips.org>
Subject: RE: [patch] wait instruction on vr4181
Date: Thu, 24 Apr 2003 11:09:26 -0700
Message-ID: <078a01c30a8c$a4cb9350$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030424093420.C28275@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Return-Path: <sseeger@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sseeger@stellartec.com
Precedence: bulk
X-list: linux-mips

Hey, when I try to patch in standby, it says that opcode isn't available for
the R6000. Why does arch/mips/Makefile use -mcpu=r4600 for the VR41XX?

Steve
