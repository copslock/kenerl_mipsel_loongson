Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 23:56:40 +0100 (BST)
Received: from host31.ipowerweb.com ([IPv6:::ffff:12.129.198.131]:38810 "EHLO
	host31.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8225206AbTENW4d>; Wed, 14 May 2003 23:56:33 +0100
Received: from rrcs-central-24-123-115-43.biz.rr.com ([24.123.115.43] helo=RADIUM)
	by host31.ipowerweb.com with esmtp (Exim 3.36 #1)
	id 19G5B0-0007dY-00
	for linux-mips@linux-mips.org; Wed, 14 May 2003 15:56:46 -0700
From: "Lyle Bainbridge" <lyle@zevion.com>
To: <linux-mips@linux-mips.org>
Subject: RE: Power On Self Test and testing memory
Date: Wed, 14 May 2003 17:56:26 -0500
Message-ID: <000001c31a6c$0e504e80$0a01a8c0@RADIUM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <20030514152643.A5897@luca.pas.lab>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host31.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - zevion.com
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

I used the same strategy, but had similar issues.
So I just skip the first couple of 1000 bytes.
I'd like to find out why too.

Also, memory wraps.  If I have 32MB of RAM @ 0x80000000,
then run the memory test in non-existent memory from
0x82000000 to 0x83ffffff it appears to reference 0x80000000
to 0x81ffffff.  Can this be made to fail?

Lyle


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Jeff Baitis
> Sent: Wednesday, May 14, 2003 5:27 PM
> To: linux-mips@linux-mips.org
> Subject: Power On Self Test and testing memory
> 
> 
> Hi all:
> 
> I implemented memory tests in my bootloader code for the 
> AU1500. I'm trying to figure out why Linux boots when loaded 
> into cached KSEG0 (0x 80c0 0000), but my memory test FAILS 
> for this same region.
> 
> (pretty backwards huh? get linux booting, then write memory tests!)
> 
> 
> I start by writing 0x5555 5555 to all of uncached memory, 
> reading it back, and I write 0xAAAA AAAA to all of uncached 
> memory and read it back.
> 
> This works great.
> 
> Next, I try to write 0x5555 5555 to cached KSEG0 memory, and 
> it fails at addr 0x8000FE50. But Linux boots!
> 
> I'm not issuing SYNC commands when writing to cached memory; 
> could this be the problem?
> 
> We've exhaustively verified the memory burst parameters, etc. 
> They look good.
> 
> Thank you in advance for your ideas!
> 
> Regards,
> Jeff
> 
> -- 
>          Jeffrey Baitis - Associate Software Engineer
> 
>                     Evolution Robotics, Inc.
>                      130 West Union Street
>                        Pasadena CA 91103
> 
>  tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
> 
