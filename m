Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 02:18:08 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:59938
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225321AbULPCSC>; Thu, 16 Dec 2004 02:18:02 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 16 Dec 2004 02:18:00 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id D19D9239E3C; Thu, 16 Dec 2004 11:17:46 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id iBG2HkdD009839;
	Thu, 16 Dec 2004 11:17:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Thu, 16 Dec 2004 11:17:46 +0900 (JST)
Message-Id: <20041216.111746.25908722.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: macro@linux-mips.org, wlacey@goldenhindresearch.com,
	linux-mips@linux-mips.org
Subject: Re: No PCI_AUTO in 2.6...
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20041215184213.GB32491@linux-mips.org>
References: <20041215164036.GC30130@linux-mips.org>
	<Pine.LNX.4.58L.0412151648460.2706@blysk.ds.pg.gda.pl>
	<20041215184213.GB32491@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 15 Dec 2004 19:42:13 +0100, Ralf Baechle <ralf@linux-mips.org> said:
>> I know and I consider it a bug.  The correct way would be setting
>> the start at 0 and if avoiding the first kB of space was necessary,
>> setting PCIBIOS_MIN_IO to 0x1000.

ralf> PCIBIOS_MIN_IO is the same value for all busses.  That can turn
ralf> out a bit kludgy so I'm not much of a friend of it.

BTW, yenta_socket driver uses PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM, so
these variables should be exported?

--- linux-mips/arch/mips/pci/pci.c	2004-12-13 09:39:09.000000000 +0900
+++ linux/arch/mips/pci/pci.c	2004-12-13 10:02:32.000000000 +0900
@@ -294,6 +294,8 @@
 
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_resource_to_bus);
+EXPORT_SYMBOL(PCIBIOS_MIN_IO);
+EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
 #endif
 
 char *pcibios_setup(char *str)

---
Atsushi Nemoto
