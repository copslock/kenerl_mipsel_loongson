Received:  by oss.sgi.com id <S553736AbRBUMbe>;
	Wed, 21 Feb 2001 04:31:34 -0800
Received: from u-18-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.18]:30960
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553648AbRBUMbL>; Wed, 21 Feb 2001 04:31:11 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1L7COU07832;
	Wed, 21 Feb 2001 08:12:24 +0100
Date:   Wed, 21 Feb 2001 08:12:24 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     David Jez <dave.jez@seznam.cz>, ppopov@pacbell.net,
        linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
Message-ID: <20010221081224.A7767@bacchus.dhis.org>
References: <3A901B3F.ADADC601@pacbell.net> <20010220074903.A68652@stud.fee.vutbr.cz> <20010220215616.F2086@bacchus.dhis.org> <3A930AB3.3AEAE5BF@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A930AB3.3AEAE5BF@mvista.com>; from ppopov@mvista.com on Tue, Feb 20, 2001 at 04:24:19PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Feb 20, 2001 at 04:24:19PM -0800, Pete Popov wrote:

> > Oss has a tarball with statically linked rpm 4 binaries.  Use that to
> > convert your rpm database and then install the rpm 4 rpm package for real.
> 
> I tried that; "rpm --rebuilddb" failed because it couldn't find some
> library.  I'll try again.

Hmm...  I know I went through the procedure when I upgraded posix0 from
5.1 to 7.0, so it's definately to get to work even though it definately
was hairy beyond Joe Average Sysadmin's skills.  Maybe you'll also have to
dump a copy of glibc into the to-be updates system or use the --root
option.  Somebody will have to figure out a reasonably easy to follow
and safe procedure here.

  Ralf
