Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NII0L04928
	for linux-mips-outgoing; Mon, 23 Apr 2001 11:18:00 -0700
Received: from fileserv2.Cologne.DE ([62.145.23.107])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f3NIHwM04921
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 11:17:59 -0700
Received: from localhost (1584 bytes) by fileserv2.Cologne.DE
	via rmail with P:stdio/R:bind/T:smtp
	(sender: <excalibur.cologne.de!karsten>) (ident <excalibur.cologne.de!karsten> using unix)
	id <m14rku8-0007jZC@fileserv2.Cologne.DE>
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 20:17:44 +0200 (CEST)
	(Smail-3.2.0.101 1997-Dec-17 #5 built 1998-Jan-19)
Received: (from karsten@localhost)
	by excalibur.cologne.de (8.9.3/8.8.7) id UAA01109;
	Mon, 23 Apr 2001 20:14:28 +0200
Date: Mon, 23 Apr 2001 20:14:28 +0200
From: Karsten Merker <karsten@excalibur.cologne.de>
To: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: ls from fileutils-4.0.43 segfaults
Message-ID: <20010423201428.A1020@excalibur.cologne.de>
Mail-Followup-To: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
References: <20010422224018.A9017@excalibur.cologne.de> <20010422174313.A1342@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010422174313.A1342@nevyn.them.org>; from dan@debian.org on Sun, Apr 22, 2001 at 05:43:13PM -0400
X-No-Archive: yes
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 22, 2001 at 05:43:13PM -0400, Daniel Jacobowitz wrote:

> Most likely you have a kernel with the sysmips() bug discussed on
> linux-mips over the past month and a half or so; the archives have
> Florian's workaround and other discussion.

Oops - I should stop working in parallel with different kernel trees when
I am tired... You are right, I had built the kernel from a source tree
without the patch; after applying the patch, ls works.

Thanks,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.
