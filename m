Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 18:08:10 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:35345 "HELO
	sorrow.cyrius.com") by ftp.linux-mips.org with SMTP
	id S8133536AbWDGRIB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Apr 2006 18:08:01 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6CC2564D3F; Fri,  7 Apr 2006 17:19:19 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 60FB466B69; Fri,  7 Apr 2006 19:19:10 +0200 (CEST)
Date:	Fri, 7 Apr 2006 19:19:10 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060407171910.GU6869@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com> <20060220113420.GB5594@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220113420.GB5594@linux-mips.org>
User-Agent: Mutt/1.5.11+cvs20060330
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-02-20 11:34]:
> > Can we agree?
> > -#define EM_MIPS_RS4_BE 10	/* MIPS R4000 big-endian */
> > +#define EM_MIPS_RS3_LE 10	/* MIPS R3000 little-endian */
> Not really :-)
> 
> I've dug deep into history - but it seems nobody remembers the reason for
> this change anymore.  I suspect actually both constant names might
> historically have been in use.  For the purposes of Linux it's probably
> best to dump the whole number - it never had any relevance.

Maybe you can remove it, or at least bring it in sync.
-- 
Martin Michlmayr
http://www.cyrius.com/
