Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 16:33:21 +0100 (BST)
Received: from p508B7F62.dip.t-dialin.net ([IPv6:::ffff:80.139.127.98]:35018
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbTDWPdU>; Wed, 23 Apr 2003 16:33:20 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3NFKfs00930;
	Wed, 23 Apr 2003 17:20:41 +0200
Date: Wed, 23 Apr 2003 17:20:41 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: c-r4k.c build fix
Message-ID: <20030423172041.A855@linux-mips.org>
References: <20030423.121836.74756059.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030423.121836.74756059.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Apr 23, 2003 at 12:18:36PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 23, 2003 at 12:18:36PM +0900, Atsushi Nemoto wrote:

> If neither R4600_V1_HIT_CACHEOP_WAR or R4600_V2_HIT_CACHEOP_WAR were
> defined (i.e. R4600_HIT_CACHEOP_WAR_DECL was empty), gcc 2.x can not
> compile c-r4k.c.
> 
> c-r4k.c: In function `r4k_blast_dcache_page':
> c-r4k.c:138: parse error before `static'
> 
> Here is a patch.

Thanks,

  Ralf
