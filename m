Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g16Mmts01883
	for linux-mips-outgoing; Wed, 6 Feb 2002 14:48:55 -0800
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g16MmoA01879
	for <linux-mips@oss.sgi.com>; Wed, 6 Feb 2002 14:48:50 -0800
Received: from Hermes.suse.de (Hermes.suse.de [213.95.15.136])
	by Cantor.suse.de (Postfix) with ESMTP
	id 8F3571EC9F; Wed,  6 Feb 2002 23:48:44 +0100 (MET)
Received: from aj by arthur.inka.de with local (Exim 3.34 #1)
	id 16Yarr-0001Wy-00; Wed, 06 Feb 2002 23:48:43 +0100
Mail-Copies-To: never
To: "H . J . Lu" <hjl@lucon.org>
Cc: GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: PATCH: Fix <ldsodefs.h> for Linux/mips
References: <20020206133113.A29718@lucon.org>
From: Andreas Jaeger <aj@suse.de>
Date: Wed, 06 Feb 2002 23:48:42 +0100
In-Reply-To: <20020206133113.A29718@lucon.org> ("H . J . Lu"'s message of
 "Wed, 6 Feb 2002 13:31:13 -0800")
Message-ID: <u8r8nyxm45.fsf@gromit.moeb>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Thanks, I've committed this,

Andreas

"H . J . Lu" <hjl@lucon.org> writes:

> We have been using the wrong <ldsodefs.h> for Linux/mips. Here is a
> patch.
>
>
> H.J.
> ----
> 2002-02-06  H.J. Lu  <hjl@gnu.org>
>
> 	* sysdeps/mips/elf/ldsodefs.h: Make sure the right <ldsodefs.h>
> 	is included.
>
> --- sysdeps/mips/elf/ldsodefs.h.mips	Sat Jul  7 16:46:05 2001
> +++ sysdeps/mips/elf/ldsodefs.h	Wed Feb  6 13:25:17 2002
> @@ -22,4 +22,4 @@
>  
>  #define DL_RO_DYN_SECTION 1
>  
> -#include <sysdeps/generic/ldsodefs.h>
> +#include_next <ldsodefs.h>
>

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
