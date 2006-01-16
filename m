Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 20:23:25 +0000 (GMT)
Received: from colo.lackof.org ([198.49.126.79]:45966 "EHLO colo.lackof.org")
	by ftp.linux-mips.org with ESMTP id S8133444AbWAPUXE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2006 20:23:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by colo.lackof.org (Postfix) with ESMTP id 3C2B636000E;
	Mon, 16 Jan 2006 13:35:50 -0700 (MST)
Received: from colo.lackof.org ([127.0.0.1])
	by localhost (colo.lackof.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26599-09; Mon, 16 Jan 2006 13:35:46 -0700 (MST)
Received: by colo.lackof.org (Postfix, from userid 27253)
	id BE6B4360001; Mon, 16 Jan 2006 13:35:46 -0700 (MST)
Date:	Mon, 16 Jan 2006 13:35:46 -0700
From:	Grant Grundler <grundler@parisc-linux.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-ID: <20060116203546.GA22635@colo.lackof.org>
References: <4393CD9F.3090305@jg555.com> <20051205114456.GA2728@linux-mips.org> <20060116160355.GB28383@deprecation.cyrius.com> <43CBC97E.3090800@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBC97E.3090800@jg555.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lackof.org
Return-Path: <grundler@lackof.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grundler@parisc-linux.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 16, 2006 at 08:27:42AM -0800, Jim Gifford wrote:
> Jeff Garzick refuses to apply it do to spinlocks.

Jeff refuses to apply the tulip phy init patch because it could
hold off interrupts for up to 2.5ms. I agree this is not a good
"side effect" of this patch. However, rewriting tulip initialization
sequence to avoid this "side effect" is non-trivial.
And in practice, the interrupts are held off only for 600us or so.

>  Andrew Morton is 
> including in his tree because it fixes issue with Parisc and with MIPS 
> based builds.

and ia64-linux.

>  So it's kinda of what is the right thing to do. I also use 
> this driver on my x86 builds, and it actually performs better. Here is a 
> little history of how Grant made the driver.
> 
> Grant Grundler is the network maintainer for Parisc Linux.
> He discovered that the tulip driver didn't perform that well.

No, with faster CPUs, tulip just didn't work on parisc-linux or ia64-linux.
Exact same symptom you had on the mips platform.

>  He 
> researched the manufactures documentation and found out how to fix the 
> driver to work to its optimum performance. He did this back in 2003, has 

Oct 2002 actually.
http://lists.parisc-linux.org/pipermail/parisc-linux-cvs/2002-October/031613.html

That was a first mostly correct version.
Here's the "final" patch (at the time):
http://lists.parisc-linux.org/pipermail/parisc-linux-cvs/2002-December/032081.html


> submitted it to Jeff Garzick several times with no response.

That's not fair to Jeff - as much as I think he's being juvenile
in this case. Jeff and I did exchange email. He's just trying "encourage"
me to rewrite the driver initialization sequence. Not interested.
I prefer to maintain this patch in parisc-linux source tree myself.


>  Around late 
> 2004, I started to do test builds on 64 bit on my RaQ2 and discovered 
> that the driver would not auto-negotiate transfer speeds. Talked to 
> numerous people, then someone put me in touch with Grant. I tested the 
> driver for about 2 weeks, ask Grant why it wasn't sent upstream, he told 
> me about the spinlock issue. I then contacted Andrew Morton, explained 
> everything as I am here, and he agreed it was needed and tried to get 
> Jeff to add it.

I happened to talk to Andrew about this at OLS2004 - just before you
showed up with the nice failure case on Mips:
	http://www.spinics.net/lists/linux-net/msg11267.html

And a second, similar patch that I had outstanding
at the same time:
	http://www.spinics.net/lists/linux-net/msg11268.html

>  Jeff sends back a one liner say doing to it's use of 
> spinlocks it's not accepted.

I didn't need a longer explanation - I understood his concern.

> That's the gory history.

Sorry - it's more gory than you thought. :)

cheers,
grant
