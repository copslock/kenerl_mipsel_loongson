Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2R7fGS29829
	for linux-mips-outgoing; Tue, 26 Mar 2002 23:41:16 -0800
Received: from indy (hlubocky.del.cz [212.27.221.67])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2R7fAq29823
	for <linux-mips@oss.sgi.com>; Tue, 26 Mar 2002 23:41:11 -0800
Received: from ladis by indy with local (Exim 3.35 #1 (Debian))
	id 16q85d-0000CB-00; Wed, 27 Mar 2002 08:43:25 +0100
Date: Wed, 27 Mar 2002 08:43:24 +0100
To: blaine <lattice@altern.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Parallel Port support on Indy?
Message-ID: <20020327074324.GB645@indy>
References: <Pine.LNX.4.44.0203261847100.7969-100000@zoetrope>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203261847100.7969-100000@zoetrope>
User-Agent: Mutt/1.3.27i
From: Ladislav Michl <ladis@psi.cz>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Mar 26, 2002 at 06:56:54PM -0800, blaine wrote:
> Hi there;
hi,
>   I've recently acquired an Indy, and I'd like to use it as my closet
> firewall/webserver/printer box. I've been able to install debian/woody
> without event, and the linux_2_4 tag from sgi's cvs compiles fine,
> giving me OSS sound support with the HAL2 and enabling the Vino video
enabling the Vino video does currently nothing.
> system. X came working out of the box...
> 
> The only thing I *can't* do with the Indy is use the parallel port,
no support for it.
> which, in my case, is the most important thing... As far as I can tell
> from reading around, the Indy supports a standard SPP parallel port
SPP, SGIPP (SGI parallel port), HPBPP (HP BOISE high speed parallel
port) and Ricoh scanner mode. there are two modes of operation -
register and DMA.
> (plus a bunch of extra modes that haven't been implemented in linux,
> afaict), but has a different base i/o address in addition to having the
all IP22 peripherals are memory maped.
> data and control addresses at different offsets. I tried playing around
> with the constants in [header file that controls that stuff in
> include/linux], and managed to get the parport_pc module to stop causing
> a [non-fatal] kernel oops. Now it just says something is wrong. ;-)
aieee :-) Indy's PP is based on PI1 chip developed by SGI, so the only
way to get it work is write something like parport_sgi... patches
welcome :-)
> I would like to pursue fixing this, but being a student and not having
> any experience playing with low-level hardware or kernel hacking are
> conspiring against me. 
when i bring Indy to home i was in the same situation :-)
> Is getting parport support on the Indy a major undertaking, or are 
> there just a few tweaks that need to be made to existing drivers?
unfortunately you have to write your own driver.

	ladis
