Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3JKeYS24754
	for linux-mips-outgoing; Thu, 19 Apr 2001 13:40:34 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3JKeWM24751
	for <linux-mips@oss.sgi.com>; Thu, 19 Apr 2001 13:40:32 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14qLE7-0002qF-00; Thu, 19 Apr 2001 22:40:31 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14qLE7-0005Ab-00; Thu, 19 Apr 2001 22:40:31 +0200
Date: Thu, 19 Apr 2001 22:40:30 +0200
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Subject: Re: Passing kernel args
Message-ID: <20010419224030.A19856@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <Pine.LNX.4.10.10104192059310.894-100000@tardis.home.dave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104192059310.894-100000@tardis.home.dave>; from gilbertd@treblig.org on Thu, Apr 19, 2001 at 09:00:48PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Apr 19, 2001 at 09:00:48PM +0100, Dave Gilbert wrote:
> Hi,
>   With help from some of the guys on the #mipslinux IRC channel I've
> managed to force a Linux kernel onto my Indy's internal disc.
> 
> One problem is that I'd like to pass some parameters to it, but it is not
> obvious to me which prom environment variable to put them in - any
> suggestions???
OSLoadOptions
See 
http://honk.physik.uni-konstanz.de/linux-mips/indy-boot/indy-hd-boot-micro-howto.html
(at the bottom) for an example.
 -- Guido
