Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2003 02:31:27 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:65056
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225214AbTE1Bay>; Wed, 28 May 2003 02:30:54 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 28 May 2003 01:30:52 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h4S1UHjf007873;
	Wed, 28 May 2003 10:30:17 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 28 May 2003 10:30:46 +0900 (JST)
Message-Id: <20030528.103046.41627144.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: hch@infradead.org, anemo@mba.ocn.ne.jp, wgowcher@yahoo.com,
	linux-mips@linux-mips.org
Subject: Re: pci_alloc_consistent usage
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030527114551.GC24905@linux-mips.org>
	<20030527112237.GA24905@linux-mips.org>
References: <20030527112237.GA24905@linux-mips.org>
	<20030527123329.A7750@infradead.org>
	<20030527114551.GC24905@linux-mips.org>
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
X-archive-position: 2471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 27 May 2003 13:22:37 +0200, Ralf Baechle <ralf@linux-mips.org> said:
ralf> While it's officially documented I still don't like it.  A
ralf> double conversion such as page_address(virt_to_page(ptr)) would
ralf> accidently turn a pointer of an uncached mapping into one to a
ralf> cached area for the same object - that will almost certainly not
ralf> work as expected on a non-coherent machine.

Yes, it's dangerous, I agree.

ralf> Whatever - virt_to_page should then be considered a a legacy API
ralf> which we have to try to support as well as possible in the hope
ralf> it's going to fade away ...

I hope so.  For now we can do something like:

     buf = pci_alloc_consistent(dev, size, &dmabuf);
#if defined(__mips__) && defined(CONFIG_NONCOHERENT_IO)
     page = virt_to_page(CAC_ADDR(buf));
#else
     page = virt_to_page(buf);
#endif

Ugly but I do not want to add extra overhead to virt_to_page itself...

---
Atsushi Nemoto
