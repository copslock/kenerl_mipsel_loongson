Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 19:25:35 +0100 (BST)
Received: from mx1.wp.pl ([212.77.101.5]:62853 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025623AbZD1SZ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 19:25:29 +0100
Received: (wp-smtpd smtp.wp.pl 4994 invoked from network); 28 Apr 2009 20:25:04 +0200
Received: from abag138.neoplus.adsl.tpnet.pl (HELO [192.168.2.5]) (laurentp@[83.6.170.138])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-mips@linux-mips.org>; 28 Apr 2009 20:25:04 +0200
Message-ID: <49F749FE.8050808@wp.pl>
Date:	Tue, 28 Apr 2009 20:25:02 +0200
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.1.17) Gecko/20080829 SeaMonkey/1.1.12
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Linux on Linksys PSUS4?
References: <ecbbfeda0904280458s4bb2de2q6c629ed79a472adc@mail.gmail.com>	 <200904281501.37811.florian@openwrt.org> <ecbbfeda0904281012h33f3a572nbd11547d5964c19d@mail.gmail.com>
In-Reply-To: <ecbbfeda0904281012h33f3a572nbd11547d5964c19d@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000 [QZP0]                               
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

Użytkownik Andrew Wiley napisał:
> On Tue, Apr 28, 2009 at 8:01 AM, Florian Fainelli <florian@openwrt.org
> <mailto:florian@openwrt.org>> wrote:
>
>     Le Tuesday 28 April 2009 13:58:38 Andrew Wiley, vous avez écrit :
>     > I stumbled onto this website while doing some research on a Linksys
>     > printserver I retired a while back (the firmware kept crashing,
>     but I don't
>     > think it was a hardware problem), and I'm wondering if it would
>     be possible
>     > to install Linux on it. It has an ADM5120P, and the hardware
>     seems to be
>     > supported, but how would I go about installing anything? Is
>     there a serial
>     > port header that I need to use? Would using it equate to
>     soldering a serial
>     > port to it?
>
>     Soldering a seria port is not an option if you want to do
>     something serious
>     with it.
>
>
> Then how would it normally be done? I'm hoping to do this more for the
> experience than for the final product, if only because there's a
> chance that the reboot problem is hardware related, and the whole box
> is fairly useless right now.
>  
>
>
>
>     > Is it even feasible to have a linux system running on 1MB of
>     flash and 4 MB
>     > of RAM?
>
>     That's too small you would need at least 2MB Flash and 8MB RAM.
>
>
> Could 2MB hold a full kernel? If I can compile in the right USB
> drivers, I can put the rootfs on a flash drive in the USB port (this
> is a printserver, so it has one), right?
>
>
> Andrew Wiley
>
Look for "midge" distribution (midge.vlad.org.ua), especially forum.
Look for "Bifferos" posts, he has "squidge" Linux for 2MB USB print server.

W.P.
