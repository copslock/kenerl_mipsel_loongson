Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2N0kaB15687
	for linux-mips-outgoing; Thu, 22 Mar 2001 16:46:36 -0800
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2N0kZM15684
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 16:46:35 -0800
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id B3068109CE; Thu, 22 Mar 2001 16:47:00 -0800 (PST)
Date: Thu, 22 Mar 2001 16:47:00 -0800
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Brady Brown <bbrown@ti.com>
Cc: SGI news group <linux-mips@oss.sgi.com>
Subject: Re: Tools miss-compile old kernel
Message-ID: <20010322164659.A6068@foobazco.org>
References: <3ABA8F3D.E24DF122@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABA8F3D.E24DF122@ti.com>; from bbrown@ti.com on Thu, Mar 22, 2001 at 04:48:13PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Mar 22, 2001 at 04:48:13PM -0700, Brady Brown wrote:

> Is this supposed to work, or are the new tools incompatible with
> older kernels?

That particular assembler is incompatible with sanity, older kernels,
newer kernels, and anything you expect to actually function properly.

> Looks like here the tools blow the lui/lw combination and also the eret. Any
> suggestions?

Upgrade to CVS binutils.  The one Maciej has on his site is apparently
broken.  If you want a toolchain that is known to work at least in
some cases, you can pull it from
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev/.  That is
the toolchain I use to build kernels -and- userland (yes, I know,
everyone says it can't be done, but...) and thus it Works For Me (TM).

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
"I should have crushed his marketing-addled skull with a fucking bat."
