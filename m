Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 23:56:23 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50279
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225592AbUAVX4X>; Thu, 22 Jan 2004 23:56:23 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AjogN-00030T-00; Fri, 23 Jan 2004 00:56:19 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AjogN-0000K5-00; Fri, 23 Jan 2004 00:56:19 +0100
Date: Fri, 23 Jan 2004 00:56:19 +0100
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Lossage do to #ifndef __ASSEMBLY__ in mipsregs.h
Message-ID: <20040122235619.GR23173@rembrandt.csv.ica.uni-stuttgart.de>
References: <40105A6F.3060009@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40105A6F.3060009@avtrex.com>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> I am using gcc 3.3.1 to compile the linux_2_4 kernel obtained from cvs a 
> couple of days ago.
[snip]
> -#endif /* !defined (_LANGUAGE_ASSEMBLY) */
> +#endif /* !__ASSEMBLY__ */
> 
> #endif /* _ASM_MIPSREGS_H */
> 
> Why the change?

__ASSEMBLY__ is defined by the Linux build system in order to have a
compiler independent test.

> I will fix my local mipsregs.h so that I can continue, but it seems like 
> the sources in CVS should be changed to allow gcc 3.3.1 to work.

It works here (for my configs). Your linux tree seems to be broken.


Thiemo
