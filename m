Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 11:28:31 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:10259 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133646AbWBTL2Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 11:28:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KBYKkW008647;
	Mon, 20 Feb 2006 11:34:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KBYK7X008646;
	Mon, 20 Feb 2006 11:34:20 GMT
Date:	Mon, 20 Feb 2006 11:34:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: elf.h
Message-ID: <20060220113420.GB5594@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com> <20060220001126.GA17967@deprecation.cyrius.com> <20060220003128.GD17967@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220003128.GD17967@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 12:31:28AM +0000, Martin Michlmayr wrote:

> Can we agree?

> -#define EM_MIPS_RS4_BE 10	/* MIPS R4000 big-endian */
> +#define EM_MIPS_RS3_LE 10	/* MIPS R3000 little-endian */

Not really :-)

I've dug deep into history - but it seems nobody remembers the reason for
this change anymore.  I suspect actually both constant names might
historically have been in use.  For the purposes of Linux it's probably
best to dump the whole number - it never had any relevance.

  Ralf
