Received:  by oss.sgi.com id <S553806AbRAJFOa>;
	Tue, 9 Jan 2001 21:14:30 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:65521 "EHLO
        lappi.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553791AbRAJFOK>; Tue, 9 Jan 2001 21:14:10 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S868130AbRAJFD0>; Wed, 10 Jan 2001 03:03:26 -0200
Date:	Wed, 10 Jan 2001 03:03:26 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Justin Carlson <carlson@sibyte.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: _clear_page semantics
Message-ID: <20010110030326.B8489@bacchus.dhis.org>
References: <01010917590106.07691@plugh.sibyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01010917590106.07691@plugh.sibyte.com>; from carlson@sibyte.com on Tue, Jan 09, 2001 at 05:48:11PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 05:48:11PM -0800, Justin Carlson wrote:

> Looking at the existing clear_page implementations for r4xx0, rm7k, and mips32
> in the mips/ tree, I see everyone issuing cache op 0xd for the address range of
> the page being cleared.
> 
> I'm wondering what the purpose is of these cache flushes...given a physically
> tagged dcache, my understanding of the semantics of clear_page are that it just
> zeros the page, in which case the cache ops are pointless overhead.
> 
> Especially in the mips32 case, which uses cache op 0xd, which is undefined
> implementation dependent according to my mips32 spec.

The idea is to avoid unnecessary memory reads - all the read data would
be overwritten anyway.  The last time I benchmarked this routine on some
machine it made a difference of about 4000 vs. 2500 c0_count cycles.  I
think that was on a R4600 RM200.

  Ralf
