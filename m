Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5H9aNA25763
	for linux-mips-outgoing; Sun, 17 Jun 2001 02:36:23 -0700
Received: from dea.waldorf-gmbh.de (u-13-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5H9aKZ25759
	for <linux-mips@oss.sgi.com>; Sun, 17 Jun 2001 02:36:20 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5H9a9f03309;
	Sun, 17 Jun 2001 11:36:09 +0200
Date: Sun, 17 Jun 2001 11:36:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Robert Rusek <robru@ruseks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: RedHat Test-7.0 Compiler problems.
Message-ID: <20010617113608.C3216@bacchus.dhis.org>
References: <000f01c0f68f$99019d70$6400a8c0@sohorob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000f01c0f68f$99019d70$6400a8c0@sohorob>; from robru@ruseks.com on Sat, Jun 16, 2001 at 11:10:16AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 16, 2001 at 11:10:16AM -0700, Robert Rusek wrote:

> Which rpm(s) contains the following files:
>  
> crti.o, crt1.o... etc...
>  
> I am trying to compile apache and it is telling me that the c
> pre-processer is not available.  Do the compilers work in test-7.0?

You'll find a great improvment if you install glibc-devel :-)

  Ralf
