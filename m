Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 15:43:35 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:63.70.210.59]:53001 "EHLO
	mms2.broadcom.com") by linux-mips.org with ESMTP
	id <S8225072AbTD1Ond>; Mon, 28 Apr 2003 15:43:33 +0100
Received: from 63.70.210.1 by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.2)); Mon, 28 Apr 2003 07:40:15 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id HAA05398; Mon, 28 Apr 2003 07:43:02 -0700 (PDT)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 h3SEhKov013845; Mon, 28 Apr 2003 07:43:20 -0700 (PDT)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id HAA00925; Mon,
 28 Apr 2003 07:43:20 -0700
Message-ID: <3EAD3E07.C5651D44@broadcom.com>
Date: Mon, 28 Apr 2003 07:43:19 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: [PATCH]: load_mmu for SMP systems
References: <3EA97D54.6910D49E@broadcom.com>
 <20030428025639.A20753@linux-mips.org>
X-WSS-ID: 12B3E2C51870289-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> > TLB flush routines that have loops running up to tlbsize will lose if
> > it's not set properly on all CPUs!
> 
> Yeah, they're going to be sort of slow.  There must be a reason for all
> those GHz processors ;-)

Um, it was worse than that if (for example) a complete TLB flush has a
"for (i=0; i<0; i++)" loop around it.  My board was experiencing
occasional userland segfaults thanks to bogus TLB flushing.

Kip
