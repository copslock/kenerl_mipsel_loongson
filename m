Received:  by oss.sgi.com id <S553815AbQJ1Byg>;
	Fri, 27 Oct 2000 18:54:36 -0700
Received: from ppp0.ocs.com.au ([203.34.97.3]:28175 "HELO mail.ocs.com.au")
	by oss.sgi.com with SMTP id <S553792AbQJ1ByY>;
	Fri, 27 Oct 2000 18:54:24 -0700
Received: (qmail 16693 invoked from network); 28 Oct 2000 01:54:19 -0000
Received: from ocs3.ocs-net (192.168.255.3)
  by mail.ocs.com.au with SMTP; 28 Oct 2000 01:54:18 -0000
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Steve Kranz <skranz@ridgerun.com>
cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: remote GDB debugging and the __init macro of init.h 
In-reply-to: Your message of "Fri, 27 Oct 2000 09:24:17 MDT."
             <39F99E20.8EE47072@ridgerun.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 28 Oct 2000 12:54:18 +1100
Message-ID: <4909.972698058@ocs3.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, 27 Oct 2000 09:24:17 -0600, 
Steve Kranz <skranz@ridgerun.com> wrote:
>  I had to make a change to allow remote MIPS kernel
>  debugging (GDB). The change I found necessary was in the
>  file:
>
>    include/linux/init.h     (2.4.0-test9)
>
>  As you can see from the snippet below the change
>  involves conditionally defining the "__init" macro as
>  a function of whether remote debugging is enabled or
>  not. Am I missing something, or does this seem like a
>  reasonable change?

It would be better to teach kgdb that the kernel has symbols in
sections other than .text.  Even with your patch, you do not get all
the symbols, there is also code in sections .setup.init, .initcall.init
and .exitcall.exit, with similar sections for data.  You cannot remove
.initcall.init without destroying the kernel initialization procedure.

Recent versions of kgdb for ix86 use a modified version of gdb that
knows about multiple sections for modules.  I do not know if they have
the same functionality for the kernel.
