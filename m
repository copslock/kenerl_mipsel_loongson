Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Apr 2003 03:28:42 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:21641 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225197AbTDMC2l>;
	Sun, 13 Apr 2003 03:28:41 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP
	id 5C8AA3735; Sat, 12 Apr 2003 21:28:40 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h3D2Se6D019804;
	Sat, 12 Apr 2003 21:28:40 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h3D2SebC019803;
	Sun, 13 Apr 2003 02:28:40 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from 64-212-120-201.bras01.mnd.mn.frontiernet.net (64-212-120-201.bras01.mnd.mn.frontiernet.net [64.212.120.201]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sun, 13 Apr 2003 02:28:39 +0000
Message-ID: <1050200919.3e98cb57e6b84@my.visi.com>
Date: Sun, 13 Apr 2003 02:28:39 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Where does physical RAM start in kseg0?
References: <1050200031.3e98c7df2c227@my.visi.com> <20030413042529.A20034@linux-mips.org>
In-Reply-To: <20030413042529.A20034@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 64.212.120.201
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting Ralf Baechle <ralf@linux-mips.org>:

Ralf wrote:
> There is no requirement at all for a system to have physical memory in
> KSEG0 - the Octane to my knowledge one example.  What every sane system
> needs to have in KSEG0 are exception handlers.  Of course they could also
> reside in a ROM but that's insane so you should expect at least a few kb
> of RAM at physical address zero.

At this point I wouldn't put anything past SGI, but it's good to know my 
suspicions about kseg0 are confirmed.
> 
> Due to the Octane's funky address space layout and the current tools
> limitations the kernel will have to run in CKSEG2 instead of KSEG0 ...
> 
>   Ralf

/nod.  Onward and upward.

Thanks,
Erik



-- 
Erik J. Green
erik@greendragon.org
