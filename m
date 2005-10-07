Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 16:44:25 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:37391 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133556AbVJGPoI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 16:44:08 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j97Fi0nW023829;
	Fri, 7 Oct 2005 16:44:01 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j97Fi0MM023828;
	Fri, 7 Oct 2005 16:44:00 +0100
Date:	Fri, 7 Oct 2005 16:44:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kyle Unice <unixe@comcast.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cygwin Cross-compile of linux release
Message-ID: <20051007154400.GF2616@linux-mips.org>
References: <001901c5cb54$8dfc70f0$0400a8c0@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901c5cb54$8dfc70f0$0400a8c0@buzz>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 07, 2005 at 09:34:05AM -0600, Kyle Unice wrote:

> I checked out the source for mips linux and tried cross-compiling this on
> cygwin.  
> This is the result:
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/sumversion.o
> scripts/mod/sumversion.c: In function `md4_final_ascii':
> scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
> int ar
> g (arg 4)
> scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
> int ar
> g (arg 5)
> scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
> int ar
> g (arg 6)
> scripts/mod/sumversion.c:221: warning: unsigned int format, long unsigned
> int ar
> g (arg 7)
>   HOSTLD  scripts/mod/modpost
>   HOSTCC  scripts/kallsyms
> scripts/kallsyms.c: In function `compress_symbols':
> scripts/kallsyms.c:366: warning: implicit declaration of function `memmem'
> scripts/kallsyms.c:366: warning: assignment makes pointer from integer
> without a
>  cast
> scripts/kallsyms.c:385: warning: assignment makes pointer from integer
> without a
>  cast
> /cygdrive/c/DOCUME~1/KYLE~1.BUZ/LOCALS~1/Temp/ccLMGC3l.o:kallsyms.c:(.text+0
> x6cb
> ): undefined reference to `_memmem'
> /cygdrive/c/DOCUME~1/KYLE~1.BUZ/LOCALS~1/Temp/ccLMGC3l.o:kallsyms.c:(.text+0
> x72d
> ): undefined reference to `_memmem'

_memmem must be some symbol of the Cygwin libraries.

Honestly, get rid of Cygwin.  You'll be glad you did, the birds will
fly, the butterflies will be singing ...

  Ralf
