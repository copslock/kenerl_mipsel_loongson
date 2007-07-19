Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2007 12:15:07 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36495 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022541AbXGSLPF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Jul 2007 12:15:05 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6JBEepb020118;
	Thu, 19 Jul 2007 12:14:41 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6JBEeZU020117;
	Thu, 19 Jul 2007 12:14:40 +0100
Date:	Thu, 19 Jul 2007 12:14:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [RFC] User stack pointer randomisation
Message-ID: <20070719111440.GA19916@linux-mips.org>
References: <469F0E5F.4050005@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469F0E5F.4050005@innova-card.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 19, 2007 at 09:10:23AM +0200, Franck Bui-Huu wrote:

> This patch adds a page size range randomisation to the user
> stack pointer.

Looks fine to me aside of the issue Nigel raised.

There is a constant defining the ABI-specific alignment in <asm/asm.h>:

#if (_MIPS_SIM == _MIPS_SIM_ABI32)
#define ALSZ    7
#define ALMASK  ~7
#endif
#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
#define ALSZ    15
#define ALMASK  ~15
#endif

This will unnecessarily increase the alignment of the stack wasting a few
bytes of memory for O32 binaries running on 64-bit kernels but I'd just
ignore this artefact; the cure would be uglier than the disease ;-)

  Ralf
