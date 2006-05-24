Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2006 14:52:25 +0200 (CEST)
Received: from sorrow.cyrius.com ([65.19.161.204]:20499 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133511AbWEXMwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 May 2006 14:52:18 +0200
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B5C3864D54; Wed, 24 May 2006 12:52:10 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id AE37C66AFD; Wed, 24 May 2006 14:51:57 +0200 (CEST)
Date:	Wed, 24 May 2006 14:51:57 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Sibyte: Fix race in sb1250_gettimeoffset().
Message-ID: <20060524125157.GA22730@deprecation.cyrius.com>
References: <S8133620AbWCPM6I/20060316125808Z+139@ftp.linux-mips.org> <20060316141127.GS25322@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316141127.GS25322@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-03-16 14:11]:
> > +	/* Setup HPT */
> > +	sb1250_hpt_setup();
> > +}
> This leads to compiler errors on 1480 because sb1250_hpt_setup() is
> not defined.  We need something like the patch below (or possibly a
> proper fix?):

This problem is still there.  Anyone working on a fix?

The problem is the following when building a kernel for BigSur:

> arch/mips/sibyte/swarm/lib.a(setup.o): In function `swarm_time_init':
> setup.c:(.init.text+0x0): undefined reference to `sb1250_hpt_setup'

-- 
Martin Michlmayr
http://www.cyrius.com/
