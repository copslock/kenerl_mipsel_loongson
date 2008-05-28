Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 08:14:02 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:56841 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S20024105AbYE1HN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 May 2008 08:13:59 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6C773D8E6; Wed, 28 May 2008 07:13:57 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id F258A150F7F; Wed, 28 May 2008 03:12:40 -0400 (EDT)
Date:	Wed, 28 May 2008 09:12:40 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Malta build errors with 2.6.26-rc1
Message-ID: <20080528071240.GB10393@deprecation.cyrius.com>
References: <20080512163107.GA19052@deprecation.cyrius.com> <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820805121246o328d1cdaide88594ce9d328b7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Dmitri Vorobiev <dmitri.vorobiev@gmail.com> [2008-05-12 23:46]:
> > Some Malta build errors:
> >
> >  cc1: warnings being treated as errors
> >  arch/mips/mips-boards/malta/malta_int.c: In function 'gcmp_probe':
> >  arch/mips/mips-boards/malta/malta_int.c:408: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c: In function 'arch_init_irq':
> >  arch/mips/mips-boards/malta/malta_int.c:437: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c:441: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c: In function 'malta_be_handler':
> >  arch/mips/mips-boards/malta/malta_int.c:656: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c:657: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c:658: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/malta/malta_int.c:704: warning: cast to pointer from integer of different size
> >  make[5]: *** [arch/mips/mips-boards/malta/malta_int.o] Error 1
> >
> >  and:
> >
> >  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_avail':
> >  arch/mips/mips-boards/generic/amon.c:31: error: implicit declaration of function 'KSEG0ADDR'
> >  cc1: warnings being treated as errors
> >  arch/mips/mips-boards/generic/amon.c:31: warning: cast to pointer from integer of different size
> >  arch/mips/mips-boards/generic/amon.c: In function 'amon_cpu_start':
> >  arch/mips/mips-boards/generic/amon.c:56: warning: cast to pointer from integer of different size
> >  make[4]: *** [arch/mips/mips-boards/malta] Error 2
> >
> 
> Known error. Please see this thread for some suggestions (and be
> warned that I did not try any of them):
> http://marc.info/?t=120966332300004&r=1&w=2

Isn't that a completely different issue?  Anyway, I just tried and I
still see the problems above (with 64 bit Malta) still after applying
the traps.c patch from Thomas Bogendoerfer.

Is there a maintainer for Malta?
-- 
Martin Michlmayr
http://www.cyrius.com/
