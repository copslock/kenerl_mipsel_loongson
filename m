Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TL8lnC029307
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 14:08:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TL8lcl029306
	for linux-mips-outgoing; Wed, 29 May 2002 14:08:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TL8inC029303
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 14:08:45 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4TL9xX01145;
	Wed, 29 May 2002 14:09:59 -0700
Date: Wed, 29 May 2002 14:09:59 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Justin Carlson <justinca@cs.cmu.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: __flush_cache_all() miscellany
Message-ID: <20020529140959.B888@dea.linux-mips.net>
References: <1022691053.7644.16.camel@ldt-sj3-022.sj.broadcom.com> <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1022700389.7644.155.camel@ldt-sj3-022.sj.broadcom.com>; from justinca@cs.cmu.edu on Wed, May 29, 2002 at 12:26:29PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 12:26:29PM -0700, Justin Carlson wrote:

> Here's a patch against cvs that does the rename.  Unless anyone has
> objections, Ralf, could  you apply this?
> 
> While doing this, I've noticed that the whole mips tree is horribly
> inconsistent in terms of the cache flushing syscalls (sys_cacheflush and
> sys_sysmips->CACHE_FLUSH).  

These are compacrapability syscalls inherited from Risc/OS and IRIX.  Even
gcc generated trampoline code expects to have these available.

  Ralf
