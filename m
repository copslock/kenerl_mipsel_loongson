Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E90n303567
	for linux-mips-outgoing; Tue, 14 Aug 2001 02:00:49 -0700
Received: from dea.waldorf-gmbh.de (u-198-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E90fj03560
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 02:00:42 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E8Orm06319;
	Tue, 14 Aug 2001 10:24:53 +0200
Date: Tue, 14 Aug 2001 10:24:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: SysV IPC shared memory and virtual alising
Message-ID: <20010814102452.E5928@bacchus.dhis.org>
References: <20010806164452D.nemoto@toshiba-tops.co.jp> <15214.23110.345236.934305@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15214.23110.345236.934305@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Mon, Aug 06, 2001 at 09:50:14AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 09:50:14AM +0100, Dominic Sweetman wrote:

> > Here is an patch to fix virtual aliasing problem with SysV IPC
> > shared memory.  I tested this patch on a r4k cpu with 32Kb D-cache.
> > 
> > If D-cache is smaller than PAGE_SIZE this patch is not needed at
> > all...
> 
> More precisely, if the size of a D-cache "set" is smaller than
> PAGE_SIZE.  So a CPU with a 16Kbyte 4-way set-associative cache and
> 4Kbyte PAGE_SIZE is safe.

Or is physically indexed and physically tagged or magically deals with
aliasing such as R4000 / R4400 SC and MC versions or R10000, R12000 or
R14000.

  Ralf
