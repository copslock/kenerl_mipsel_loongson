Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Dec 2003 08:58:15 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:50575 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225405AbTLTI6G>;
	Sat, 20 Dec 2003 08:58:06 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBK8vxQF026221;
	Sat, 20 Dec 2003 09:57:59 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id JAA29180;
	Sat, 20 Dec 2003 09:58:00 +0100 (MET)
Date: Sat, 20 Dec 2003 09:58:00 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: samavarthy c <samavarthy@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: USB on MIPS
Message-ID: <20031220085800.GA29155@sonycom.com>
References: <BAY7-F118dxVHYEuZFk0002aaf6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY7-F118dxVHYEuZFk0002aaf6@hotmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Sat, Dec 20, 2003 at 12:52:49PM +0530, samavarthy c wrote:
> The MediaQ controller chip does not sit on the pci bus. The specification 
> says that the chip address space ranges from xxx00000h to xxx80000h.
> 
> This address space is broken into three regions.
> 
> 1. The lower 256 Kbyte region (xxx00000h to xxx40000h) maps to the 256 
> Kbyte internal SRAM and contains the graphics frame buffer.
> 2. The next region (xxx40000h to xxx42000h) is the 8 Kbyte register space, 
> which is located just above the frame buffer.
> 3. The third region, (xxx42000h to xxx80000h) consisting of the remaining 
> 248 Kbyte of address space is also mapped to the upper 248 Kbyte of 
> internal SRAM. This address space is used to access non-graphics frame 
> buffer memory such as buffers for USB.
> 
> So The MediaQ is supposed to use the third region for storing the TD's and 
> ED's basically its HCCA area. On MIPS VR4131 the start address of the third 
> region would be 0xAA042000h. This is what I think I am supposed to fill in 
> the HCCA register. Am I right?

Are you saying that this USB OHCI chip can only access its internal
SRAM ? In that case not only the HCCA area but all the TDs, EDs and
the data pointed to by the descriptors should be allocated there
(basically all data that would be normally accessed by the OHCI chip
as pci master).

> error "controller already in use". The ohci_base value passed was 
> 0xAA040500 which is where the Host controllers registers of MediaQ are 
> mapped.

Did you check the mapped address is correct (e.g. by reading the
revision field of the ohci_regs) ?

Dimitri

-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
