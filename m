Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E7GxB00918
	for linux-mips-outgoing; Tue, 14 Aug 2001 00:16:59 -0700
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E7Gsj00906;
	Tue, 14 Aug 2001 00:16:54 -0700
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 353AF1E225; Tue, 14 Aug 2001 09:16:48 +0200 (MEST)
X-Authentication-Warning: gee.suse.de: aj set sender to aj@suse.de using -f
Mail-Copies-To: never
To: "Salisbury, Roger" <Roger.Salisbury@team.telstra.com>
Cc: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>,
   Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: /usr/bin/file
References: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAD3@ntmsg0080.corpmail.telstra.com.au>
From: Andreas Jaeger <aj@suse.de>
Date: Tue, 14 Aug 2001 09:16:36 +0200
In-Reply-To: <C1CCF0351229D311BBEB0008C75B9A8A02CAFAD3@ntmsg0080.corpmail.telstra.com.au>
 ("Salisbury, Roger"'s message of "Tue, 14 Aug 2001 11:40:48 +1000")
Message-ID: <ho8zgn9kmj.fsf@gee.suse.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Salisbury, Roger" <Roger.Salisbury@team.telstra.com> writes:

> where do I get "libtoolize"
>
> Still trying to update everything.
>
> binutils-2.9.5.0.37 seems ok. although runtest not found.( needs testsuite,
> which needs DejaGnu from  ftp ://gcc.gnu.org/pub/gcc/infrastructure  BUT the
> site is  currently down.

> glibc-2.2.3 needs  gcc-3.0 it seems. (checking version of gcc...
> egcs-2.91.66, bad ...*** Some critical program is missing or too old
> )
>
> gcc-3.0  needs rectification in [libgcc_s.so]  & [libgcc.a]  it seems (see
> make error below!)

GCC 3.0 will not compile a correct glibc at all, wait for GCC 3.0.1
and glibc 2.2.5 and read the glibc announcements,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
