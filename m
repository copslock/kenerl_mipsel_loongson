Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 09:03:29 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:58151 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990417AbdJPHDVr20Ye (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 09:03:21 +0200
Received: from penelope.horms.nl (unknown [217.111.208.18])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0459225B818;
        Mon, 16 Oct 2017 18:03:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508137396; bh=2ObNEtMWj+ZQtGT8NckWSPj6YiQIBYAq+ieYd5ZGoPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoYmMeJA5a4vy58erGShzSfFkn0lF8m0V5vrNEIaCSvlyaVPHX5FV0FdUARg3iYz/
         iW+EyxcPHpNNmsIpfoiA6ebzM+EWUYVs7Je6YiD7h8gaojlXdO+m+ErukKmyXHqqHZ
         R3ha7AjFELdLS4bZs1jgu4Lgu0djh0CGQXu6Ekoo=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 59E06E21DF1; Mon, 16 Oct 2017 08:56:36 +0200 (CEST)
Date:   Mon, 16 Oct 2017 08:56:36 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <david.daney@cavium.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] kexec-tools: mips: Use proper page_offset for OCTEON
 CPUs.
Message-ID: <20171016065636.wxm3nrzq7lkn4lw6@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-4-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-4-david.daney@cavium.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
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

On Thu, Oct 12, 2017 at 02:02:27PM -0700, David Daney wrote:
> The OCTEON family of MIPS64 CPUs uses a PAGE_OFFSET of
> 0x8000000000000000ULL, which is differs from other CPUs.
> 
> Scan /proc/cpuinfo to see if the current system is "Octeon", if so,
> patch the page_offset so that usable kdump core files are produced.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Is it possible to read this offset from the system rather than
checking for an Octeon CPU? It seems that such an approach, if possible,
would be somewhat more general.
