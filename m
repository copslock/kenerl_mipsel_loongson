Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Mar 2009 13:38:09 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:52680 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20024249AbZC2MiC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 29 Mar 2009 13:38:02 +0100
Received: (qmail 23448 invoked from network); 29 Mar 2009 14:37:21 +0200
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil48.netpark.at with SMTP; 29 Mar 2009 14:37:21 +0200
Date:	Sun, 29 Mar 2009 14:38:02 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
Message-ID: <20090329143802.0a09baca@scarran.roarinelk.net>
In-Reply-To: <49CF5CE6.1070003@ru.mvista.com>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net>
	<49CF5CE6.1070003@ru.mvista.com>
Organization: Private
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Sergei,

> > Patch overview:
> >
> > #1: eliminate alchemy/common/platform.c.  Add platform device
> >     registration to all boards instead.
> >   
> 
>   I'm strongly voting against this, as it causes totally unneeded code 
> duplication. Please don't apply.

I know it seems like a lot of unecessary duplication.  My reasons for
doing this are

a) I want to get rid of the various cpu-type specific config symbols,
   (i.e. I want one kernel binary to run on 2 or more Alchemy boards
   with different cpu models.  There's no technical reason this
   shouldn't work.  The OHCI block for instance has different addresses
   on pre-Au1200 silicon; the easiest solution to that (for me) is
   to simply move device registration to the boards that need/want it.)

   (BTW, what do you think about this?  Please tell me now if I ever
    have a chance to get your approval on this, so I can stop wasting
    my and everybody else's time as soon as possible). 

b) the way it is now just seems wrong to me, probably comes from working
   on SH port where each board registers the devices it needs.  I know
   this is in no way a valid technical justification; but everytime I
   look at this file something tells me it is just wrong ;)

 
> >     I realize this is a lot of (needless) code duplication at first,
> >     but it seems a lot cleaner to me if each board registered the
> >     devices it needs/wants.
> >   
> 
>    No, it's certainly a step backwards. You could make the common code 
> more flexible by checking what devices are enabled and registering them 
> selectively


Please elaborate.  Shall I check for a config symbol or if bootloader
has enabled the peripherals?  The latter is IMO stupid since the
bootloader should only load an OS and not preemptively enable every
device which might some day be used just because the running OS doesn't
know what it wants...

	Manuel Lauss
