Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E4XbS29534
	for linux-mips-outgoing; Mon, 13 Aug 2001 21:33:37 -0700
Received: from mailo.vtcif.telstra.com.au (mailo.vtcif.telstra.com.au [202.12.144.17])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E4XVj29531;
	Mon, 13 Aug 2001 21:33:31 -0700
Received: (from uucp@localhost) by mailo.vtcif.telstra.com.au (8.8.2/8.6.9) id OAA11277; Tue, 14 Aug 2001 14:32:47 +1000 (EST)
Received: from maili.vtcif.telstra.com.au(202.12.142.17)
 via SMTP by mailo.vtcif.telstra.com.au, id smtpdABNES_; Tue Aug 14 14:31:43 2001
Received: (from uucp@localhost) by maili.vtcif.telstra.com.au (8.8.2/8.6.9) id OAA21873; Tue, 14 Aug 2001 14:31:42 +1000 (EST)
Received: from localhost(127.0.0.1), claiming to be "mail.cdn.telstra.com.au"
 via SMTP by localhost, id smtpdBQQGR_; Tue Aug 14 14:30:25 2001
Received: from ntmsg0028.corpmail.telstra.com.au (ntmsg0028.corpmail.telstra.com.au [192.168.174.24]) by mail.cdn.telstra.com.au (8.8.2/8.6.9) with ESMTP id OAA09918; Tue, 14 Aug 2001 14:30:25 +1000 (EST)
Received: by ntmsg0028.corpmail.telstra.com.au with Internet Mail Service (5.5.2653.19)
	id <Q7C2Z8YA>; Tue, 14 Aug 2001 14:26:25 +1000
Message-ID: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAD3@ntmsg0080.corpmail.telstra.com.au>
From: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
To: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>,
   Ralf Baechle
	 <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: RE: /usr/bin/file
Date: Tue, 14 Aug 2001 11:40:48 +1000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



where do I get "libtoolize"

Still trying to update everything.

binutils-2.9.5.0.37 seems ok. although runtest not found.( needs testsuite,
which needs DejaGnu from  ftp ://gcc.gnu.org/pub/gcc/infrastructure  BUT the
site is  currently down.

glibc-2.2.3 needs  gcc-3.0 it seems. (checking version of gcc...
egcs-2.91.66, bad ...*** Some critical program is missing or too old
)

gcc-3.0  needs rectification in [libgcc_s.so]  & [libgcc.a]  it seems (see
make error below!)


Any idea Anyone please.

###############################################################
bash-2.04# pwd
/gcc-3.0
bash-2.04#make 
...
...
/usr/local/mips-unknown-linux-gnu/bin/ld: bfd assertion fail
elf32-mips.c:8348
/usr/local/mips-unknown-linux-gnu/bin/ld: bfd assertion fail
elf32-mips.c:8348
/usr/local/mips-unknown-linux-gnu/bin/ld: bfd assertion fail
elf32-mips.c:8348
/usr/local/mips-unknown-linux-gnu/bin/ld: bfd assertion fail
elf32-mips.c:8348
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory `/gcc-3.0/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory `/gcc-3.0/gcc'
make: *** [all-gcc] Error 2
bash-2.04#
###############################################################

Any idea Anyone please.

Thanks 
Roger



> -----Original Message-----
> From:	Maciej W. Rozycki [SMTP:macro@ds2.pg.gda.pl]
> Sent:	Tuesday, 14 August 2001 2:28 am
> To:	Ralf Baechle
> Cc:	Salisbury, Roger; linux-mips@oss.sgi.com; linux-mips@fnet.fr
> Subject:	Re: /usr/bin/file
> 
> On Mon, 13 Aug 2001, Ralf Baechle wrote:
> 
> > >  It's worth to run `libtoolize -c -f' before building any
> libtool-based
> > > software. 
> > 
> > That results in build failures for a few rpms.  Many packages already do
> > that but unfortunately not all.
> 
>  Well, libtool is pretty self-contained, but you may try to regenerate
> scripts as well.  If that fails, too, the software needs to be fixed
> sooner or later.  Look at my packages for a number of updates in this
> area.
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
