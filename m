Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KHOwEC003491
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 10:24:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KHOwTp003490
	for linux-mips-outgoing; Tue, 20 Aug 2002 10:24:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KHOqEC003481
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 10:24:52 -0700
Received: from excalibur.cologne.de (p50850BF8.dip.t-dialin.net [80.133.11.248])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id TAA06291
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 19:27:42 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.35 #1 (Debian))
	id 17hCmq-0000JV-00
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 19:27:24 +0200
Date: Tue, 20 Aug 2002 19:27:24 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: New binutils for kernel
Message-ID: <20020820172724.GA599@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20020819171238.A7457@linux-mips.org> <Pine.GSO.3.96.1020820161204.8700H-100000@delta.ds2.pg.gda.pl> <20020820162959.A26852@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020820162959.A26852@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Aug 20, 2002 at 04:29:59PM +0200, Ralf Baechle wrote:

[requiring binutils 2.13]]

> Yep.  It won't hurt most of us kernel hackers very much but in particular
> the distribution people may want to comment.

Well, I guess that covers me :-).

Debian Woody, the current stable Debian release (AFAIK the only full-blown
distribution for Linux/mips that targets at "normal users" and not only at
developers) ships with binutils 2.12.90.0.1. As the Debian policy requires
that no new program versions are to be introduced for the stable release,
Debian will not be able to switch to binutils 2.13 there. Bugfixes for
packages in the release are accepted, but not new upstream versions; so to
get any fixes in, they would need to be backported to binutils 2.12.

For the unstable distribution (currently binutils 2.12.90.0.15), switching
to binutils 2.13 should IMHO be possible in a reasonable timeframe, if it
does not break other things. Caveat: as Debian requires all 11 released
architectures to be in sync, any new version would have to work properly on
_all_ supported platforms. The decision about introducing a new version of a
package into Debian is taken by the package maintainer, so I am going to ask
him about his plans.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
