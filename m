Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBIMGKk19270
	for linux-mips-outgoing; Tue, 18 Dec 2001 14:16:20 -0800
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBIMGIo19266
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 14:16:18 -0800
Received: from excalibur.cologne.de (pD9511F21.dip.t-dialin.net [217.81.31.33])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id WAA07911
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 22:16:15 +0100 (MET)
Received: from karsten by excalibur.cologne.de with local (Exim 3.12 #1 (Debian))
	id 16GQRS-0001Ee-00
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 21:02:22 +0100
Date: Tue, 18 Dec 2001 21:02:22 +0100
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com
Subject: Re: [ppopov@mvista.com: Re: [Linux-mips-kernel]ioremap & ISA]
Message-ID: <20011218210222.A4743@excalibur.cologne.de>
Mail-Followup-To: Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@oss.sgi.com
References: <20011217151515.A9188@neurosis.mit.edu> <20011217193432.A7115@dea.linux-mips.net> <20011218020344.A10509@neurosis.mit.edu> <20011218162506.A24659@dea.linux-mips.net> <3C1F9608.E4E32E18@mvista.com> <20011218173118.C28080@dea.linux-mips.net> <3C1F9AD2.1269192E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1F9AD2.1269192E@mvista.com>; from jsun@mvista.com on Tue, Dec 18, 2001 at 11:36:50AM -0800
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 11:36:50AM -0800, Jun Sun wrote:

> I was thinking most ISA dirvers should simply use inb/outb to access ioports.
> Don't really any ISA devices have their own memory space.  But, anyway, who

Hm, what is with network cards such as the WD8013 or the SMC Ultra
(8 kb SRAM send- and receive-buffer)?

Greetings,
Karsten
(still happily using these, albeit on i386)
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
