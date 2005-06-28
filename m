Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 09:08:07 +0100 (BST)
Received: from x93.infopact.nl ([IPv6:::ffff:212.29.160.93]:17312 "EHLO
	x93.infopact.nl") by linux-mips.org with ESMTP id <S8226025AbVF1IHq>;
	Tue, 28 Jun 2005 09:07:46 +0100
Received: from 63-66-dsl.ipact.nl (63-66-dsl.ipact.nl [84.35.66.63])
	by x93.infopact.nl (8.12.10/8.12.10) with ESMTP id j5S87Aa3018109;
	Tue, 28 Jun 2005 10:07:10 +0200
From:	Steven Bosscher <stevenb@suse.de>
To:	gcc-patches@gcc.gnu.org
Subject: Re: -march=r10000 Support for MIPS Targets (Old 3.4.x Patch; requires porting, assistance requested)
Date:	Tue, 28 Jun 2005 10:07:12 +0200
User-Agent: KMail/1.7.1
Cc:	Kumba <kumba@gentoo.org>,
	Linux MIPS List <linux-mips@linux-mips.org>
References: <42C0D94F.3030809@gentoo.org>
In-Reply-To: <42C0D94F.3030809@gentoo.org>
Organization: SUSE Labs
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506281007.12754.stevenb@suse.de>
X-CanItPRO-Stream: NoScan
X-Canit-Stats-ID: 8575107 - 6f8658aa76f3
X-Scanned-By: CanIt (www . roaringpenguin . com) on 212.29.160.93
Return-Path: <stevenb@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stevenb@suse.de
Precedence: bulk
X-list: linux-mips

On Tuesday 28 June 2005 06:59, Kumba wrote:
> If at all possible I'd like to see it make it into gcc at some point in
> time, not necessarily gcc-4.1, as the patch as it currently stands needs
> someone to do the work of porting it to fit into 4.x,  

Looks like all the arith->shift attribute changes from the patch you
posted are already in mainline, so all you really need to add r10000
support is a pipeline model.  All the MIPSen were converted from the
old pipeline description (i.e. "define_function_unit") to the new one
(i.e. "define_insn_reservation" and friends) in a big patch posted
last year: http://gcc.gnu.org/ml/gcc-patches/2004-07/msg01065.html.
Maybe you can find in the trhead surrounding that message some ideas
on how to convert your r10000 pipeline model.

HTH,

Gr.
Steven
