Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 14:32:18 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:52340
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225243AbVAJOcO>; Mon, 10 Jan 2005 14:32:14 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Co0ab-0000Gs-00; Mon, 10 Jan 2005 15:32:13 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Co0aa-00069Q-00; Mon, 10 Jan 2005 15:32:12 +0100
Date: Mon, 10 Jan 2005 15:32:12 +0100
To: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Cc: linux-mips@linux-mips.org
Subject: Re: CPHYSADDR in setup.c
Message-ID: <20050110143212.GD15344@rembrandt.csv.ica.uni-stuttgart.de>
References: <41E26267.2090300@innova-card.com> <20050110135828.GB15344@rembrandt.csv.ica.uni-stuttgart.de> <41E29036.5040902@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E29036.5040902@innova-card.com>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Hi Thiemo
> 
> Thiemo Seufer wrote:
> 
> >That place in setup.c _had_ virt_to_phys before. It fails to build
> >for 64bit code in 32bit objects with reasonably modern toolchains
> >(which means all 64bit kernels currently supported in CVS).
> >
> yes, but can't we modify "virt_to_phys" or "__pa" directly instead of
> adding some new uses of CPHYSADDR in setup.c

We shouldn't. virt_to_phys accepts typesafe addresses, while CPHYSADDR
only juggles the bits of an unsigned long around. Degrading virt_to_phys
to the standard of CPHYSADDR isn't an improvement.


Thiemo
