Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 May 2003 11:08:10 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:34842
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225232AbTE0KHi>; Tue, 27 May 2003 11:07:38 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 27 May 2003 10:07:35 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h4RA7Kjf006331;
	Tue, 27 May 2003 19:07:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Tue, 27 May 2003 19:07:49 +0900 (JST)
Message-Id: <20030527.190749.39150100.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: wgowcher@yahoo.com, linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent usage
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030527091740.GA23296@linux-mips.org>
References: <20030523215935.71373.qmail@web11901.mail.yahoo.com>
	<20030527091740.GA23296@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 27 May 2003 11:17:40 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> Use the value returned by pci_alloc_consistent in *dma_handle
ralf> instead of trying to do any conversions with of
ralf> pci_alloc_consistent's return value.

How about virt_to_page()?

Currently, many sound drivers (including ALSA) pass a
pci_alloc_consistent's return value to virt_to_page.  While
virt_to_page is defined as below, we can not pass KSEG1 address
(returned by pci_alloc_consistent) to virt_to_page.

#define __pa(x)		((unsigned long) (x) - PAGE_OFFSET)
#define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))

Following definition can handle this case properly,

#define virt_to_page(kaddr)	(mem_map + (PHYSADDR(kaddr) >> PAGE_SHIFT))

But as ralf said, PHYSADDR() may be is a bit slower then __pa().

Is it worth to change?  Or should we fix the driver using virt_to_page
with pci_alloc_consistent?

---
Atsushi Nemoto
