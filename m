Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE0IfN29965
	for linux-mips-outgoing; Tue, 13 Nov 2001 16:18:41 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAE0Ib029960
	for <linux-mips@oss.sgi.com>; Tue, 13 Nov 2001 16:18:37 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAE0IYN10837;
	Wed, 14 Nov 2001 11:18:34 +1100
Date: Wed, 14 Nov 2001 11:18:34 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: ld error " linking PIC files with non-PIC files "
Message-ID: <20011114111834.B10410@dea.linux-mips.net>
References: <20011026161259.54925.qmail@web11908.mail.yahoo.com> <20011113200948.75977.qmail@web11908.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113200948.75977.qmail@web11908.mail.yahoo.com>; from wgowcher@yahoo.com on Tue, Nov 13, 2001 at 12:09:48PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 13, 2001 at 12:09:48PM -0800, Wayne Gowcher wrote:

> I am trying to cross compile X using the redhat7.0
> distribution from the sgi mips site as my base. Most
> files compile OK, but they fail at the link stage with
> the following error :
> 
> linking PIC files with non-PIC files.
> 
> I created my cross-compile library files in
> /usr/mipsel-linux from the packages :
> glibc-2.2.2-1.mipsel.rpm &
> glibc-devel-2.2.2-1.mipsel.rpm
> are there other libraries I need ?
> 
> I found a reference on the web to a module called
> libc6-pic.o, I don't see this anywhere in my libraries
> is this what I need ?
> 
> Has anyone else seen this problem before and do they
> know how to fix it ?

Don't use non-pic code ever in userspace.  Actually it's very strange
that you hit this problem as gcc defaults to pic code so you should
try to find which of your object files or libraries are non-pic.

  Ralf
