Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 05:36:25 +0100 (BST)
Received: from dsl-KK-026.199.95.61.touchtelindia.net ([IPv6:::ffff:61.95.199.26]:53429
	"EHLO trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8225195AbVDEEgK>; Tue, 5 Apr 2005 05:36:10 +0100
Received: from procsys.com ([192.168.1.128])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id j354EMCo029166;
	Tue, 5 Apr 2005 09:44:22 +0530
Message-ID: <42521588.D671F6EE@procsys.com>
Date:	Tue, 05 Apr 2005 10:05:20 +0530
From:	priya <priya@procsys.com>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To:	Brad Larson <Brad_Larson@pmc-sierra.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Porting davicom driver to pmon
References: <04781D450CFF604A9628C8107A62FCCF013DDE1D@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <priya@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: priya@procsys.com
Precedence: bulk
X-list: linux-mips

Hi Brad,
Its a davicom chip. I tried porting the linux driver to pmon - but still iam facing
problems sending the set up frame - actually in the linux the set up frame is sent 5
times. Iam doing the same thing out here too. But while trying to send the setup frame
for the second time the network status report register(cr5) value is 0xfc200007 (which
indicates - move setup frame from host memory, transmit buffer un-available, and transmit
process complete)

Also the network operation mode (register cr6) gets set to hash filtering, while i have
enabled perfect filtering mode in the transmit descriptor. Any idea why this corruption
is happening?

regards
priya

Brad Larson wrote:

> It's a DEC Tulip type chip handled by the dc driver. Should work with "dc* at pci ?".
> Should because I have no own experience with that particular chip.
>
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of priya
> Sent: Monday, April 04, 2005 7:55 AM
> To: linux-mips@linux-mips.org
> Subject: Porting davicom driver to pmon
>
> Hi,
> I am using a custom board which has mips
> processor and davicom ethernet chip. Iam
> using pmon bootloader. Has anyone ported
> davicom driver for pmon. Iam facing a
> lot of problem in sending even a set up
> frame
>
> regards
> priya
