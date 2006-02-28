Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 12:17:12 +0000 (GMT)
Received: from reloaded.ext.ti.com ([192.94.94.6]:28099 "EHLO
	reloaded.ext.ti.com") by ftp.linux-mips.org with ESMTP
	id S8133541AbWB1MRD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2006 12:17:03 +0000
Received: from dlep91.itg.ti.com ([157.170.170.93])
	by reloaded.ext.ti.com (8.13.4/8.13.4) with ESMTP id k1SCNhfI009725;
	Tue, 28 Feb 2006 06:23:53 -0600 (CST)
Received: from dlep90.itg.ti.com (localhost [127.0.0.1])
	by dlep91.itg.ti.com (8.12.11/8.12.11) with ESMTP id k1SCNg0b002777;
	Tue, 28 Feb 2006 06:23:42 -0600 (CST)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep90.itg.ti.com (8.12.11/8.12.11) with ESMTP id k1SCNf5i018855;
	Tue, 28 Feb 2006 06:23:42 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: CPU Frequency change using PLL
Date:	Tue, 28 Feb 2006 17:53:40 +0530
Message-ID: <CBD77117272E1249BFDC21E33D555FDC8E0743@dbde01.ent.ti.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: CPU Frequency change using PLL
Thread-Index: AcY8YKsw15wz/xcaSeCe2rPrjX1O4gAAFfSg
From:	"Nori, Soma Sekhar" <nsekhar@ti.com>
To:	"Linux MIPS" <linux-mips@linux-mips.org>
Cc:	"Bharathi Subramanian" <sbharathi@MidasComm.Com>
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
Precedence: bulk
X-list: linux-mips


> During my try, after changing the PLL Freq, the board is stops
> running. I feel, it is due to change in SDRAM Refresh rate. Is it
> right ?? Any body tried this, Kindly share exprience with me. Like how
> to reprogram the peripherals with-out affecting the operation etc..

Changing the PLL feeding only to the MIPS should not freeze the board.
You are
likely messing with PLL which feeds the peripherals as well. Peripherals
like
UART calculate the baud-rate dividers based on the input frequency. If
that 
changes, the peripheral should be re-initialized.

Changing the PLL which feeds the SDRAM will also likely cause memory
corruption.
Try putting the SDRAM in self-refresh for the duration of PLL
stablization and
then re-program the SDRAM refresh rate.

Thanks,
Sekhar Nori.
