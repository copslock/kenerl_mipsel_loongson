Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 14:54:02 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:23300 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133413AbWBPOxx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Feb 2006 14:53:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1GExVY7004216;
	Thu, 16 Feb 2006 14:59:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1GExVu2004215;
	Thu, 16 Feb 2006 14:59:31 GMT
Date:	Thu, 16 Feb 2006 14:59:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
Message-ID: <20060216145931.GA1633@linux-mips.org>
References: <20060213225331.GA5315@deprecation.cyrius.com> <20060215150839.GA27719@linux-mips.org> <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602161016260.7169@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10475
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 16, 2006 at 10:17:38AM +0000, Maciej W. Rozycki wrote:
> Date:	Thu, 16 Feb 2006 10:17:38 +0000 (GMT)
> From:	"Maciej W. Rozycki" <macro@linux-mips.org>
> To:	Ralf Baechle <ralf@linux-mips.org>
> cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
> Subject: Re: Please pull drivers/scsi/dec_esp.c from Linus' git
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> 
> On Wed, 15 Feb 2006, Ralf Baechle wrote:
> 
> > > @@ -230,7 +230,7 @@
> > >  			mem_start = get_tc_base_addr(slot);
> > >  
> > >  			/* Store base addr into esp struct */
> > > -			esp->slot = mem_start;
> > > +			esp->slot = CPHYSADDR(mem_start);
> > >  
> > >  			esp->dregs = 0;
> > >  			esp->eregs = (void *)CKSEG1ADDR(mem_start +
> > 
> > I merged allmost all of the differences from mainline except this one.
> > 
> > Maciej, does this need the CPHYSADDR() op or not here?
> 
>  Of course not as get_tc_base_addr() returns a physical address these 
> days.  Thanks for spotting this bit.

Ok, I sent this bit upstream.

That still leaves below gem to sort out.

  Ralf

diff --git a/drivers/scsi/NCR53C9x.h b/drivers/scsi/NCR53C9x.h
index 65a9b37..81d03d1 100644
--- a/drivers/scsi/NCR53C9x.h
+++ b/drivers/scsi/NCR53C9x.h
@@ -145,12 +145,7 @@
 
 #ifndef MULTIPLE_PAD_SIZES
 
-#ifdef CONFIG_CPU_HAS_WB
-#include <asm/wbflush.h>
-#define esp_write(__reg, __val) do{(__reg) = (__val); wbflush();} while(0)
-#else
-#define esp_write(__reg, __val) ((__reg) = (__val))
-#endif
+#define esp_write(__reg, __val) do{(__reg) = (__val); iob();} while(0)
 #define esp_read(__reg) (__reg)
 
 struct ESP_regs {
