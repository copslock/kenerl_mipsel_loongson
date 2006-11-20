Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Nov 2006 23:29:44 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:40086 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20038925AbWKTX3j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Nov 2006 23:29:39 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 40B16E4051;
	Mon, 20 Nov 2006 16:57:39 -0800 (PST)
Subject: LPJ value on the AU1500
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1163469787.6532.26.camel@sandbar.kenati.com>
References: <1163443607.6532.9.camel@sandbar.kenati.com>
	 <20061113233802.GA17130@linux-mips.org>
	 <1163469787.6532.26.camel@sandbar.kenati.com>
Content-Type: text/plain
Date:	Mon, 20 Nov 2006 15:41:17 -0800
Message-Id: <1164066077.7726.6.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13229
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips

On the Encore M3 board that has the AU1500 MIPS processor on it, 
the BogoMIPS value should be 240,000 as per the cpu_syspll register

However the loops_per_jiffy variable is defined as an unsigned long in
the init/main.c making it impossible to achieve this value of 240K...

Assuming that unsigned long means that a total of 4 bytes are allocated
to this variable..Am I looking at the wrong value?
The value that I get at boot time is lpj=8192.

Thanks for your help,
Ashlesha.


On Mon, 2006-11-13 at 18:03 -0800, Ashlesha Shintre wrote:
> On Mon, 2006-11-13 at 23:38 +0000, Ralf Baechle wrote:
> > On Mon, Nov 13, 2006 at 10:46:47AM -0800, Ashlesha Shintre wrote:
> > 
> > > > RPC: sendmsg returned error 128.
> > > > <4>nfs: RPC call returned error 128 
> > 
> > 128 = ENETUNREACH.
> Thank you -
> > 
> > > I m trying to boot the 2.6.14.6 kernel onto the Encore M3 board that has
> > > the MIPS AU1500 processor on it.
> > 
> > For more information [1] about 2.6.14 kernels see http://tinyurl.com/hjexx ;-)
> > 
> > > The .config file contains the following line: CONFIG_PORTMAP=y
> > > The server from which the NFS is mounted is also running the portmap
> > > daemon..
> > > 
> > > Is there a way to check if the portmap server is functioning properly?
> > > 
> > > 
> > > Also:
> > > 
> > > - The BogoMIPS value is 7186 which seems too low for the AU1500 -- how
> > > can I check that the timer interrupt is being handled correctly?  The
> > > AU1500 has 2 counters which are used to generate a clock
> > > 
> > > - On the serial console I can only see messages upto this point:
> > > 
> > > 
> > > > 16.35 BogoMIPS (lpj=8176)
> > 
> > Sounds about right if your CPU clock hapens to be 8MHz so probably not.
> > Chances the counter was missprogrammed.  Or are you running uncached?
> > Uncached will completly devastate performance.
> > 
> 
> For the AU1500 processor, the CPU Clock is derived from the PLL whose
> input is 12MHz.. Upon reading the value of the SYS_CPUPLL register in
> the calibrate_delay function, I found out that the multiplying factor is
> 40, thus, the CPU Clock frequency is 480MHz.. Thus the lpj should be
> approximately 480000 -- right?
> 
> Also I dont know what you mean by "running uncached"?
> 
> > > > calibrate delay done
> > > > anon vma init done
> > > > Mount-cache hash table entries: 512
> > > > Checking for 'wait' instruction...  unavailable.
> > > > NET: Registered protocol family 16
> > > > size of au1xxx platform devices is 1
> > > 
> > > After this, the serial console 'hangs' -- I can see the RPC error from the log buffer, accessed from the JTAG port..
> > > --Please give any suggestions as to where I should start looking to narrow down and figure out the problem..
> > 
> > At about this point the actual console driver is registered and takes
> > over from the early console driver - whatever that may be in your case.
> > So seems the early console driver is fine but the actual console driver
> > (that is serial driver) is falling over.
> > 
> Thanks a lot, I will check the problem with the serial driver -- i m
> using the 8250.c serial driver..
> 
> There is no early console init funciton:  The board has a serial port on
> a VIA 686B Southbridge on the PCI bus -- so to get the kernel messages
> on the console, before initialising the serial driver I just write a TLB
> entry giving the address of the VIA on the PCI bus --
> 
> So maybe deleting this TLB entry before serial driver initialisation
> might work at this point...I will try that next -
> 
> >   Ralf
> > 
> > [1] Okay, I'm just trying to convince people to upgrade :-)
> I will convey your message to my boss :-)
> 
> Thanks again,
> Ashlesha.
> 
> 
> 
