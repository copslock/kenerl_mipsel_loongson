Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4G3U2nC012304
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 15 May 2002 20:30:02 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4G3U1B9012303
	for linux-mips-outgoing; Wed, 15 May 2002 20:30:01 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tibook.netx4.com (x1000-57.tellink.net [63.161.110.249])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4G3TvnC012293
	for <linux-mips@oss.sgi.com>; Wed, 15 May 2002 20:29:57 -0700
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id g4G3SIP00680;
	Wed, 15 May 2002 23:28:22 -0400
Message-ID: <3CE32752.80109@embeddededge.com>
Date: Wed, 15 May 2002 23:28:18 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Daniel Jacobowitz <dan@debian.org>, Matthew Dharm
 <mdharm@momenco.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com> <20020515214818.GA1991@nevyn.them.org> <3CE2DA46.3070402@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:

> So you really can't do 1.5GB on 32 bit kernel.
> 
> It is interesting that PPC allows one to adjust user space size and 
> kernel space size.  So on PPC you can get up to 2.5GB system RAM with 
> 1GB user space.

Don't be confusing virtual/physical addressing.  The highmem stuff allows
access to larger physical address space by providing "windows" through
the virtual space.  The memory space configuration on PPC was done before
highmem was working properly, but it has remained as an embedded configuration
option.  When using highmem, you obviously can't map all of the physical
memory at once, so your applications and drivers have to coordinate what
is mapped at a single instance.  The PPC configuration option gives us a
little flexibility to allow a little more kernel mapping for drivers when
it is necessary (or to work around weird I/O mapping problems).

Thanks.


	-- Dan
