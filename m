Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 23:37:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6365 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038515AbWKMXhk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Nov 2006 23:37:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kADNc3vP017398;
	Mon, 13 Nov 2006 23:38:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kADNc3CV017397;
	Mon, 13 Nov 2006 23:38:03 GMT
Date:	Mon, 13 Nov 2006 23:38:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Portmap on the Encore M3
Message-ID: <20061113233802.GA17130@linux-mips.org>
References: <1163443607.6532.9.camel@sandbar.kenati.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163443607.6532.9.camel@sandbar.kenati.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 13, 2006 at 10:46:47AM -0800, Ashlesha Shintre wrote:

> > RPC: sendmsg returned error 128.
> > <4>nfs: RPC call returned error 128 

128 = ENETUNREACH.

> I m trying to boot the 2.6.14.6 kernel onto the Encore M3 board that has
> the MIPS AU1500 processor on it.

For more information [1] about 2.6.14 kernels see http://tinyurl.com/hjexx ;-)

> The .config file contains the following line: CONFIG_PORTMAP=y
> The server from which the NFS is mounted is also running the portmap
> daemon..
> 
> Is there a way to check if the portmap server is functioning properly?
> 
> 
> Also:
> 
> - The BogoMIPS value is 7186 which seems too low for the AU1500 -- how
> can I check that the timer interrupt is being handled correctly?  The
> AU1500 has 2 counters which are used to generate a clock
> 
> - On the serial console I can only see messages upto this point:
> 
> 
> > 16.35 BogoMIPS (lpj=8176)

Sounds about right if your CPU clock hapens to be 8MHz so probably not.
Chances the counter was missprogrammed.  Or are you running uncached?
Uncached will completly devastate performance.

> > calibrate delay done
> > anon vma init done
> > Mount-cache hash table entries: 512
> > Checking for 'wait' instruction...  unavailable.
> > NET: Registered protocol family 16
> > size of au1xxx platform devices is 1
> 
> After this, the serial console 'hangs' -- I can see the RPC error from the log buffer, accessed from the JTAG port..
> --Please give any suggestions as to where I should start looking to narrow down and figure out the problem..

At about this point the actual console driver is registered and takes
over from the early console driver - whatever that may be in your case.
So seems the early console driver is fine but the actual console driver
(that is serial driver) is falling over.

  Ralf

[1] Okay, I'm just trying to convince people to upgrade :-)
