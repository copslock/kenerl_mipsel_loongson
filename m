Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 19:57:23 +0000 (GMT)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:42731 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8225207AbUJaT5R>;
	Sun, 31 Oct 2004 19:57:17 +0000
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1COLpE-0001sr-00; Sun, 31 Oct 2004 20:57:16 +0100
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id 97A1C1E5C7; Sun, 31 Oct 2004 20:55:50 +0100 (CET)
Date: Sun, 31 Oct 2004 20:55:50 +0100
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031195550.GA12397@aton.pcde.inka.de>
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl> <20041031191631.GB11681@aton.pcde.inka.de> <20041031192653.GG2094@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031192653.GG2094@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

On Sun, Oct 31, 2004 at 08:26:53PM +0100, Jan-Benedict Glaw wrote:

> System.map is a list of function start addresses. Typically, functions
> don't crash at their very first instructions, this is why you don't see
> "exact" matches.

okay.
 
> From my fading MIPS knowledge, ip22zilog_interrupt called
> ip22zilog_receive_chars and the later one crashed. Now, use objdump and
> create a disassembly dump of the object file that contains the IP22
> Zilog stuff. There, find the part that's 0x20 bytes away from the start
> of ip22zilog_receive_chars. Now you know the cause of this oops.

That's what I found:

8810da14:       8c82001c        lw      v0,28(a0)
8810da18:       00809021        move    s2,a0
8810da1c:       8c510000        lw      s1,0(v0)
8810da20:       00a09821        move    s3,a1   
8810da24:       8e220118        lw      v0,280(s1) 

and:

8810e224:       0e04367f        jal     8810d9fc <ip22zilog_receive_chars>
8810e228:       02803021        move    a2,s4
8810e22c:       0a04386e        j       8810e1b8 <ip22zilog_interrupt+0xd8>
8810e230:       32020001        andi    v0,s0,0x1   
8810e234:       0e0437bc        jal     8810def0 <ip22zilog_transmit_chars>

> From
> here, try to figure out the reason for it...
 
Well, I'm sure "MIPS assembly for Dummies" must be available
somewhere. While I keep looking please help me ;-)

mfg
Dennis

-- 
There is certainly no purpose in remaining in the dark
except long enough to clear from the mind
the illusion of ever having been in the light.
                                        T.S. Eliot
