Received:  by oss.sgi.com id <S553650AbRACROq>;
	Wed, 3 Jan 2001 09:14:46 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:52212 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553645AbRACROT>; Wed, 3 Jan 2001 09:14:19 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S867580AbRACRFf>;
	Wed, 3 Jan 2001 15:05:35 -0200
Date:	Wed, 3 Jan 2001 15:05:35 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Jun Sun <jsun@mvista.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: missing data cache flush in trap_init?
Message-ID: <20010103150535.B904@bacchus.dhis.org>
References: <3A5277C6.89170BAD@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A5277C6.89170BAD@mvista.com>; from jsun@mvista.com on Tue, Jan 02, 2001 at 04:52:22PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 02, 2001 at 04:52:22PM -0800, Jun Sun wrote:

> Someone reported this bug to me.  I think it is a valid one.  Basically
> trap_init() installs the vectors through kseg0 address and then flushes
> icache.  It is possible that the vectors are still in the data cache and not
> written back to memory yet.  If an exception happens it may get the corrupted
> the vector value.
> 
> The following patch should fix it.  I am not sure if I can use
> flush_cache_range() to have potentially better performance.

Flush_icache_range is correct;  the function is expected to do any dcache
writebacks etc. to make dcache / icache / memory coherent.

Is it possible that you're using a CPU with additional vectors that aren't
flushed by this flush_icache_call or?

  Ralf
