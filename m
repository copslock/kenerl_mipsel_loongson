Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9JNwvO11145
	for linux-mips-outgoing; Fri, 19 Oct 2001 16:58:57 -0700
Received: from mail.ocs.com.au (mail.ocs.com.au [203.34.97.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9JNwrD11139
	for <linux-mips@oss.sgi.com>; Fri, 19 Oct 2001 16:58:54 -0700
Received: (qmail 17444 invoked from network); 19 Oct 2001 23:58:50 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 19 Oct 2001 23:58:50 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id 6F994300095; Sat, 20 Oct 2001 09:58:47 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 54BDE98; Sat, 20 Oct 2001 09:58:47 +1000 (EST)
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
Subject: Re: [Linux-mips-kernel]PATCH 
In-reply-to: Your message of "19 Oct 2001 11:13:49 MST."
             <1003515229.1184.27.camel@adsl.pacbell.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 20 Oct 2001 09:58:42 +1000
Message-ID: <26894.1003535922@ocs3.intra.ocs.com.au>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On 19 Oct 2001 11:13:49 -0700, 
Pete Popov <ppopov@mvista.com> wrote:
>On Fri, 2001-10-19 at 10:27, Geoffrey Espin wrote:
>> I see that PPC now has some of the silly utils where $(shell
>> objdump ...) in the Makefile would be a lot tighter.  
>
>Are you talking about the utils in boot/utils?  I suppose you can get
>rid of those and put everything in the makefile, but I'm not sure it
>would be cleaner.

FWIW, the entire kernel build system is being redesigned from scratch
for 2.5.  In particular all the boot loader stuff is being cleaned up
and standardized across architectures (as much as possible).

http://sourceforge.net/projects/kbuild

Keith Owens, kbuild maintainer (who will soon be bugging this list to
test MIPS specific kbuild 2.5 changes).
