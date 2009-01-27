Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 19:44:39 +0000 (GMT)
Received: from 30.mail-out.ovh.net ([213.186.62.213]:2978 "HELO
	30.mail-out.ovh.net") by ftp.linux-mips.org with SMTP
	id S21103374AbZA0Toh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jan 2009 19:44:37 +0000
Received: (qmail 18603 invoked by uid 503); 27 Jan 2009 19:44:57 -0000
Received: from b9.ovh.net (HELO mail23.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 27 Jan 2009 19:44:57 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 27 Jan 2009 19:44:36 -0000
Received: from 11.156.90-79.rev.gaoland.net (HELO ?192.168.1.101?) (laurent%guerby.net@79.90.156.11)
  by ns0.ovh.net with SMTP; 27 Jan 2009 19:44:35 -0000
Subject: Re: IP35 Origin 300/3000 support?
From:	Laurent GUERBY <laurent@guerby.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	Debian MIPS <debian-mips@lists.debian.org>
In-Reply-To: <20090127185759.GA2234@linux-mips.org>
References: <1233078550.17541.573.camel@localhost>
	 <20090127185759.GA2234@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 27 Jan 2009 20:44:30 +0100
Message-Id: <1233085470.17541.610.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.2 
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7215329553932623538
X-Ovh-Remote: 79.90.156.11 (11.156.90-79.rev.gaoland.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
Return-Path: <laurent@guerby.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurent@guerby.net
Precedence: bulk
X-list: linux-mips

On Tue, 2009-01-27 at 18:57 +0000, Ralf Baechle wrote:
> On Tue, Jan 27, 2009 at 06:49:10PM +0100, Laurent GUERBY wrote:
> 
> > The wiki page:
> > 
> > http://www.linux-mips.org/wiki/IP35
> > 
> > states "IP35 is not yet supported by Linux. A port initially targeting
> > only the Origin 300 has been started".
> > 
> > The last edit of the wiki was in 2007, does anyone know if it is now
> > supported by Linux/Debian?
> 
> No; the page accurately reflects the status of kernel development where I
> stopped.
> 
> > Would access to hardware help?
> 
> Only to a limited degree - the project has currently not yet reached the
> stage where access to more hardware would really be useful.  But before
> somebody dumps the hardware I can be convinced to give it a good home :-)
> At some point having access to more configurations will be essential -
> dealing with different configurations on Origin class hardware is very
> complex.  My current hardware is a single module, Origin 300 with
> 4 R10000 CPUs.

For the compile farm project I manage I was proposed a donation of the
exact same hardware (Origin 300 with 4 cpus and 2GB RAM). I'll let
you know when I have more information.

BTW, in the SGI/MIPS family, do you know what is the most powerful
hardware currently supported (hardware not weighting near a ton, more
like a workstation or a few U)? Bootstraping GCC takes a while these
days :).

Thanks for your help,

Laurent
http://gcc.gnu.org/wiki/CompileFarm
