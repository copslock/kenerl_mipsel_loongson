Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 17:26:55 +0100 (BST)
Received: from mms2.broadcom.com ([IPv6:::ffff:216.31.210.18]:4110 "EHLO
	MMS2.broadcom.com") by linux-mips.org with ESMTP
	id <S8224771AbVHQQ0b>; Wed, 17 Aug 2005 17:26:31 +0100
Received: from 10.10.64.121 by MMS2.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.1.0)); Wed, 17 Aug 2005 09:30:52 -0700
X-Server-Uuid: 1F20ACF3-9CAF-44F7-AB47-F294E2D5B4EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com; Wed, 17 Aug 2005 09:30:50
 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id BPI09130; Wed, 17 Aug 2005 09:30:04 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id JAA16963; Wed, 17 Aug 2005 09:30:03 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j7HGU2ov021905; Wed, 17 Aug 2005 09:30:03 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j7HGU2w17245; Wed, 17 Aug 2005 09:30:02 -0700
Date:	Wed, 17 Aug 2005 09:30:02 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] casts in TLB macros
Message-ID: <20050817163002.GO24444@broadcom.com>
References: <20050817030608.GM24444@broadcom.com>
 <20050817100830.GA2667@linux-mips.org>
MIME-Version: 1.0
In-Reply-To: <20050817100830.GA2667@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F1DB9B629O4554240-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

On Wed, Aug 17, 2005 at 11:08:30AM +0100, Ralf Baechle wrote:
> On Tue, Aug 16, 2005 at 08:06:08PM -0700, Andrew Isaacson wrote:
> 
> > Fix three cases where macro arguments are not parenthesized, leading to
> > incorrect operator precedence when called with an expression as the
> > argument.  This causes incorrect evaluation of
> >     write_c0_entrylo0(pte_val(*ptep++) >> 6)
> > when pte_t is 64 bits - the pte value is cast to (unsigned int) first,
> > then the shift is done, losing the top 32 bits.
> > 
> > Also, this does not add an extra set of parentheses surrounding the
> > (cast)(value) pair, as there's no danger of precedence problems to avoid
> > given the high precedence of the cast operator and that this is the
> > terminal macro in this macro trail.
> 
> Thanks, applied,

Thank *you* for being smarter than me about the parenthesis...

(The patch I sent out was lacking the outer parens, and I used the
following plan for world domination:
1. notice problem, cut patch
2. go to dinner
3. test compile something unrelated by accident
4. send patch to mailing list
5. profit!)

-andy
