Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 17:11:15 +0100 (CET)
Received: from nixon.xkey.com ([209.245.148.124]:60353 "HELO nixon.xkey.com")
	by linux-mips.org with SMTP id <S1122121AbSKNQLO>;
	Thu, 14 Nov 2002 17:11:14 +0100
Received: (qmail 12988 invoked from network); 14 Nov 2002 16:10:57 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 14 Nov 2002 16:10:57 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gAEGAhY03183
	for linux-mips@linux-mips.org; Thu, 14 Nov 2002 08:10:43 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Thu, 14 Nov 2002 08:10:43 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114081043.C2192@wumpus.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114041538.GB5986@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114041538.GB5986@gateway.total-knowledge.com>; from ilya@theIlya.com on Wed, Nov 13, 2002 at 08:15:38PM -0800
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

I saw that a long time ago. sys_socket and sys_socketcall seem
to be written just like all the other syscalls that return an int.

> see arch/mips64/kernel/linux32.c
> 
> On Wed, Nov 13, 2002 at 05:42:00PM -0800, Greg Lindahl wrote:
> > I have a 64-bit kernel and O32 userland.
> > 
> > I notice that arping gets confused because the syscall socket() is
> > returning 4183 instead of a reasonable value like 3... if strace()
> > isn't lying to me.
> > 
> > How do I debug this? The O32 userland calls through the socketcall()
> > syscall. It looks OK.
> > 
> > greg
> > 
> > 
> > 
