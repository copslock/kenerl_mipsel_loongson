Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 16:13:37 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41011
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225203AbVAFQNd>; Thu, 6 Jan 2005 16:13:33 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CmaFu-00063g-00; Thu, 06 Jan 2005 17:12:58 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CmaFk-0007VP-00; Thu, 06 Jan 2005 17:12:48 +0100
Date: Thu, 6 Jan 2005 17:12:48 +0100
To: Christoph Hellwig <hch@lst.de>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org
Subject: Re: [RFC] Add 4/8 bytes to 'struct k_sigaction'...
Message-ID: <20050106161248.GO4017@rembrandt.csv.ica.uni-stuttgart.de>
References: <41DCC038.9000307@realitydiluted.com> <20050106154852.GA23433@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106154852.GA23433@lst.de>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> > --- signal.h	30 Sep 2003 14:27:29 -0000	1.17
> > +++ signal.h	6 Jan 2005 04:21:58 -0000
> > @@ -135,7 +135,7 @@
> > 
> >  struct k_sigaction {
> >  	struct sigaction sa;
> > -#ifdef CONFIG_BINFMT_IRIX
> > +#if !defined(CONFIG_CPU_LITTLE_ENDIAN)
> >  	void		(*sa_restorer)(void);
> >  #endif
> 
> #ifdef __mipseb__ maybe?

AFAICS most parts of the kernel seem to prefer CONFIG_CPU_LITTLE_ENDIAN
over compiler-dependent macros. (And IIRC it would need to be __MIPSEB.)


Thiemo
