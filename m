Received:  by oss.sgi.com id <S553669AbQJSLkN>;
	Thu, 19 Oct 2000 04:40:13 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:21765 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553678AbQJSLjm>;
	Thu, 19 Oct 2000 04:39:42 -0700
Received: (qmail 3157 invoked from network); 19 Oct 2000 11:39:36 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 19 Oct 2000 11:39:36 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Guido Guenther <guido.guenther@gmx.net>
cc:     Ralf Baechle <ralf@oss.sgi.com>, ian@ichilton.co.uk,
        linux-mips@oss.sgi.com
Subject: Re: CVS GCC Problem 
In-reply-to: Your message of "Thu, 19 Oct 2000 13:28:45 +0200."
             <20001019132845.A27629@bilbo.physik.uni-konstanz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 19 Oct 2000 22:39:34 +1100
Message-ID: <16535.971955574@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, 19 Oct 2000 13:28:45 +0200, 
Guido Guenther <guido.guenther@gmx.net> wrote:
>On Mon, Oct 16, 2000 at 03:00:53AM +0200, Ralf Baechle wrote:
>> On Sat, Oct 14, 2000 at 09:18:50PM +0200, Guido Guenther wrote:
>> 
>> > On Sat, Oct 14, 2000 at 12:58:55PM +0100, Ian Chilton wrote:
>> > > /crossdev/mips-linux/bin/ld: cannot open crti.o: No such file or directory
>> > I see the same thing here. gcc from cvs 000925 seems to be o.k. 
>> 
>> The file crti.o should be in /crossdev/mips-linux/lib/crti.o.  Is it actually
>> there?  Can you checkout where the x-compiler is actually searching
>> for those files?
>It's not there, it seems like binutils(cvs 001013 + rel32 patch) 
>don't build/install it. xgcc searches in:

Data point.  Same problem (no crti.o) with bleeding edge gcc and
binutils, cross compile ix86 to ia64, using a home grown cross compile
script.  Configuring gcc with --disable-shared avoids the problem, at
the expense of not building a shared libgcc.
