Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8L5RZb12453
	for linux-mips-outgoing; Thu, 20 Sep 2001 22:27:35 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8L5RVe12448
	for <linux-mips@oss.sgi.com>; Thu, 20 Sep 2001 22:27:31 -0700
Received: from excalibur.cologne.de (pD9E405CF.dip.t-dialin.net [217.228.5.207])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA01037;
	Fri, 21 Sep 2001 07:27:26 +0200 (MET DST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 15kIt5-0001cz-00; Fri, 21 Sep 2001 07:30:07 +0200
Date: Fri, 21 Sep 2001 07:30:07 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
Message-ID: <20010921073007.B618@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
References: <3BAA962D.C55F2239@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA962D.C55F2239@mvista.com>; from jsun@mvista.com on Thu, Sep 20, 2001 at 06:21:49PM -0700
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 20, 2001 at 06:21:49PM -0700, Jun Sun wrote:

> I have a small busybox userland that works fine with 2.4.2 kernel, but failed
> with the latest 2.4.8 kernel.  The symptom is that it is stuck at the
> following prompt:

[busybox waiting for keypress]

> A simple test shows the console is still working, i.e., pressing a key *does*
> generate an interrupt and ISR *does* read the correct char value.
> 
> I really cannot think of anything else that might make busybox stuck here. 
> Any clue?  Anybody else is using busybox with more recent kernels?

I have a smilar problem on my DECstation. Using 2.4.8 with the Debian
boot-floppies (based on busybox), the machine hangs when waiting for
the first keypress after the splash screen.
When booting 2.4.8 with my "normal" installation into single user mode,
I get a shell prompt, but cannot enter anything. I first thought of
a problem with the DECstation keyboard driver, but the same happens
on serial console. I have tested various kernel version with regard
to this - the last one working for me is 2.4.5.
When booting my "normal" installation with 2.4.8 into multiuser mode,
the machine crashes somewhere in the init scripts.

Is your box little or big endian?

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
