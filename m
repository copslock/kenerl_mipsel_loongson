Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3AHqSS11623
	for linux-mips-outgoing; Tue, 10 Apr 2001 10:52:28 -0700
Received: from feynman.localnet (jtobey.ne.mediaone.net [24.147.19.222])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3AHqOM11619;
	Tue, 10 Apr 2001 10:52:24 -0700
Received: by ne.mediaone.net
	via sendmail from stdin
	id <m14n2T7-000FQ8C@feynman.localnet> (Debian Smail3.2.0.102)
	for ralf@oss.sgi.com; Tue, 10 Apr 2001 14:02:21 -0400 (EDT) 
Date: Tue, 10 Apr 2001 14:02:21 -0400
From: John Tobey <jtobey@john-edwin-tobey.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit on Cobalt?
Message-ID: <20010410140221.B9811@john-edwin-tobey.org>
References: <20010408184241.A3443@john-edwin-tobey.org> <20010409035453.B774@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010409035453.B774@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Apr 09, 2001 at 03:54:53AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 09, 2001 at 03:54:53AM +0200, Ralf Baechle wrote:
> 
> I admit it's interesting though, mostly for engineering reasons, not
> as a platform.
> 
> > I imagine that I would start by grafting Cobalt's peripheral support
> > code from arch/mips/cobalt (now defunct) and include/asm-mips/cobalt.h
> > into the mips64 tree from cvs@oss.sgi.com:/cvs/linux.
> 
> Somebody else was already working on upgrading the Cobalt kernel to 2.4.

Hey, thanks for the advice!  If anyone's interested, here's a mailing
list for porting recent kernels to Cobalt/MIPS:
http://devel.alal.com/mailman/listinfo/cobalt-22

Best.
-John
