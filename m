Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5BJCeM25657
	for linux-mips-outgoing; Mon, 11 Jun 2001 12:12:40 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5BJCdV25646
	for <linux-mips@oss.sgi.com>; Mon, 11 Jun 2001 12:12:39 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2FC8B803; Mon, 11 Jun 2001 21:12:38 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 533AA42C5; Mon, 11 Jun 2001 21:12:51 +0200 (CEST)
Date: Mon, 11 Jun 2001 21:12:51 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010611211251.A5749@paradigm.rfc822.org>
References: <20010611000359.A25631@paradigm.rfc822.org> <10206.992231584@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <10206.992231584@ocs4.ocs-net>; from kaos@ocs.com.au on Mon, Jun 11, 2001 at 01:53:04PM +1000
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 11, 2001 at 01:53:04PM +1000, Keith Owens wrote:
> On Mon, 11 Jun 2001 00:03:59 +0200, 
> Florian Lohoff <flo@rfc822.org> wrote:
> >i just tried to boot an Indy of mine with the current cvs (from this
> >morning) and it crashes 
> >
> >ksymoops 2.4.1 on i686 2.2.18ext3.  Options used
> >Using defaults from ksymoops -t elf32-little -a unknown
> >Error (Oops_bfd_perror): scan_arch for specified architecture Success
> 
> I cannot help with the oops but your ksymoops run has problems.  When
> doing cross system oops debugging, you need to specify the target
> machine and architecture with the -t and -a flags.  Otherwise ksymoops 
> defaults to the current machine.  Adding -t and -a will fix the above
> error and decode the code: line.

Nope - it wont as it strictly uses the /usr/bin/objdump - You have to
set the environment var "KSYMOOPS_OBJDUMP"

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
