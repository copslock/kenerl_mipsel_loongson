Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5M2VEnC013997
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 21 Jun 2002 19:31:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5M2VElw013996
	for linux-mips-outgoing; Fri, 21 Jun 2002 19:31:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5M2V8nC013993
	for <linux-mips@oss.sgi.com>; Fri, 21 Jun 2002 19:31:09 -0700
Received: from excalibur.cologne.de (p50850F61.dip.t-dialin.net [80.133.15.97])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id EAA09456;
	Sat, 22 Jun 2002 04:34:08 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 17Lall-0003Oh-00; Sat, 22 Jun 2002 04:36:57 +0200
Date: Sat, 22 Jun 2002 04:36:57 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: "Smith, Todd" <Todd.Smith@camc.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: DECstation
Message-ID: <20020622043657.B253@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	"Smith, Todd" <Todd.Smith@camc.org>, linux-mips@oss.sgi.com
References: <490E0430C3C72046ACF7F18B7CD76A2A568B98@KES.camcare.com> <Pine.GSO.3.96.1020621225833.2531B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020621225833.2531B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Jun 21, 2002 at 11:06:19PM +0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 21, 2002 at 11:06:19PM +0200, Maciej W. Rozycki wrote:
> On Fri, 21 Jun 2002, Smith, Todd wrote:
> 
> > I was curious about the DECstation 5000/133 and a graphical console.
> 
>  The system should be fine -- basically all I/O ASIC based systems should
> work, though not all devices have been supplied with drivers yet. 
> 
>  You should be able to use X11 with an XF86_FBDev Xserver on a PMAG-B (CX) 
> or a PMAGB-B (HX) display adapter (I wasn't able to try myself so far
> though).  For other display adapters, the answer is either "not yet" or
> "no way". 

Graphical console on PMAG-B and PMAGB-B works fine. 

X works in principle, too, i.e. you get graphical output and you can 
use the mouse (with the help of gpm's repeater mode), but the keyboard 
support within X is broken.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
