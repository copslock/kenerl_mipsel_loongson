Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2004 10:36:50 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41523
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225529AbUE1Jgh>; Fri, 28 May 2004 10:36:37 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1BTdn0-0000kl-00; Fri, 28 May 2004 11:36:34 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1BTdn0-0007LM-00; Fri, 28 May 2004 11:36:34 +0200
Date: Fri, 28 May 2004 11:36:34 +0200
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Emmanuel Michon <em@realmagic.fr>, linux-mips@linux-mips.org
Subject: Re: down_trylock() implementation for MIPS 4KEc CPU implies 64bit arithmetics?
Message-ID: <20040528093634.GP17309@rembrandt.csv.ica.uni-stuttgart.de>
References: <1085589315.2306.49.camel@avalon.france.sdesigns.com> <20040526203346.GA8430@linux-mips.org> <1085668313.20233.1249.camel@avalon.france.sdesigns.com> <20040527155947.GA4154@linux-mips.org> <20040528003525.GA27796@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528003525.GA27796@linux-mips.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
[snip]
> +static __inline__ int atomic64_sub_if_positive(int i, atomic64_t * v)
> +{
> +	unsigned long temp, result;
> +
> +	__asm__ __volatile__(
> +	"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
> +	"	subu	%0, %1, %3				\n"

Shouldn't this be "dsubu"?


Thiemo
