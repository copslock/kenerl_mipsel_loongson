Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2G6hVj25265
	for linux-mips-outgoing; Fri, 15 Mar 2002 22:43:31 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2G6hQ925258
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 22:43:27 -0800
Received: from hermes.excalibur.cologne.de (pec-41-158.tnt4.f.uunet.de [149.225.41.158])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA29645
	for <linux-mips@oss.sgi.com>; Sat, 16 Mar 2002 07:43:29 +0100 (MET)
Received: from karsten by hermes.excalibur.cologne.de with local (Exim 3.34 #1 (Debian))
	id 16lxrf-0000nE-00
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 20:59:47 +0100
Date: Fri, 15 Mar 2002 20:59:46 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: DECStation kernel boot failure
Message-ID: <20020315195946.GA3020@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20020315124723.GZ25044@lug-owl.de> <200203151324.OAA18816@sparta.research.kpn.com> <20020315134953.GB25044@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315134953.GB25044@lug-owl.de>
User-Agent: Mutt/1.3.27i
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Mar 15, 2002 at 02:49:54PM +0100, Jan-Benedict Glaw wrote:
> On Fri, 2002-03-15 14:24:30 +0100, Houten K.H.C. van (Karel) <vhouten@kpn.com>
> wrote in message <200203151324.OAA18816@sparta.research.kpn.com>:
[SNIP]
> > He uses my kernel image. I'm sure I've included the DECStation 5000
> > ethernet card, because the same image works OK on other DECStations.
> > I don't have access to a 5000/25 however.
> 
> ...but Linux doesn't recognize the NIC on this box. Karel, digging
> unto deep layers of my bad memory I can remember that some DECstations
> had a different NIC or different way to access it or so. I've got
> some different DECstations, but there's one which I cannot really
> use because of lacking support for the nic. The box was supported
> at some time (there at least exists some old hacked network driver
> for 2.1.53 or so), but I do no longer have access to the file (my
> laptop was stolen this week and the driver was in my TODO directory,
> not backup'ed:-(

That was the LANCE driver for the 5000/200, which is different from 
the driver for all the 5000/xx, /1xx, /240 and /260. The Maxine 
should work with the default declance.c from the CVS.

Regards,
Karsten
-- 
Gemaess Par. 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der
Nutzung und der Weitergabe meiner Daten zum Zwecke der Werbung sowie
der Markt- oder Meinungsforschung.
