Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9ONEHR12051
	for linux-mips-outgoing; Wed, 24 Oct 2001 16:14:17 -0700
Received: from dea.linux-mips.net (a1as08-p163.stg.tli.de [195.252.188.163])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9ONECD12046
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 16:14:13 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9ONDHv30842;
	Thu, 25 Oct 2001 01:13:17 +0200
Date: Thu, 25 Oct 2001 01:13:17 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: pmanolov@Lnxw.COM, linux-mips@oss.sgi.com
Subject: Re: Malta probs
Message-ID: <20011025011317.B30792@dea.linux-mips.net>
References: <20011023224718.A6283@dea.linux-mips.net> <3BD5E193.BB41A907@lnxw.com> <20011024024308.A21460@dea.linux-mips.net> <20011024.220729.39150004.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011024.220729.39150004.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Wed, Oct 24, 2001 at 10:07:29PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 24, 2001 at 10:07:29PM +0900, Atsushi Nemoto wrote:

> ralf> just restructured in a way that allows adding of new CPU types
> ralf> and - even more important - get the code maintainable again.  As
> ralf> it is right now
> 
> In current CVS, All handle_xxx exception handler seems to be complied
> with ".set mips3".  Here is a patch.  I think this patch solves the
> problem reported by Petko.

Correct.  In addition there were also assembler options hardwired in
arch/mips/kernel/Makefile which never should have made it there.

  Ralf
