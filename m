Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7D4ppi29143
	for linux-mips-outgoing; Sun, 12 Aug 2001 21:51:51 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7D4poj29140
	for <linux-mips@oss.sgi.com>; Sun, 12 Aug 2001 21:51:50 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 3AF673E90; Sun, 12 Aug 2001 21:39:43 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id F24E713FD0; Sun, 12 Aug 2001 21:46:15 -0700 (PDT)
Date: Sun, 12 Aug 2001 21:46:15 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Mark Nellemann <mark@nellemann.nu>
Cc: linux-mips mail list <linux-mips@oss.sgi.com>
Subject: Re: Is it possible to boot linux on an O2 r5k ?
Message-ID: <20010812214615.B24560@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B73A5D0.1050202@nellemann.nu>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Aug 10, 2001 at 11:13:52AM +0200, Mark Nellemann wrote:

> I was told on irc a month ago, that someone had gotten an O2 to boot.

You were not lied to.  http://foobazco.org/~wesolows/o2.txt

> Yesterday I tried to fire up my O2. The whole bootp, tftp setup was working 
> fine, but when I boot'ed the kernel (linux-2.4.3-ip22) the kernel said "Yee, 
> could not determine architecture type <SGI-IP32>". Is this because i'm using a 
> wrong kernel or isn't it possible to boot the O2 yet ?

Certainly not with that kernel.  You need a modified kernel that
understands O2 (and a 64-bit kernel toolchain to build it).

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
