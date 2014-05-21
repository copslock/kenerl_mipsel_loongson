Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 14:41:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51320 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835073AbaEUMlgGHCVu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 May 2014 14:41:36 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4LCf1U2022972;
        Wed, 21 May 2014 14:41:01 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4LCefof022971;
        Wed, 21 May 2014 14:40:41 +0200
Date:   Wed, 21 May 2014 14:40:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney.cavm@gmail.com>,
        James Hogan <james.hogan@imgtec.com>, kvm@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 06/15] MIPS: Add minimal support for OCTEON3 to c-r4k.c
Message-ID: <20140521124041.GP10287@linux-mips.org>
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400597236-11352-7-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, May 20, 2014 at 04:47:07PM +0200, Andreas Herrmann wrote:

> +static inline void r4k_blast_dcache_page_dc128(unsigned long addr)
> +{
> +	R4600_HIT_CACHEOP_WAR_IMPL;

The R4600 has 32 byte cache lines that is this line will never be
executed on an R4600 thus can be dropped.

> +	blast_dcache128_page(addr);
> +}
> +
>  static void r4k_blast_dcache_page_setup(void)
>  {
>  	unsigned long  dc_lsize = cpu_dcache_line_size();
> @@ -121,6 +127,8 @@ static void r4k_blast_dcache_page_setup(void)
>  		r4k_blast_dcache_page = r4k_blast_dcache_page_dc32;
>  	else if (dc_lsize == 64)
>  		r4k_blast_dcache_page = r4k_blast_dcache_page_dc64;
> +	else if (dc_lsize == 128)
> +		r4k_blast_dcache_page = r4k_blast_dcache_page_dc128;


For another patch - let's see if this can be turned into a switch
construct which hopefully is more readable and produces just as
afficient code with reasonable vintage of gcc.

  Ralf
