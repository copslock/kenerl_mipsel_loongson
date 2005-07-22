Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 05:29:31 +0100 (BST)
Received: from [IPv6:::ffff:216.208.38.107] ([IPv6:::ffff:216.208.38.107]:60311
	"EHLO OTTLS.pngxnet.com") by linux-mips.org with ESMTP
	id <S8225245AbVGVE3K>; Fri, 22 Jul 2005 05:29:10 +0100
Received: from bacchus.net.dhis.org ([10.255.255.134])
	by OTTLS.pngxnet.com (8.12.4/8.12.4) with ESMTP id j6M4V5nA009137
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 00:31:05 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6M4UwQE004296;
	Fri, 22 Jul 2005 00:30:59 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6M4Uv68004293;
	Fri, 22 Jul 2005 00:30:57 -0400
Date:	Fri, 22 Jul 2005 00:30:57 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722043057.GA3803@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050721153359Z8225218-3678+3745@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 21, 2005 at 04:33:53PM +0100, ths@linux-mips.org wrote:

> Modified files:
> 	arch/mips/kernel: binfmt_elfo32.c 
> 	include/asm-mips: elf.h 
> 
> Log message:
> 	Fix ELF defines: EF_* is a field, E_* a distinct flag therein.

Remarkably bad idea after the old definitions are already being used since
over a decade.

Btw, I don't recall approving that patch ...

  Ralf
