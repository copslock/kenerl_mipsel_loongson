Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f54KT5Q01838
	for linux-mips-outgoing; Mon, 4 Jun 2001 13:29:05 -0700
Received: from dea.waldorf-gmbh.de (u-99-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.99])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f54KT1h01820
	for <linux-mips@oss.sgi.com>; Mon, 4 Jun 2001 13:29:02 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f54KSow27672;
	Mon, 4 Jun 2001 22:28:50 +0200
Date: Mon, 4 Jun 2001 22:28:50 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Native compile on the target using RedHat 6.1 rpms
Message-ID: <20010604222850.B22903@bacchus.dhis.org>
References: <200106012135.PAA16955@home.knm.org> <20010604174818.41079.qmail@web11904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010604174818.41079.qmail@web11904.mail.yahoo.com>; from wgowcher@yahoo.com on Mon, Jun 04, 2001 at 10:48:18AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 04, 2001 at 10:48:18AM -0700, Wayne Gowcher wrote:

> /usr/bin/ld: /tmp/cca003091.o: uses different e_flags
> (0x102) fields than previous modules (0x2)
> Bad value: failed to merge target specific data of
> file /tmp/cca003091.o
> collect2: ld returned 1 exit status
> make: *** [pointer] Error 1
> 
> When I compile the same program using the RedHat 5.1
> rpms / nfs the program compiles to completion OK.
> 
> Anybody seen this before ?
> Any ideas what I am doing wrong ? missed out ? 

This is a bug in certain binutils versions which gets triggered by
certain kernel configurations.  Upgrade to newer binutils.

   Ralf
