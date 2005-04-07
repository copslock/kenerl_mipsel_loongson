Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 19:27:36 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:34212 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225281AbVDGS1T>;
	Thu, 7 Apr 2005 19:27:19 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DJbin-0004cu-8k; Thu, 07 Apr 2005 14:27:17 -0400
Date:	Thu, 7 Apr 2005 14:27:17 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Brian Kuschak <bkuschak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdb backtrace with core files
Message-ID: <20050407182717.GA17686@nevyn.them.org>
References: <20050407182310.25258.qmail@web40910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407182310.25258.qmail@web40910.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 07, 2005 at 11:23:10AM -0700, Brian Kuschak wrote:
> No luck with latest CVS version (GNU gdb
> 6.3.0.20050407-cvs):

That looks like a 6.3 branch snapshot; I meant HEAD.

> (gdb) t
> [Current thread is 1 (process 362)]
> (gdb) bt
> #0  0x00000658 in ?? ()
> #1  0x00000658 in ?? ()
> (gdb) info registers
>           zero       at       v0       v1       a0    
>   a1       a2       a3
>  R0   00000000 2ab01970 00000000 00000338 00000000
> 00000000 00000000 00000db0
>             t0       t1       t2       t3       t4    
>   t5       t6       t7
>  R8   0dafd6e5 00000001 2abccfd4 2abc8034 00000001
> 2aac2948 00000001 2abe0ce4
>             s0       s1       s2       s3       s4    
>   s5       s6       s7
>  R16  00400f70 7fff7e74 00400ed0 00000001 00400c70
> 00000000 10010f80 00000000
>             t8       t9       k0       k1       gp    
>   sp       s8       ra
>  R24  00000263 2ad2c788 2af318b5 00000000 2af8dab0
> 7fff7bf0 7fff7bf0 2abe0ce4
>             sr       lo       hi      bad    cause    
>   pc
>       00800008 00108413 0001b4e9 800649b8 2ad2c7c8
> 00000658
>            fsr      fir
>       00000000 00000000
> (gdb)

Did your application really jump to 0x658 before it crashed?  Did it
really get a value in the shared library / mmap region into the cause
register?  Looks like your GDB and kernel don't agree on what a core
file looks like.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
