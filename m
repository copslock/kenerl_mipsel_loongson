Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 13:30:43 +0100 (CET)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:34275 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1121742AbSKYMam>; Mon, 25 Nov 2002 13:30:42 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA10305;
	Mon, 25 Nov 2002 13:30:56 +0100 (MET)
Date: Mon, 25 Nov 2002 13:30:56 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux/MIPS Development <linux-mips@linux-mips.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	tsbogend@alpha.franken.de
Subject: Re: [RFT] DEC SCSI driver clean-up
In-Reply-To: <Pine.GSO.4.21.0211211557560.18129-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.3.96.1021125132733.8769D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 21 Nov 2002, Geert Uytterhoeven wrote:

> Yes, it definitely doesn't work, since SCSI_JAZZ_ESP isn't used at all in
> jazz_esp.c (noticed while moving the SCSI host template initializers from the
> header files to the source files).

 I suggest the following patch for the Oktagon driver.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.20-pre6-20021125-oktagon_esp-0
--- linux/drivers/scsi/oktagon_esp.c.macro	Thu Jun 27 02:59:32 2002
+++ linux/drivers/scsi/oktagon_esp.c	Mon Nov 25 12:11:43 2002
@@ -548,7 +548,7 @@ static void dma_invalidate(struct NCR_ES
 
 void dma_mmu_get_scsi_one(struct NCR_ESP *esp, Scsi_Cmnd *sp)
 {
-        sp->SCp.have_data_in = (int) sp->SCp.ptr =
+        sp->SCp.ptr =
                 sp->request_buffer;
 }
 
