Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 14:22:59 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:22235 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025538AbYH0NW5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 14:22:57 +0100
Received: from localhost (p1019-ipad312funabasi.chiba.ocn.ne.jp [123.217.219.19])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2ACB2BB7B; Wed, 27 Aug 2008 22:22:49 +0900 (JST)
Date:	Wed, 27 Aug 2008 22:22:51 +0900 (JST)
Message-Id: <20080827.222251.108121533.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove never used pci_probe variable
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080827091935.GA28714@linux-mips.org>
References: <20080419.003435.26096353.anemo@mba.ocn.ne.jp>
	<20080708.011426.08077033.anemo@mba.ocn.ne.jp>
	<20080827091935.GA28714@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Aug 2008 10:19:35 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> I think real problem here is that we have two variables which both serve the
> same purpose, pci_probe_only and pci_probe, no?  Not entirely sure here
> because the alpha defines:
> 
> arch/alpha/include/asm/pci.h:#define pcibios_assign_all_busses()        1
> 
> yet it has pci_probe_only ...

I'm not sure pci_probe and pci_probe_only have same purpose... My
patch is just an cleanup and does not change current behaviour.

Real users of pci_probe_only might have some opinions ;)
---
Atsushi Nemoto
