Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 18:49:38 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:62570
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225375AbULBSte>; Thu, 2 Dec 2004 18:49:34 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CZw1D-0001hB-00; Thu, 02 Dec 2004 19:49:31 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CZw1C-0001SR-00; Thu, 02 Dec 2004 19:49:30 +0100
Date: Thu, 2 Dec 2004 19:49:30 +0100
To: "Maciej W. Rozycki" <macro@mips.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Label misplacement on an XTLB refill handler split
Message-ID: <20041202184930.GB3225@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.61.0412021746590.15065@perivale.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412021746590.15065@perivale.mips.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> Thiemo,
> 
>  The XTLB refill handler splitter misplaces labels associated with an
> instruction that gets placed in the branch delay slot of the splitting 
> branch.  Here's an example:
[snip]
> I've fixed it by separating the label mover (and the reloc mover, for 
> consistency) and using it to fix up relevant labels.  I'll apply it if 
> it's OK with you.
[snip]
> @@ -1110,6 +1121,7 @@ static void __init build_r4000_tlb_refil
>  			i_nop(&f);
>  		else {
>  			copy_handler(relocs, labels, split, split + 1, f);
> +			move_labels(labels, f, f + 1, -1);
>  			f++;
>  			split++;
>  		}

Thanks for catching this. Please apply.


Thiemo
