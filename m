Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2017 09:03:57 +0200 (CEST)
Received: from kirsty.vergenet.net ([202.4.237.240]:58154 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990422AbdJPHDYQZdHe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Oct 2017 09:03:24 +0200
Received: from penelope.horms.nl (unknown [217.111.208.18])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0A82825B819;
        Mon, 16 Oct 2017 18:03:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1508137396; bh=Qq3oUwasXpKQhjyNRKQZFWj7iqs5LuzYv63PXyic2N8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hne/fGQfRpBpqSkOIiQ0Nz6RN3jdP2bvvWc+LOLmUP8vaUtXw9LQQ/7zI2MYmokNO
         h+vbeILqnGhPEERuQb+Ilrpnr/vCzNh6dQQAL3kjPxc0zvfZx8vDZdhlhluhDjWac7
         sjuDpz/8mNpy2OJbhiNBuI1l3xJdrx21e2kQNfoc=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 66942E21DA8; Mon, 16 Oct 2017 08:53:13 +0200 (CEST)
Date:   Mon, 16 Oct 2017 08:53:13 +0200
From:   Simon Horman <horms@verge.net.au>
To:     David Daney <david.daney@cavium.com>
Cc:     kexec@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] kexec-tools: mips: Merge adjacent memory ranges.
Message-ID: <20171016065313.g5va4jel5si2udbm@verge.net.au>
References: <20171012210228.7353-1-david.daney@cavium.com>
 <20171012210228.7353-2-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012210228.7353-2-david.daney@cavium.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60404
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

On Thu, Oct 12, 2017 at 02:02:25PM -0700, David Daney wrote:
> Some kernel versions running on MIPS split the System RAM memory
> regions reported in /proc/iomem.  This may cause loading of the kexec
> kernel to fail if it crosses one of the splits.
> 
> Fix by merging adjacent memory ranges that have the same type.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  kexec/arch/mips/kexec-mips.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
> index 2e5b700..415c2ed 100644
> --- a/kexec/arch/mips/kexec-mips.c
> +++ b/kexec/arch/mips/kexec-mips.c
> @@ -60,10 +60,16 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>  		} else {
>  			continue;
>  		}
> -		memory_range[memory_ranges].start = start;
> -		memory_range[memory_ranges].end = end;
> -		memory_range[memory_ranges].type = type;
> -		memory_ranges++;
> +		if (memory_ranges > 0 &&

It seems that this will never merge the first memory range
with subsequent ones. Is that intentional?


> +		    memory_range[memory_ranges - 1].end == start &&
> +		    memory_range[memory_ranges - 1].type == type) {
> +			memory_range[memory_ranges - 1].end = end;
> +		} else {
> +			memory_range[memory_ranges].start = start;
> +			memory_range[memory_ranges].end = end;
> +			memory_range[memory_ranges].type = type;
> +			memory_ranges++;
> +		}
>  	}
>  	fclose(fp);
>  	*range = memory_range;
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
