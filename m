Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4AMToq17301
	for linux-mips-outgoing; Thu, 10 May 2001 15:29:50 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4AMTmF17295
	for <linux-mips@oss.sgi.com>; Thu, 10 May 2001 15:29:48 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f4AJMLc04324;
	Thu, 10 May 2001 16:22:21 -0300
Date: Thu, 10 May 2001 16:22:21 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ryan Murray <rmurray@debian.org>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Binary compatibility break understood ?
Message-ID: <20010510162221.A1736@bacchus.dhis.org>
References: <20010505144708.A12575@paradigm.rfc822.org> <20010507163210.B2381@bacchus.dhis.org> <20010508202518.A13476@paradigm.rfc822.org> <20010508214313.A12528@bacchus.dhis.org> <20010509095955.A8392@sonycom.com> <20010509104635.D12267@paradigm.rfc822.org> <3AF934AE.38AB0089@cotw.com> <20010510110847.A2799@cyberhqz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510110847.A2799@cyberhqz.com>; from rmurray@debian.org on Thu, May 10, 2001 at 11:08:47AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 10, 2001 at 11:08:47AM -0700, Ryan Murray wrote:

> So, in summary:
> 	* all existing binaries do not need to be recompiled, and should
> 	  continue to work.  (shlibs included?)
> 	* all new binaries should use the new formats.
> 
> To get the new targets working correctly:
> 	* new binutils
> 	* new gcc built with new binutils (does the 2.95.4 branch have the
>         changes, or only 3.0?)
> 	* new libc built with new gcc
> 	* rebuild gcc with the new libc
> 
> Am I missing anything?

The latter three steps are not necessary.

  Ralf
