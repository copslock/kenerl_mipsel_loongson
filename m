Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2004 14:12:34 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:47654
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225206AbUHTNMa>; Fri, 20 Aug 2004 14:12:30 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1By9Bj-0006XO-00; Fri, 20 Aug 2004 15:12:11 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1By9Bi-0007Ec-00; Fri, 20 Aug 2004 15:12:10 +0200
Date: Fri, 20 Aug 2004 15:12:10 +0200
To: Dominic Sweetman <dom@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org
Subject: Re: anybody tried NPTL?
Message-ID: <20040820131210.GE14937@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040804152936.D6269@mvista.com> <16676.46694.564448.344602@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16676.46694.564448.344602@arsenal.mips.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Dominic Sweetman wrote:
[snip]
> So we're proposing:
> 
> o The register name<->number mapping is that of n64.
> 
> o Calling convention: register-, not slot-based. Each argument is
>   represented by a register value. Arguments 0-7 travel in registers
>   a0-7 (or fa0-7 as required for floating point types).

This suggests to have no fp temporaries left: fv0-1, fa0-7, fs0-5.
Is this intentional?


Thiemo
