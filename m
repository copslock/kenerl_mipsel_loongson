Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TJqknC027692
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 12:52:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TJqkaZ027691
	for linux-mips-outgoing; Wed, 29 May 2002 12:52:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TJqgnC027680
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 12:52:42 -0700
Received: from excalibur.cologne.de (pD9E40755.dip.t-dialin.net [217.228.7.85])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id VAA03106;
	Wed, 29 May 2002 21:53:52 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 17D9PP-0000Bg-00; Wed, 29 May 2002 21:46:59 +0200
Date: Wed, 29 May 2002 21:46:59 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: New platforms
Message-ID: <20020529214659.A256@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	Brian Murphy <brian@murphy.dk>, linux-mips <linux-mips@oss.sgi.com>
References: <3CF4AAAD.7070504@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CF4AAAD.7070504@murphy.dk>; from brian@murphy.dk on Wed, May 29, 2002 at 12:17:17PM +0200
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 29, 2002 at 12:17:17PM +0200, Brian Murphy wrote:

>     I have a port of linux-mips to the Lasat (later Eicon) platform(s) -
> based on vr4300, vr5000 and vr4120 chips. I would very much like
> to have the code incorporated in the CVS at OSS. How do I go
> about this?

Usually by splitting your patches into small chunks (one patch for
one feature) and submitting them to Ralf Baechle (ralf@gnu.org) and/or 
to this list.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
