Received:  by oss.sgi.com id <S553857AbQJNXsA>;
	Sat, 14 Oct 2000 16:48:00 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:13836 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553854AbQJNXrp>;
	Sat, 14 Oct 2000 16:47:45 -0700
Received: (qmail 26259 invoked from network); 14 Oct 2000 23:47:39 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 14 Oct 2000 23:47:39 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: stable binutils, gcc, glibc ... 
In-reply-to: Your message of "Sat, 14 Oct 2000 18:12:57 +0200."
             <20001014181257.C6499@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sun, 15 Oct 2000 10:47:37 +1100
Message-ID: <29516.971567257@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sat, 14 Oct 2000 18:12:57 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>On Sat, Oct 14, 2000 at 12:11:39PM -0400, Jay Carlson wrote:
>> What's going to happen to glibc 2.0.6?  I suspect the embedded people are
>> going to be stuck using it until we figure out how to trim down the binary
>> size of 2.2.
>
>Which why I guess we still have to maintain it for a while or even come
>up with some alternative small libc.

Is there any reason that newlib is not being used for embedded systems?
That is what it was developed for.  There is some MIPS support in
newlib, I have no idea if it is complete but it would be better than
starting from scratch.  http://sources.redhat.com/newlib/
