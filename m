Received:  by oss.sgi.com id <S42442AbQIFVNk>;
	Wed, 6 Sep 2000 14:13:40 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:24845 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42336AbQIFVNP>;
	Wed, 6 Sep 2000 14:13:15 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id OAA18333;
	Wed, 6 Sep 2000 14:12:49 -0700
Date:   Wed, 6 Sep 2000 14:12:49 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Guido Guenther <guido.guenther@gmx.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: latest glibc from cvs fails to build
Message-ID: <20000906141248.A18088@chem.unr.edu>
References: <20000906222133.A1052@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000906222133.A1052@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Wed, Sep 06, 2000 at 10:21:33PM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 06, 2000 at 10:21:33PM +0200, Guido Guenther wrote:

> when cross-building glibc from today's cvs with gcc 2.96 (20000828) I get
> the following error:
> dl-reloc.c:104:50: warning: pasting would not give a valid
> preprocessing token
> dl-reloc.c:112:50: warning: pasting would not give a valid
> preprocessing token
> In file included from dynamic-link.h:21,
>                  from dl-reloc.c:92:
> ../sysdeps/mips/dl-machine.h:542: too few arguments to function
> `_dl_lookup_versioned_symbol'
> ../sysdeps/mips/dl-machine.h:542: too few arguments to function
> `_dl_lookup_symbol'
> 
> Does this look familiar to anyone? Otherwise I'll take a look at it
> later this week.

This one's easy - dl_lookup_versioned_symbol and dl_lookup_symbol have
had an argument added at the end of the list. It's a true/false value
indicating whether the lookup is explicit (1) or implicit (0). The
changelog describes it a bit more. So if you add the argument - I used
0, for fun, to the end of the four such calls in dl-machine.h, it will
build.

Unfortunately, there's another problem that looks less easy to fix. In
the link phase later on, __syscall_getdents64 will be undefined. I am
uncertain what needs to be done to fix this (anyone?).

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
