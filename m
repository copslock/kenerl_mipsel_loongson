Received:  by oss.sgi.com id <S553720AbQJXBi1>;
	Mon, 23 Oct 2000 18:38:27 -0700
Received: from u-50.karlsruhe.ipdial.viaginterkom.de ([62.180.19.50]:24068
        "EHLO u-50.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553686AbQJXBiG>; Mon, 23 Oct 2000 18:38:06 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870342AbQJXBhn>;
        Tue, 24 Oct 2000 03:37:43 +0200
Date:   Tue, 24 Oct 2000 03:37:43 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: pthread_create() gets BUS ERROR
Message-ID: <20001024033743.B2816@bacchus.dhis.org>
References: <39EF765A.EC787ED6@mvista.com> <20001020003946.E20887@bacchus.dhis.org> <39F4E4C2.A9570003@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39F4E4C2.A9570003@mvista.com>; from jsun@mvista.com on Mon, Oct 23, 2000 at 06:24:18PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 23, 2000 at 06:24:18PM -0700, Jun Sun wrote:

> Since Ralf has not posted his patch for glibc yet, I looked into the
> problem a little bit more.

If you'd be waiting just a few minutes longer I'd have announced it :-)

The srpm is currently uploading to oss.sgi.com:/pub/linux/mips/glibc/
srpms/glibc-2.0.6-7lm.src.rpm.  The file is 4682466 bytes long, so don't
start downloading before it's completly uploaded :-)

> It appears to be another toolchain related problem, instead of a glibc
> problem.
> 
> In linuxthread/pthread.c:pthread_initialize_manager(), it accesses a
> global variable __pthread_initial_thread_bos in pthread shared library. 
> Apparently the code finds out the address of the variable through some
> table (why is that?).  It looks like the offset for variable is off by
> 8.  Another ld problem?
> 
> I am using the "old but stable" toolchains, as I stated in an earlier
> email.:-9

This description somehow rings a bell.  I'll dig through my mailfolders
and will post if I find something.

  Ralf
