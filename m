Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Mar 2006 14:22:48 +0000 (GMT)
Received: from midas-91-171-chn.midascomm.com ([203.196.171.91]:62125 "EHLO
	info.midascomm.com") by ftp.linux-mips.org with ESMTP
	id S8133138AbWCAOWj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Mar 2006 14:22:39 +0000
Received: from bharathi.midascomm.com ([192.168.13.175])
	by info.midascomm.com (8.12.10/8.12.10) with ESMTP id k21ETvLG024237;
	Wed, 1 Mar 2006 20:00:01 +0530
Date:	Wed, 1 Mar 2006 20:11:52 +0530 (IST)
From:	Bharathi Subramanian <sbharathi@MidasComm.Com>
To:	"Nori, Soma Sekhar" <nsekhar@ti.com>
cc:	Linux MIPS <linux-mips@linux-mips.org>
Subject: RE: CPU Frequency change using PLL
In-Reply-To: <CBD77117272E1249BFDC21E33D555FDC8E0743@dbde01.ent.ti.com>
Message-ID: <Pine.LNX.4.44.0603012002570.10855-100000@bharathi.midascomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-midascomm.com-MailScanner-Information: Please contact the ISP for more information
X-midascomm.com-MailScanner: Found to be clean
X-midascomm.com-MailScanner-From: sbharathi@midascomm.com
Return-Path: <sbharathi@MidasComm.Com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sbharathi@MidasComm.Com
Precedence: bulk
X-list: linux-mips

On Tue, 28 Feb 2006, Nori, Soma Sekhar wrote:

> > During my try, after changing the PLL Freq, the board is stops
> > running. I feel, it is due to change in SDRAM Refresh rate. Is it
> > right ?? Any body tried this, Kindly share exprience with me. Like
> > how to reprogram the peripherals with-out affecting the operation
> > etc..
> 
> Changing the PLL feeding only to the MIPS should not freeze the
> board. You are likely messing with PLL which feeds the peripherals
> as well. 

No. PLL-A (Low Freq) is feeding to peripherals and PLL-B(High Feeq)  
is feeding the MIPS. To save power, I switch from PLL-B to PLL-A
during run-time. After wirte in to PLL-Reg the MIPS Hangs. No reboot.
 
> Changing the PLL which feeds the SDRAM will also likely cause memory
> corruption. Try putting the SDRAM in self-refresh for the duration
> of PLL stablization and then re-program the SDRAM refresh rate.

I didn't tried this Self-Refresh trick, Let me try ...

Kindly CC to me.

Thanks :)
-- 
Bharathi S
