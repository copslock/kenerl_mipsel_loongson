Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 06:40:26 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44403
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225005AbULCGkV>; Fri, 3 Dec 2004 06:40:21 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Ca775-0007mH-00; Fri, 03 Dec 2004 07:40:19 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Ca773-0003bx-00; Fri, 03 Dec 2004 07:40:17 +0100
Date: Fri, 3 Dec 2004 07:40:17 +0100
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [Patch] make 2.4 compile with GCC-3.4.3...
Message-ID: <20041203064017.GE8714@rembrandt.csv.ica.uni-stuttgart.de>
References: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF4FA@avtrex-server.hq.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69397FFCADEFD94F8D5A0FC0FDBCBBDEF4FA@avtrex-server.hq.avtrex.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
[snip]
> -fno-unit-at-a-time prevents GCC from rearranging things in its output thus preventing
> the save_static_function() from being separated from its companion.  As far as I could tell
> only syscall.c and signal.c need this.

Ah, I missed that. It's probably better to use the same way as in 2.6,
that is, to add a jump at the end of save_static_function().

> noinline was not defined for me :( so I removed it.  It seems that in 2.6 it is
> just #defined to be nothing.  The alternative is to add:
>  
> #ifndef noinline
> #define noinline
> #endif
>  
> to compiler.h as is done in 2.6

Yes, that's the better idea. gcc-4.0 ff may need it.


Thiemo
