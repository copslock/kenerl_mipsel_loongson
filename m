Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2003 19:41:44 +0100 (BST)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:24071 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225377AbTJWSll>; Thu, 23 Oct 2003 19:41:41 +0100
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (MMS v5.5.3)); Thu, 23 Oct 2003 11:41:29 -0700
Received: from mail-sj1-1.sj.broadcom.com (mail-sj1-1.sj.broadcom.com
 [10.16.128.231]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id LAA09842; Thu, 23 Oct 2003 11:41:00 -0700 (PDT)
Received: from broadcom.com (ldt-sj3-158 [10.21.64.158]) by
 mail-sj1-1.sj.broadcom.com (8.12.9/8.12.4/SSM) with ESMTP id
 h9NIfMKX002301; Thu, 23 Oct 2003 11:41:28 -0700 (PDT)
Message-ID: <3F9820D2.528E0C73@broadcom.com>
Date: Thu, 23 Oct 2003 11:41:22 -0700
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-18.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Ralf Baechle" <ralf@linux-mips.org>
cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Ralf R?sch" <ralf.roesch@rw-gmbh.de>,
	"Linux/MIPS Development" <linux-mips@linux-mips.org>
Subject: Re: Compiler Problems in tlbex-r4k.S
References: <NHBBLBCCGMJFJIKAMKLHOEIJCBAA.ralf.roesch@rw-gmbh.de>
 <Pine.GSO.4.21.0310231142250.27218-100000@waterleaf.sonytel.be>
 <20031023163331.GA27437@linux-mips.org>
X-WSS-ID: 1386FF531622908-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> On Thu, Oct 23, 2003 at 11:43:27AM +0200, Geert Uytterhoeven wrote:
> 
> > > If I change the line 43 from:
> > > #define PTE_PAGE_SIZE       (1L << PTE_PAGE_SHIFT)
> > > to
> > > #define PTE_PAGE_SIZE       (1 << PTE_PAGE_SHIFT)
> > > the compiling is o.k.
> 
> The fix for this went into CVS yesterday.

Actually, this is a new problem which was my fault.  I'm checking in the
fix.

Apologies!

Kip
