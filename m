Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 09:08:45 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:58222 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990417AbdJPHIWUvvde (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 09:08:22 +0200
Received: from penelope.horms.nl (unknown [217.111.208.18])
        by kirsty.vergenet.net (Postfix) with ESMTPA id E3B4725B819;
        Mon, 16 Oct 2017 18:08:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508137696; bh=Mn5mhoKym31TX//nW6BLzjBBY/Exlhau1gHj7Hf4AGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gT4DfjhcqSAty4Y8V5x/Utyei0uEWMEWb05ixCBHPBHsQy8t/AY2p22FZULsFC5sf
         ycTlBKxvB7B+bWSLG4rsz6U5lkI87752olusQbi75A+0mEbQ8ItwNqlLkq8tkt+nPV
         DQOHuGeaQgtmdq/w7s9CkBCcMkrTLP5RKjQ7niPU=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 11300E21DF2; Mon, 16 Oct 2017 09:01:57 +0200 (CEST)
Date:   Mon, 16 Oct 2017 09:01:57 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <david.daney@cavium.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] kexec-tools: mips: Don't set lowmem_limit to 2G for
 64-bit systems.
Message-ID: <20171016070156.pcdlmsqyj5mep7hr@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-3-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-3-david.daney@cavium.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60406
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

On Thu, Oct 12, 2017 at 02:02:26PM -0700, David Daney wrote:
> The 64-bit MIPS architecture doesn't have the same 2G limit the 32-bit
> version has.  Set MAXMEM and lowmem_limit to 0 for 64-bit MIPS so that
> memory above 2G is usable in the kdump core files.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Thanks, applied.
