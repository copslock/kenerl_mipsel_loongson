Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5QDKHnC003602
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 26 Jun 2002 06:20:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5QDKHsB003601
	for linux-mips-outgoing; Wed, 26 Jun 2002 06:20:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5QDK9nC003598;
	Wed, 26 Jun 2002 06:20:10 -0700
Received: by gandalf.physik.uni-konstanz.de (Postfix, from userid 501)
	id 2E58A8D3B; Wed, 26 Jun 2002 15:23:33 +0200 (CEST)
Date: Wed, 26 Jun 2002 15:23:29 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
Message-ID: <20020626152327.D14373@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <20020623125811.GA24851@bogon.ms20.nix> <20020624101123.A15988@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020624101123.A15988@dea.linux-mips.net>; from ralf@oss.sgi.com on Mon, Jun 24, 2002 at 10:11:23AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 10:11:23AM +0200, Ralf Baechle wrote:
> On Sun, Jun 23, 2002 at 02:58:11PM +0200, Guido Guenther wrote:
> 
> > Hi,
> > I need the following to make head.S compile again for IP22 on the 
> > current linux_2_4 branch:
> 
> > Is there a reason why the "_LANGUAGE_ASSEMBLY" ifdefs were removed?
> > Mips64 still has these #ifdefs though.
> 
> The necessity for these was believed to be removed.  What are you trying
> to do when you run into this problem?
CVS bit me and messed up head.S which included pgtable.h instead of
pgtable-bits.h. Works fine now.
Thanks,
 -- Guido
