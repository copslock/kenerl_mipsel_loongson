Received:  by oss.sgi.com id <S553800AbQJNMOA>;
	Sat, 14 Oct 2000 05:14:00 -0700
Received: from u-118.karlsruhe.ipdial.viaginterkom.de ([62.180.21.118]:47881
        "EHLO u-118.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553783AbQJNMNr>; Sat, 14 Oct 2000 05:13:47 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868830AbQJNEVA>;
        Sat, 14 Oct 2000 06:21:00 +0200
Date:   Sat, 14 Oct 2000 06:21:00 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Jun Sun <jsun@mvista.com>, linux-mips@fnet.fr,
        linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ...
Message-ID: <20001014062100.A4407@bacchus.dhis.org>
References: <39E7EB73.9206D0DB@mvista.com> <20001014055550.B3816@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001014055550.B3816@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Oct 14, 2000 at 05:55:50AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, Oct 14, 2000 at 05:55:50AM +0200, Ralf Baechle wrote:

> > 1. binutils
> > -----------
> > 
> > a) latest binutil cvs tree (v2.10) + debian patch
> > 
> > http://sourceware.cygnus.com/binutils/
> > ftp://ftp.rfc822.org/pub/local/debian-mips/patches/rel32-binutils.diff
> > 
> > b) Andreas Jaeger recommanded Ulf's patch against the CVS tree.  He
> > recommanded 
> > 
> > ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000420.diff.gz.  
> > 
> > But I only found the following file.
> > 
> > ftp://oss.sgi.com/pub/linux/mips/binutils/binutils-000424.diff.gz
> 
> The binutils paragraph is old new.  All of the required patches are now
> in binutils except one which I sent to Ulf yesterday.

So Ulf commited the patch into the binutils cvs.  Therefore no more
pending patches for binutils-current.

  Ralf
