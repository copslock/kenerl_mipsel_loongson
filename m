Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2008 23:36:29 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:55776 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S28599069AbYCPXg1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 16 Mar 2008 23:36:27 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Jb2Ow-00081Q-00; Mon, 17 Mar 2008 00:36:26 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 741F4C2270; Mon, 17 Mar 2008 00:36:19 +0100 (CET)
Date:	Mon, 17 Mar 2008 00:36:19 +0100
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiler error? [was: Re: new kernel oops in recent kernels]
Message-ID: <20080316233619.GA29511@alpha.franken.de>
References: <1205664563.3050.4.camel@localhost> <1205699257.4159.14.camel@casa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1205699257.4159.14.camel@casa>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sun, Mar 16, 2008 at 09:27:37PM +0100, Giuseppe Sacco wrote:
> the gcc I am using in versione 4.1.2. Any help is really appreciated.

4.2.1 generates nearly the same (reasonable) code. The major difference
between the version with printk and the version without is the size
of the local stack. I guess this prevents killing of *cd.
Could you try the hack below and tell me, if it helps ? This hack
ensures, that the buffer given to the scsi driver is one cache
line big (at least on R5k O2s). If this helps, there are more
places to fix for non-coherent machines...

Thomas.

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 12f5bae..acb98a8 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -482,7 +482,7 @@ int cdrom_get_media_event(struct cdrom_device_info *cdi,
 			  struct media_event_desc *med)
 {
 	struct packet_command cgc;
-	unsigned char buffer[8];
+	unsigned char buffer[32];
 	struct event_header *eh = (struct event_header *) buffer;
 
 	init_cdrom_command(&cgc, buffer, sizeof(buffer), CGC_DATA_READ);




-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
