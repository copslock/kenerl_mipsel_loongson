Received:  by oss.sgi.com id <S553784AbRAHQPI>;
	Mon, 8 Jan 2001 08:15:08 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:30706 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553778AbRAHQO5>; Mon, 8 Jan 2001 08:14:57 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHQFG>; Mon, 8 Jan 2001 14:05:06 -0200
Date:	Mon, 8 Jan 2001 14:05:06 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Carsten Langgaard <carstenl@mips.com>,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108140506.B886@bacchus.dhis.org>
References: <00d801c0797d$5cc410c0$0deca8c0@Ulysses> <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010108151854.23234G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 08, 2001 at 04:07:31PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 04:07:31PM +0100, Maciej W. Rozycki wrote:

>  The only case caches need to be synchronized is modifying some code.  The
> ptrace syscall does it automatically for text writes -- it's needed and
> used by gdb to set breakpoints, for example.  For other code there is
> cacheflush() which allows you to flush a cache range relevant to a given
> virtual address (I see it's not implemented very well at the moment).
> 
>  Obviously, you don't want to allow unprivileged users to flush caches as
> a whole as it could lead to a DoS. 

You obviously want to allow partial cache flushes or trampolines don't work
and flushing the entire cache can be constructed from that.

  Ralf
