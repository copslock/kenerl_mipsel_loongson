Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2006 13:59:09 +0100 (BST)
Received: from signal.itea.ntnu.no ([129.241.190.231]:12724 "HELO
	signal.itea.ntnu.no") by ftp.linux-mips.org with SMTP
	id S8133551AbWDTM6z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Apr 2006 13:58:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by signal.itea.ntnu.no (Postfix) with ESMTP id BC46A33769;
	Thu, 20 Apr 2006 15:11:37 +0200 (CEST)
Received: from invalid.ed.ntnu.no (invalid.ed.ntnu.no [129.241.205.150])
	by signal.itea.ntnu.no (Postfix) with ESMTP;
	Thu, 20 Apr 2006 15:11:37 +0200 (CEST)
Received: from invalid.ed.ntnu.no (jonah@localhost.ed.ntnu.no [127.0.0.1])
	by invalid.ed.ntnu.no (8.13.6/8.13.6) with ESMTP id k3KDBb6V005335
	(version=TLSv1/SSLv3 cipher=DHE-DSS-AES256-SHA bits=256 verify=NO);
	Thu, 20 Apr 2006 15:11:37 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
Received: from localhost (jonah@localhost)
	by invalid.ed.ntnu.no (8.13.6/8.13.6/Submit) with ESMTP id k3KDBY7k005331;
	Thu, 20 Apr 2006 15:11:35 +0200 (CEST)
	(envelope-from jonah@omegav.ntnu.no)
X-Authentication-Warning: invalid.ed.ntnu.no: jonah owned process doing -bs
Date:	Thu, 20 Apr 2006 15:11:34 +0200 (CEST)
From:	Jon Anders Haugum <jonah@omegav.ntnu.no>
X-X-Sender: jonah@invalid.ed.ntnu.no
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	Freddy Spierenburg <freddy@dusktilldawn.nl>,
	linux-mips@linux-mips.org
Subject: Re: UART trouble on the DBAu1100
In-Reply-To: <20060414060640.GE29489@domen.ultra.si>
Message-ID: <20060420145753.C1601@invalid.ed.ntnu.no>
References: <20060413131117.GP11097@dusktilldawn.nl> <20060414060640.GE29489@domen.ultra.si>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Content-Scanned: with sophos and spamassassin at mailgw.ntnu.no.
Return-Path: <jonah@omegav.ntnu.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonah@omegav.ntnu.no
Precedence: bulk
X-list: linux-mips

On Fri, 14 Apr 2006, Domen Puncer wrote:

> On 13/04/06 15:11 +0200, Freddy Spierenburg wrote:
> 
> > But that's not the only trouble. I also do not receive any
> > bytes received by the UART. All the received bytes stay
> > in the input buffer of the UART only to be send up to userland
> > as soon as the UART is asked to send a byte on the line itself.
> > Then in one take all the bytes are received by the application
> > listening.
> 
> I may be way off, but maybe it's just flow control that needs
> to be turned off.

If this is uart 0, it's probably a problem with that uart having irq 
number 0. Which in the 8250 driver is interpreted as no interrupt.

A quick (and dirty) patch:

--- linux/drivers/serial/8250.c_org	2006-03-31 16:07:57.682822888 +0200
+++ linux/drivers/serial/8250.c	2006-03-31 16:08:22.969978656 +0200
@@ -78,7 +78,7 @@ static unsigned int nr_uarts = CONFIG_SE
  * machine types want others as well - they're free
  * to redefine this in their header file.
  */
-#define is_real_interrupt(irq)	((irq) != 0)
+#define is_real_interrupt(irq)	(1)
 
 #ifdef CONFIG_SERIAL_8250_DETECT_IRQ
 #define CONFIG_SERIAL_DETECT_IRQ 1



But this is not a desired solution according to this: 
http://lkml.org/lkml/2006/3/29/91

Have somebody got a idea about how a mapping of interrupt numbers should 
be done in order to avoid irq 0 for Alchemy?


-- 
Jon Anders Haugum
