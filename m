Received:  by oss.sgi.com id <S553866AbRADRfD>;
	Thu, 4 Jan 2001 09:35:03 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:25597 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553845AbRADRex>; Thu, 4 Jan 2001 09:34:53 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869731AbRADRZx>;
	Thu, 4 Jan 2001 15:25:53 -0200
Date:	Thu, 4 Jan 2001 15:25:53 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Jun Sun <jsun@mvista.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: missing data cache flush in trap_init?
Message-ID: <20010104152553.D2525@bacchus.dhis.org>
References: <3A5277C6.89170BAD@mvista.com> <20010103150535.B904@bacchus.dhis.org> <3A53ED5F.EC5E936F@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A53ED5F.EC5E936F@mvista.com>; from jsun@mvista.com on Wed, Jan 03, 2001 at 07:26:23PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 03, 2001 at 07:26:23PM -0800, Jun Sun wrote:

> Aside of that, the name of flush_icache_range() seems to be misleading.  Also
> in general how does it know which part of dcache to flush() without a given
> process mm struct?

The function is only intended to flush kernel addresses for which no mm
exists.  Yes, it's being abused in creative ways but that's the purpose
it was designed for ...

>  If it does not know, the only choice is to flush the whole
> dcache, which seems to make this function very close to flush_all().  
> 
> Is this function introduced by other CPU platforms?  How would it make a
> difference there?  I am just curious ...

Others such as for example m68k need it as well.

  Ralf
