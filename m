Received:  by oss.sgi.com id <S553910AbRAKERR>;
	Wed, 10 Jan 2001 20:17:17 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:30702 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553890AbRAKEQ6>; Wed, 10 Jan 2001 20:16:58 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S867580AbRAKEGF>; Thu, 11 Jan 2001 02:06:05 -0200
Date:	Thu, 11 Jan 2001 02:06:05 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	"Pete Popov" <ppopov@mvista.com>, <linux-mips@oss.sgi.com>
Subject: Re: CPU Nevada
Message-ID: <20010111020604.A24721@bacchus.dhis.org>
References: <3A5CDC3A.FE21F363@mvista.com> <012301c07b67$19b95c40$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <012301c07b67$19b95c40$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Jan 11, 2001 at 01:40:28AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jan 11, 2001 at 01:40:28AM +0100, Kevin D. Kissell wrote:

> C'mon Pete, it's obviously a typo!   It predates my involvement
> with the code - hell, I never even knew that "Nevada" was the
> QED code name for the R5200 family before I started hacking
> on the MIPS Linux kernel, even though I had an R5230 system
> in my lab.  The "6" is probably shifted left one position from 
> "R5260", which was, I believe, the first chip of the Nevada
> family to ship.

No idea how the 6 ended up there; I wrote the Nevada support for Cobalt's
Qube which originally using a R5230, the small brother of the 5260 with
just a 32 bit external bus.  Anyway, I fixed that buglet.

  Ralf
