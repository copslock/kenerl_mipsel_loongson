Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6K65LS19935
	for linux-mips-outgoing; Thu, 19 Jul 2001 23:05:21 -0700
Received: from mail.kdt.de (mail.kdt.de [195.8.224.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6K65JV19932
	for <linux-mips@oss.sgi.com>; Thu, 19 Jul 2001 23:05:20 -0700
Received: from arthur.inka.de (arthur.kdt.de [195.8.250.5])
	by mail.kdt.de (8.11.1/8.11.0) with ESMTP id f6K64tj29563;
	Fri, 20 Jul 2001 08:04:55 +0200
Received: from gromit.moeb ([192.168.27.3] ident=postfix)
	by arthur.inka.de with esmtp (Exim 3.30 #1)
	id 15NTP1-00012r-00; Fri, 20 Jul 2001 08:04:43 +0200
Received: by gromit.moeb (Postfix, from userid 207)
	id 258201EA2A; Fri, 20 Jul 2001 08:04:42 +0200 (CEST)
Mail-Copies-To: never
To: Daniel Jacobowitz <dan@debian.org>
Cc: Florian Lohoff <flo@rfc822.org>, libc-alpha@sources.redhat.com,
   Klaus Naumann <spock@mgnet.de>, Robert Einsle <robert@einsle.de>,
   linux-mips@oss.sgi.com
Subject: Re: Probs running ntp on an indy
References: <20010719192614.A22495@tuvok.allgaeu.org>
	<Pine.LNX.4.21.0107192223140.8136-100000@spock.mgnet.de>
	<20010719225137.B1599@paradigm.rfc822.org>
	<20010719142009.A26517@nevyn.them.org>
From: Andreas Jaeger <aj@suse.de>
Date: Fri, 20 Jul 2001 08:04:41 +0200
In-Reply-To: <20010719142009.A26517@nevyn.them.org> (Daniel Jacobowitz's
 message of "Thu, 19 Jul 2001 14:20:09 -0700")
Message-ID: <u8snfsb0g6.fsf@gromit.moeb>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz <dan@debian.org> writes:

> On Thu, Jul 19, 2001 at 10:51:37PM +0200, Florian Lohoff wrote:
>> On Thu, Jul 19, 2001 at 10:24:06PM +0200, Klaus Naumann wrote:
>> > I know the problem but no solution. I suspect that it's a
>> > problem of the poll function in Big Endian environments, because
>> > I can reproduce this on my Indigo2 and on an Ultra 1 as well.
>> 
>> I remember seeing a patch concerning this problem - Something with
>> rtsignals - But i cant seem to find it anymore.
> 
> That's probably this one.  I knew I'd let a patch slip.  Glibc folk, is
> this OK?  The siginfo struct is different on MIPS.

Yes, that's fine.

Thanks, I've committed it,
Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
