Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 03:02:46 +0100 (BST)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:54201 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8226000AbUFOCCU>;
	Tue, 15 Jun 2004 03:02:20 +0100
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1Ba3HF-0005XF-00; Tue, 15 Jun 2004 04:02:17 +0200
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id E085A1E5C7; Tue, 15 Jun 2004 03:22:10 +0200 (CEST)
Date: Tue, 15 Jun 2004 03:22:10 +0200
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-mips@linux-mips.org
Subject: Re: network problems with cobalt raq2
Message-ID: <20040615012210.GA23531@aton.pcde.inka.de>
References: <20040613000452.GA3861@aton.pcde.inka.de> <20040614171751.GA383@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614171751.GA383@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, Jun 14, 2004 at 06:17:51PM +0100, Martin Michlmayr wrote:

> I just tested on my RaQ2 and I get up to 2500kB/s via FTP.  This is
> in my LAN with a 100 MBit switch.

Hmm. Maybe this is really the maximum...
 
> Which network device do you use (the first or second)?  What's your
> setup?  Do you get such low rates also when you simply do FTP without
> any masquerading or other stuff?

Okay. This is the current state:
I could finally compile the current CVS kernel + the Cobalt
patches from http://www.colonel-panic.org/cobalt-mips/
The Raq2 is now running 2.6.7-rc3. With this upgrade
everything got bettter, but it's still not perfect.
With the standard Debian ftpd connections begin with about
2.5MB/s, but then drop to 1.37MB/s. Using vsftpd it's
similar, but the transfer rate doesn't drop so much.
I can get about 1.67MB/s. There is no real difference
whether firewalling/masquerading is used at the same time
or not. I'm just a bit confused because I was told by
another Raq2 owner that he could get transfer rates of about
6 or 7MB/s using the current CVS kernel. I did all my
tests by transferring the ungzipped gcc-3.4.0 tarball.
That's 182MB. The nice thing is that I can now
transfer a big file via ftp without killing the whole
machine. With 2.4.26 beginning an ftp transfer made
all other connections unuseable. Outgoing SSH
connections dropped down so much that I could wait
for every typed character to appear. Maybe it's
a good idea to file a Debian bug report. Their
standard kernel seems to be problematic.

Anyway, the network problems didn't go away completely.
I had one "almost" network freeze with the new kernel
resulting in lots of dropped packages and transfer rates
similar to what I described in my first mail. Restarting
the network solved this.

tessa:~# ifconfig eth0 
eth0      Link encap:Ethernet  HWaddr 00:10:E0:00:31:F5  
          inet addr:192.168.2.10  Bcast:192.168.2.255  Mask:255.255.255.0
          inet6 addr: fe80::210:e0ff:fe00:31f5/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4314429 errors:2 dropped:10412 overruns:0 frame:5
          TX packets:3013429 errors:23 dropped:0 overruns:4 carrier:19
          collisions:0 txqueuelen:1000 
          RX bytes:1151870219 (1.0 GiB)  TX bytes:1305479776 (1.2 GiB)
          Interrupt:19 

My current setup is like this: I have connected eth0 to
a 100Mbit switch and eth1 to a gateway router via 10MBit.
The box has about 1 day uptime now and works stable at
the moment. I'm waiting for the next network freeze...

ANother thing worth noting is that after upgrading to 2.6.7-rc3
I have the same problem with "df" that was described on this
list before: 
tessa:~# df 
Filesystem           1K-blocks      Used Available Use% Mounted on
df: `/': Invalid argument
df: `/proc': Invalid argument
df: `/sys': Invalid argument
df: `/dev/pts': Invalid argument
df: `/dev/shm': Invalid argument
df: `/boot': Invalid argument
df: `/export': Invalid argument

strace gives the same info as it was described in the past.

All in all, I'm very interested in any possible improvement.
I need a low cost server that is silent enough that I can
sleep in the same room and this Cobalt seems like a very
good candidate (after replacing the small fan of course).
thanks for your help.

mfg
Dennis

P.S.
I'm not on the list. I'm reading this list via a web-gateway.

-- 
de-moc-ra-cy (di mok' ra see) n.
Three wolves and a sheep voting on what's for dinner.
