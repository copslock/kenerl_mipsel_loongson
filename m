Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 14:28:09 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:31507 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225214AbTFBN2H>;
	Mon, 2 Jun 2003 14:28:07 +0100
Received: (qmail 8304 invoked from network); 2 Jun 2003 13:27:56 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 2 Jun 2003 13:27:56 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id A989FD8F46; Mon,  2 Jun 2003 23:27:51 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id A6DB591336; Mon,  2 Jun 2003 23:27:51 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: ilya@theIlya.com
Cc: linux-mips@linux-mips.org
Subject: Re: Yet another fix 
In-reply-to: Your message of "Sun, 01 Jun 2003 21:57:00 MST."
             <20030602045700.GI3035@gateway.total-knowledge.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jun 2003 23:27:46 +1000
Message-ID: <5368.1054560466@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Sun, 1 Jun 2003 21:57:00 -0700, 
ilya@theIlya.com wrote:
>module_map is referenced in register_ioctl32_conversion in arch/mips64/ioctl32.c
>As far as I can see, it should simply be possible to replace module_map
>with vmalloc in there, but I am not sure, as I don't know how exactly
>ioctl translations work...

Not in 2.4.20 nor 2.4.21-rc6 from Marcelo, must be a mips local change.
I strongly suggest that you get rid of it, there is no good reason to
emulate the 32 bit module syscalls on a 64 bit machine.  modutils is
pure Linux and there is absolutely no justification for emulating 32
bit versions of modutils when the user can install the 64 bit version
of modutils instead.  32 bit emulation is a crutch to let binary only
programs work when you do not have the source to rebuild to 64 bit, by
definition we have the source to modutils.

IA64 and x86_64 make no attempt to emulate 32 bit modutils.  sparc64,
ppc64 and s390x all pass the data straight to the 64 bit kernel code,
they require the user space modutils to supply 64 bit data.  Emulation
is a waste of time.
