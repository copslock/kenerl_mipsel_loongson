Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2005 11:11:58 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:47828 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225213AbVDBKLm>;
	Sat, 2 Apr 2005 11:11:42 +0100
Received: from port-195-158-169-58.dynamic.qsc.de ([195.158.169.58] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DHfbM-0001F5-00; Sat, 02 Apr 2005 12:11:36 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DHfbM-0008AG-3X; Sat, 02 Apr 2005 12:11:36 +0200
Date:	Sat, 2 Apr 2005 12:11:36 +0200
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050402101135.GB1641@hattusa.textio>
References: <20050401175340Z8226142-1340+5040@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050401175340Z8226142-1340+5040@linux-mips.org>
User-Agent: Mutt/1.5.8i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

macro@linux-mips.org wrote:
> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	macro@ftp.linux-mips.org	05/04/01 18:53:33
> 
> Modified files:
> 	arch/mips/mm   : pg-sb1.c 
> 
> Log message:
> 	Remove useless casts.  Fix formatting.

This patch leads for 64bit kernels to:

  CC      arch/mips/mm/pg-sb1.o
arch/mips/mm/pg-sb1.c: In function `sb1_dma_init':
arch/mips/mm/pg-sb1.c:220: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c:225: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type
arch/mips/mm/pg-sb1.c:226: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type
arch/mips/mm/pg-sb1.c:227: warning: passing arg 2 of `__raw_writeq' discards qualifiers from pointer target type
arch/mips/mm/pg-sb1.c: In function `clear_page':
arch/mips/mm/pg-sb1.c:233: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c:237: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c: In function `copy_page':
arch/mips/mm/pg-sb1.c:257: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c:258: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c:262: warning: cast from pointer to integer of different size
arch/mips/mm/pg-sb1.c:263: warning: cast from pointer to integer of different size
