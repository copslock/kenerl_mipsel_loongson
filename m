Received:  by oss.sgi.com id <S553812AbQKRNRp>;
	Sat, 18 Nov 2000 05:17:45 -0800
Received: from u-71.karlsruhe.ipdial.viaginterkom.de ([62.180.19.71]:1544 "EHLO
        u-71.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553804AbQKRNRn>; Sat, 18 Nov 2000 05:17:43 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870460AbQKRK7J>;
        Sat, 18 Nov 2000 11:59:09 +0100
Date:   Sat, 18 Nov 2000 11:59:09 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     rajesh.palani@philips.com
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: sysmips syscall
Message-ID: <20001118115909.D8672@bacchus.dhis.org>
References: <0056910008698539000002L192*@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <0056910008698539000002L192*@MHS>; from rajesh.palani@philips.com on Fri, Nov 17, 2000 at 07:28:50PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Nov 17, 2000 at 07:28:50PM -0600, rajesh.palani@philips.com wrote:

>    The following lines appear in the linuxthreads/sysdeps/mips/pt-machine.h file in version
> LinuxThreads 2.1.2:
> 
> TODO: This version makes use of MIPS ISA 2 features.  It won't
>    work on ISA 1.  These machines will have to take the overhead of
>    a sysmips(MIPS_ATOMIC_SET, ...) syscall which isn't implemented
>    yet correctly.  There is however a better solution for R3000
>    uniprocessor machines possible.
> 
> My questions are:
> 1.  Is the sysmips syscall implemented correctly yet?

Yes.

> 2.  What is the better solution for R3000 uniprocessor machines?

You can base a spinlock implementation on the fact that the register k0
will be left at a value != zero after any exception, also including context
switches.

Problem: this solution breaks silently on multiproessor systems.

> 3.  Does anyone have a patch for LinuxThreads that supports MIPS ISA 1?

glibc 2.2's pthread will do that out of the box.

  Ralf
