Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4BECIc05987
	for linux-mips-outgoing; Fri, 11 May 2001 07:12:18 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4BECIF05984
	for <linux-mips@oss.sgi.com>; Fri, 11 May 2001 07:12:18 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id JAA03907;
	Fri, 11 May 2001 09:05:06 -0500
Message-ID: <3AFBF4A7.20F3D739@cotw.com>
Date: Fri, 11 May 2001 09:18:15 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre17-idepci i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Jaeger <aj@suse.de>
CC: libc-alpha@sources.redhat.com, linux-mips@oss.sgi.com
Subject: Re: glibc MIPS patch to check for binutils version...
References: <3AFBD5DE.A0457C6F@cotw.com> <u8wv7ohw42.fsf@gromit.rhein-neckar.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andreas Jaeger wrote:
> 
> >         * configure.in: added in checking for obsolete binutils
> >         for MIPS targets which produces a warning message if
> >         user attempts to use older tools.
> > ***************************
> 
> Let's do this differently.  I'm appending a patch that does it more
> the "glibc way".  I've committed everything to CVS including a patch
> for the FAQ.  I hope I got the version numbers right.
> 
Oh sure...my patch wasn't good enough :). I checked your addition to
the FAQ and it is correct. Thanks a lot Andreas. Cheers.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
