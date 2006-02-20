Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 14:10:02 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:50450 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133758AbWBTOJx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 14:09:53 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8AB9B64D3D; Mon, 20 Feb 2006 14:16:46 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0FC958DC5; Mon, 20 Feb 2006 14:16:37 +0000 (GMT)
Date:	Mon, 20 Feb 2006 14:16:36 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Diff between Linus' and linux-mips git: trivial changes
Message-ID: <20060220141636.GJ29098@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060219234757.GW10266@deprecation.cyrius.com> <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0602201329100.13723@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Maciej W. Rozycki <macro@linux-mips.org> [2006-02-20 13:33]:
> > -static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp);
> > +static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
>  ACK.


[MIPS] Remove space before pointer - sync with Linus tree

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

---

diff --git a/drivers/scsi/dec_esp.c b/drivers/scsi/dec_esp.c
index e755664..4b86685 100644
--- a/drivers/scsi/dec_esp.c
+++ b/drivers/scsi/dec_esp.c
@@ -55,7 +55,7 @@
 
 static int  dma_bytes_sent(struct NCR_ESP *esp, int fifo_count);
 static void dma_drain(struct NCR_ESP *esp);
-static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd * sp);
+static int  dma_can_transfer(struct NCR_ESP *esp, struct scsi_cmnd *sp);
 static void dma_dump_state(struct NCR_ESP *esp);
 static void dma_init_read(struct NCR_ESP *esp, u32 vaddress, int length);
 static void dma_init_write(struct NCR_ESP *esp, u32 vaddress, int length);

-- 
Martin Michlmayr
http://www.cyrius.com/
