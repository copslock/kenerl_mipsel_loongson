Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 18:53:28 +0000 (GMT)
Received: from mail.e-smith.com ([IPv6:::ffff:216.191.234.126]:41746 "HELO
	nssg.mitel.com") by linux-mips.org with SMTP id <S8224992AbUAOSx1>;
	Thu, 15 Jan 2004 18:53:27 +0000
Received: (qmail 19409 invoked by uid 404); 15 Jan 2004 18:53:18 -0000
Received: from charlieb-linux-mips@e-smith.com by tripe.nssg.mitel.com with qmail-scanner; 15 Jan 2004 13:53:18 -0000
Received: from allspice-core.nssg.mitel.com (HELO e-smith.com) (10.33.16.12)
  by tripe.nssg.mitel.com (10.33.17.11) with SMTP; 15 Jan 2004 18:53:18 -0000
Received: (qmail 4499 invoked by uid 5008); 15 Jan 2004 18:53:18 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2004 18:53:18 -0000
Date: Thu, 15 Jan 2004 13:53:18 -0500 (EST)
From: Charlie Brady <charlieb-linux-mips@e-smith.com>
X-X-Sender: charlieb@allspice.nssg.mitel.com
To: linux-mips@linux-mips.org
Subject: Re: Broadcom 4702?
In-Reply-To: <Pine.LNX.4.44.0401131655350.20844-100000@allspice.nssg.mitel.com>
Message-ID: <Pine.LNX.4.44.0401151343460.17500-100000@allspice.nssg.mitel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <charlieb-linux-mips@e-smith.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charlieb-linux-mips@e-smith.com
Precedence: bulk
X-list: linux-mips


On Tue, 13 Jan 2004, Charlie Brady wrote:

> I haven't found signs of it in the archives, but is anyone aware of any 
> efforts to fold in Broadcom's support for their 4702 processor, as used in 
> Wireless gateways such as the Linksys WRT54G?

FWIW, there was some mention of this on lkml.

http://testing.lkml.org/slashdot.php?mid=313689

Looks like it may have quickly been put in the "Too Hard" basket. The 
bulk of the 15Mb patch, however, is not a port per se, but addition of 
kdbg and XFS, so there won't be anywhere near that much real work.

Here's an important one, however, which I alluded to yesterday:

+ifdef CONFIG_BCM4710
+GCCFLAGS       += -m4710a0kern
 endif

I haven't tried building and running a kernel built without the gcc 
workarounds, so I don't know whether they are only required for early 
silicon. My guess would be not. Is there anyone from Broadcom here who 
knows or can find out?

--
Charlie
