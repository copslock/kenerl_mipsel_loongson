Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAPIDds29534
	for linux-mips-outgoing; Sun, 25 Nov 2001 10:13:39 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAPIDZo29522
	for <linux-mips@oss.sgi.com>; Sun, 25 Nov 2001 10:13:35 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 1682qh-00048X-00; Sun, 25 Nov 2001 12:13:47 -0500
Date: Sun, 25 Nov 2001 12:13:47 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011125121347.A15890@nevyn.them.org>
References: <86048F07C015D311864100902760F1DD01B5E3DA@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E3DA@dlfw003a.dus.infineon.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Nov 22, 2001 at 06:13:46PM +0100, Andre.Messerschmidt@infineon.com wrote:
> > I regularly use gcc 3.0.1 to build the latest oss cvs kernels without
> > obvious incident.
> > 
> I am using a 2.4.2 Kernel from Montavista, which is not working with gcc
> 3.0.1.
> Maybe it would be wise to upgrade. Does anybody know if there are any
> problems using a MIPS 5Kc with the current kernel?

If you simply fix the one declaration it complains about (it involves
adding 'volatile' to one of the two declarations of xtime) then this
kernel actually will work under GCC 3.0.1.  We haven't QA'd it, but I
use it routinely for testing.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
