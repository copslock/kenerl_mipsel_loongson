Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 16:22:21 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:2249 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024694AbXHXPWM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Aug 2007 16:22:12 +0100
Received: from localhost (p7014-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.14])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 9BAA0B649
	for <linux-mips@linux-mips.org>; Sat, 25 Aug 2007 00:22:07 +0900 (JST)
Date:	Sat, 25 Aug 2007 00:23:28 +0900 (JST)
Message-Id: <20070825.002328.108738360.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] PCI: Remove __devinit attribute from pcibios_fixup_bus.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20023984AbXHXBUC/20070824012002Z+18840@ftp.linux-mips.org>
References: <S20023984AbXHXBUC/20070824012002Z+18840@ftp.linux-mips.org>
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
X-archive-position: 16276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 24 Aug 2007 02:19:57 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Thu Aug 23 14:12:56 2007 +0100
> Commit: dda571e0032731ed05b65e365283c54522483b08
> Gitweb: http://www.linux-mips.org/g/linux/dda571e0
> Branch: master
> 
> Since 96bde06a2df1b363206d3cdef53134b84ff37813 pcibios_fixup_bus's caller
> pci_scan_child_bus is no longer marked __devinit resulting in this modpost
> warning if PCI && !HOTPLUG:

And pci_read_bridge_bases() called by pcibios_fixup_bus is still
marked __devinit.

Should we drop __devinit from pci_read_bridge_bases() too?

---
Atsushi Nemoto
