Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 16:57:33 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:4315 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039426AbXBOQ51 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2007 16:57:27 +0000
Received: from localhost (p8089-ipad32funabasi.chiba.ocn.ne.jp [221.189.140.89])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id DC064A000
	for <linux-mips@linux-mips.org>; Fri, 16 Feb 2007 01:54:35 +0900 (JST)
Date:	Fri, 16 Feb 2007 01:54:35 +0900 (JST)
Message-Id: <20070216.015435.74752851.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Iomap implementation.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S28573717AbXBNTgO/20070214193614Z+29688@ftp.linux-mips.org>
References: <S28573717AbXBNTgO/20070214193614Z+29688@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Feb 2007 19:36:09 +0000, linux-mips@linux-mips.org wrote:
> This implementation has support for the concept of one separate ioport
> address space by PCI domain.  A pointer to the virtual address where
> the port space of a domain has been mapped has been added to struct
> pci_controller and systems should be fixed to fill in this value. For
> single domain systems this will be the same value as passed to
> set_io_port_base().
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Compiling qemu kernel, I got:

arch/mips/lib/built-in.o: In function `pci_iomap':
(.text+0x2b0): undefined reference to `pci_domain_nr'

Should we add some #ifdef CONFIG_PCI to iomap.c, or provide dummy
pci_domain_nr()?

---
Atsushi Nemoto
