Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2006 21:58:17 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:4554 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039336AbWKVV6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Nov 2006 21:58:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAMLw8jw009243;
	Wed, 22 Nov 2006 21:58:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAMLw4Tc009242;
	Wed, 22 Nov 2006 21:58:04 GMT
Date:	Wed, 22 Nov 2006 21:58:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
Cc:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
Message-ID: <20061122215803.GA8819@linux-mips.org>
References: <E8C8A5231DDE104C816ADF532E0639120194F4EB@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8C8A5231DDE104C816ADF532E0639120194F4EB@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 22, 2006 at 12:31:10PM -0800, Trevor Hamm wrote:

> The source of the problem seems to be with squashfs.  When I compare booting a kernel using squashfs to one using cramfs (which always seems to boot successfully on power-up), both are reading the troublesome page from /lib/ld-uClibc.so, and both are calling flush_dcache_page() on this page.  But in the case of cramfs, flush_dcache_page() causes an immediate cache flush of that page (mapping_mapped(mapping) in __flush_dcache_page() is returning non-zero), while squashfs just marks the page as dirty and defers the cache flush (mapping_mapped(mapping) is returning zero).  I have no idea what causes this difference in behaviour, but right now it appears to be a bug in squashfs rather than the linux-mips kernel.

There are a few other potencial and real bugs me and Atsushi have found
in squashfs.  Guess there is a reason why it's not yet in the kernel ...
I'm still waiting for feedback from the squashfs author.

  Ralf
