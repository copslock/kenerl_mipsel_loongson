Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f49ISBO03972
	for linux-mips-outgoing; Wed, 9 May 2001 11:28:11 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f49IS7F03962
	for <linux-mips@oss.sgi.com>; Wed, 9 May 2001 11:28:08 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f492eaL01318;
	Tue, 8 May 2001 23:40:36 -0300
Date: Tue, 8 May 2001 23:40:36 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Shay Deloya <shay@jungo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: insmod problems
Message-ID: <20010508234036.A1216@bacchus.dhis.org>
References: <01050619134301.01140@athena.home.krftech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01050619134301.01140@athena.home.krftech.com>; from shay@jungo.com on Sun, May 06, 2001 at 07:13:43PM +0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, May 06, 2001 at 07:13:43PM +0300, Shay Deloya wrote:

> I have an old problem came up again and the old solution aren't helping.
> I'm using busybox version 0.50 and with kernel 2.2 , and inserting 
> some modules ,especially those with DEBUG macroes e.g:
> #define DEBUG_HIGH(args...) {if (debug_level >= HIGH) printk(args);}
> causes the message :
> Relocation overflow of type 4 for
> 
> and insmod fails.
> 
> I'm compiling the modules with -mlong-calls and still getting this message.
> 
> Is it insmod knowen bugs that the relocation is done in bad way or 
> a linker/compiler bug. I'm using compiler: egcs ver 1.0.3a
> I'm checking this problem at the moment and looking for insmod bug.

You'll have to upgrade to very current binutils which for mips*-linux
targets default to elf32-trad{big,little}mips, not IRIX ELF format.  Also
it seems your modutils are a bit rotten, get the latest from ftp.kernel.org.

  Ralf
