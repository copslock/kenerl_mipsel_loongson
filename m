Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR7Bhj08320
	for linux-mips-outgoing; Mon, 26 Nov 2001 23:11:43 -0800
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR7Bco08317
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 23:11:38 -0800
Received: from excalibur.cologne.de (pD95117A9.dip.t-dialin.net [217.81.23.169])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id HAA28135
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 07:07:28 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 168bZN-0000B4-00
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 07:18:13 +0100
Date: Tue, 27 Nov 2001 07:18:10 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: Status RM200
Message-ID: <20011127071800.A292@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20011126204509.A10341@paradigm.rfc822.org> <20011126213450.B943@excalibur.cologne.de> <20011126231737.B13081@paradigm.rfc822.org> <20011126233548.D26510@finlandia.infodrom.north.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126233548.D26510@finlandia.infodrom.north.de>; from joey@infodrom.org on Mon, Nov 26, 2001 at 11:35:48PM +0100
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 11:35:48PM +0100, Martin Schulze wrote:

> > How can the RM200 port be wrong endianess - The RM200 is bi-endian
> > thus any endianess would be ok (As long as the port does not assume
> > a specific endianess except the prom stuff).

Unfortunately the firmware functions are different between little- and
big-endian firmware and there are quite some parts in the RM200 support
which currently do not work (and some even do not compile) on a big-endian
machine due to missing (correct) definitions. Another problem regarding 
the big endian firmware is that nobody seems to have documentation about
it, not even a function vector table.

> As I remember, you can't switch to "the right" endianess without a support
> drivers f*ckup disk - which hasn't appeared on the stage yet.

Right - Ralf had asked around for some disks to convert his LE RM200C to
BE firmware for further development,  but nobody had yet been able to
come up with some. Additionally, AFAICS these disks are different for
different machine types and possibly even for different CPU types
(RM200 EISA vs. RM200C PCI and R4k vs R5k). If anybody knows more about
these issues, any help is welcome.

Greetings,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
