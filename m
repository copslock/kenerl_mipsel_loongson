Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CLb2531149
	for linux-mips-outgoing; Fri, 12 Oct 2001 14:37:02 -0700
Received: from dea.linux-mips.net (a1as05-p89.stg.tli.de [195.252.187.89])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CLavD31146
	for <linux-mips@oss.sgi.com>; Fri, 12 Oct 2001 14:36:58 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9CLZxq02064;
	Fri, 12 Oct 2001 23:35:59 +0200
Date: Fri, 12 Oct 2001 23:35:59 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: Jun Sun <jsun@mvista.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
Message-ID: <20011012233559.A1799@dea.linux-mips.net>
References: <Pine.GSO.4.21.0110121350300.20566-100000@mullein.sonytel.be> <3BC72BE8.F50C2001@mvista.com> <3BC732C9.9080508@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BC732C9.9080508@esstech.com>; from gerald.champagne@esstech.com on Fri, Oct 12, 2001 at 01:13:29PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Oct 12, 2001 at 01:13:29PM -0500, Gerald Champagne wrote:

> Can you wrap this code into small functions like machine_detect() and
> board_setup() and put it all in one place?  That way those of us who
> just want a simple system supporting only one board can just replace
> those two functions with defines that alias the proper machine_detect
> and board_setup fuctions.  Then all of the special elf sections and
> function pointers go away.
> 
> If it's all in one place like this, then maybe it could be configured
> in the config.in file.  I can ifdef it out for boards like mine or other
> boards that can't possibly support more than one system in a given binary
> image.  config.in could ifdef it in for configurations that could possibly
> support more than one configuration in a given binary image.

That would all be initcode / initdata so effective bloat zero.

  Ralf
