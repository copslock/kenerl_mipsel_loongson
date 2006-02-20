Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:06:02 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:15370 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133757AbWBTOFx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:05:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1KEBlCV022794;
	Mon, 20 Feb 2006 14:11:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KEBkFj022793;
	Mon, 20 Feb 2006 14:11:46 GMT
Date:	Mon, 20 Feb 2006 14:11:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220141146.GA22667@linux-mips.org>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 20, 2006 at 01:33:31PM +0000, Maciej W. Rozycki wrote:

> > diff --git a/drivers/scsi/dec_esp.c b/drivers/scsi/dec_esp.c
> > index e755664..4b86685 100644
> > --- a/drivers/scsi/dec_esp.c
> > +++ b/drivers/scsi/dec_esp.c
> > @@ -55,7 +55,7 @@
> >  
> >  static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
> >  static void dma_drain(struct NCR_ESP *esp);
> > -static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp);
> > +static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
> >  static void dma_dump_state(struct NCR_ESP *esp);
> >  static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
> >  static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);
> 
>  ACK.

Actually the reversed patch is on in flight since a while but seems to
have lost like anything SCSI-related I sent in past weeks ...

  Ralf
