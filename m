Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 23:26:52 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:27881 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225217AbTENW0u>;
	Wed, 14 May 2003 23:26:50 +0100
Received: (qmail 15087 invoked by uid 6180); 14 May 2003 22:26:43 -0000
Date: Wed, 14 May 2003 15:26:43 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: linux-mips@linux-mips.org
Subject: Power On Self Test and testing memory
Message-ID: <20030514152643.A5897@luca.pas.lab>
Reply-To: baitisj@evolution.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Hi all:

I implemented memory tests in my bootloader code for the AU1500. I'm trying
to figure out why Linux boots when loaded into cached KSEG0 (0x 80c0 0000),
but my memory test FAILS for this same region.

(pretty backwards huh? get linux booting, then write memory tests!)


I start by writing 0x5555 5555 to all of uncached memory, reading it back, and
I write 0xAAAA AAAA to all of uncached memory and read it back.

This works great.

Next, I try to write 0x5555 5555 to cached KSEG0 memory, and it fails at addr
0x8000FE50. But Linux boots!

I'm not issuing SYNC commands when writing to cached memory; could this be
the problem?

We've exhaustively verified the memory burst parameters, etc. They look good.

Thank you in advance for your ideas!

Regards,
Jeff

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
