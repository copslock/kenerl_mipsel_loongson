Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f48Jov528096
	for linux-mips-outgoing; Tue, 8 May 2001 12:50:57 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f48JotF28092
	for <linux-mips@oss.sgi.com>; Tue, 8 May 2001 12:50:56 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f48JmkC01844;
	Tue, 8 May 2001 16:48:46 -0300
Date: Tue, 8 May 2001 16:48:46 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: machine types for MIPS in ELF file
Message-ID: <20010508164846.A1471@bacchus.dhis.org>
References: <3AF843F7.72BC47F0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF843F7.72BC47F0@mvista.com>; from jsun@mvista.com on Tue, May 08, 2001 at 12:07:35PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 08, 2001 at 12:07:35PM -0700, Jun Sun wrote:

> The e_machine field in ELF file standard defines two values for MIPS:
> 
> 8	- MIPS RS3000 BE
> 10	- MIPS RS4000 BE
> 
> Naturally the question is: what about LE binaries?  And what about other
> CPUs?  Is there any effort to clean up this thing?
> 
> All the tools that I know of are using 8, pretty much for all CPUs and both
> endians.  No real harm has been observed, but it causes some anonying "invalid
> byte order" complains if you do "file" on a MIPS LE binary.  Of course, it
> will also invariably reports "R3000" cpu as well.

EM_MIPS_RS4_BE was apparently only in use for a short time; EM_MIPS is
being used for both byte order.  The byteorder is nowadays identified by
EI_DATA.

  Ralf
