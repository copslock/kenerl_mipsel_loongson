Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g040jk407015
	for linux-mips-outgoing; Thu, 3 Jan 2002 16:45:46 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g040jig07012
	for <linux-mips@oss.sgi.com>; Thu, 3 Jan 2002 16:45:44 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 16MHYL-0001Vd-00; Fri, 04 Jan 2002 00:45:41 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16MHX7-0000PS-00; Fri, 04 Jan 2002 00:44:25 +0100
Date: Fri, 4 Jan 2002 00:44:25 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: Newport Xserver 2001-11-21
Message-ID: <20020104004425.B1519@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <200201031852.TAA01081@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201031852.TAA01081@sparta.research.kpn.com>; from vhouten@kpn.com on Thu, Jan 03, 2002 at 07:52:13PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jan 03, 2002 at 07:52:13PM +0100, Houten K.H.C. van (Karel) wrote:
> 
> Hi Guido,
> 
> I'm experimenting with your Xserver for my indy, currently running
> the 2.4.16 kernel. I've used a local compiled Xserver before, but that
> was with an older kernel. Now, using 2.4.16 and your Xserver, I get the
> following errors:
Which 2.4.16? The one in the debian archive works. The X-Server
parses /proc/cpuinfo to check if it runs on an Indy(yes, thats ugly)
since we still have now proper GIO64 bus interface. Ralf recently
changed some things in /proc/cpuinfo that broke this parsing. He
reverted these changes later, so current oss cvs kernels should provide
the necessary information in /proc/cpuinfo again.
 -- Guido
