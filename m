Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2005 00:57:05 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:5711
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225437AbVAHA47>; Sat, 8 Jan 2005 00:56:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Cn4uX-00062l-00; Sat, 08 Jan 2005 01:56:57 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Cn4uS-0004q2-00; Sat, 08 Jan 2005 01:56:52 +0100
Date: Sat, 8 Jan 2005 01:56:52 +0100
To: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc: linux-mips@linux-mips.org, ths@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050108005652.GJ31335@rembrandt.csv.ica.uni-stuttgart.de>
References: <20050107191947Z8225432-1341+49@linux-mips.org> <41DEF45B.8060800@total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEF45B.8060800@total-knowledge.com>
User-Agent: Mutt/1.5.6+20040907i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ilya A. Volynets-Evenbakh wrote:
> ths@linux-mips.org wrote:
> 
> >CVSROOT:	/home/cvs
> >Module name:	linux
> >Changes by:	ths@ftp.linux-mips.org	05/01/07 19:19:40
> >
> >Modified files:
> >	arch/mips/kernel: signal.c signal_n32.c 
> >Added files:
> >	arch/mips/kernel: signal-common.h 
> >
> >Log message:
> >	Save a bit of copy&paste by separating out common parts in the 
> >	signal handling.
> >
> Seems like following piece is missing from this patch:
> 
> Index: arch/mips/kernel/signal.c

Plus some bits in signal_n32.c. Fix committed, sorry for the breakage.


Thiemo
