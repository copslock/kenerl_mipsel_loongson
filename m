Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BGlVb10850
	for linux-mips-outgoing; Fri, 11 May 2001 09:47:31 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BGlTF10846
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 09:47:29 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f4BGl5U00904;
	Fri, 11 May 2001 18:47:05 +0200
Received: from gromit.moeb ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.14 #1)
	id 14yG21-0004C7-00; Fri, 11 May 2001 18:44:45 +0200
Received: by gromit.moeb (Postfix, from userid 207)
	id 55EB41EA2E; Fri, 11 May 2001 18:44:44 +0200 (CEST)
Mail-Copies-To: never
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: sjhill@cotw.com, libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: glibc MIPS patch to check for binutils version...
References: <Pine.GSO.3.96.1010511182140.23383A-100000@delta.ds2.pg.gda.pl>
From: Andreas Jaeger <aj@suse.de>
Date: 11 May 2001 18:44:44 +0200
In-Reply-To: <Pine.GSO.3.96.1010511182140.23383A-100000@delta.ds2.pg.gda.pl> ("Maciej W. Rozycki"'s message of "Fri, 11 May 2001 18:26:51 +0200 (MET DST)")
Message-ID: <u8r8xvrg1v.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Maciej W. Rozycki" <macro@ds2.pg.gda.pl> writes:

> On 11 May 2001, Andreas Jaeger wrote:
> 
> > 2001-05-11  Andreas Jaeger  <aj@suse.de>
> > 
> > 	* sysdeps/unix/sysv/linux/configure.in: Check binutils version on
> > 	MIPS.
> 
>  Wouldn't it be cleaner if the check was placed in
> sysdeps/unix/sysv/linux/mips/configure.in instead, like it's done for
> Alpha?

That would be better - I'll move it later,

Thanks,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
