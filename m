Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 03:16:12 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:24061 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225353AbUBVDQJ>;
	Sun, 22 Feb 2004 03:16:09 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i1M37swW005661;
	Sat, 21 Feb 2004 19:07:54 -0800 (PST)
Received: from gmu-linux (gmu-linux.mips.com [172.20.8.94])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i1M3G1J4009677;
	Sat, 21 Feb 2004 19:16:01 -0800 (PST)
Subject: Re: r3000 instruction set
From:	Michael Uhler <uhler@mips.com>
To:	Mark and Janice Juszczec <juszczec@hotmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date:	21 Feb 2004 19:15:49 -0800
Message-Id: <1077419749.27294.2.camel@gmu-linux>
Mime-Version: 1.0
X-Spam-Scan: SA 2.63
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Unfortunately, what you want isn't the r3000 instruction list but,
instead the 3912 instruction list.  While the original r3000
instructions were well-defined, each manufacturer tended to
add or subtract certain instructions in each implementation
(creating the kind of behavior and questions that you're seeing).

So rather than asking for the list, why not just post the disassembly
and the pc of the reserved instruction?

/gmu

On Sat, 2004-02-21 at 19:02, Mark and Janice Juszczec wrote:
> Hi folks
> 
> I'm working with kaffe on a r3912 cpu. I'm getting an illegal instruction
> error. I disassembled the kaffe binary and thought I'd find the offending
> instruction.
> 
> Unfortunately, I found 2 different lists of r3000 assembler instructions at:
> 
> http://www.xs4all.nl/~vhouten/mipsel/r3000-isa.html
> http://www.xs4all.nl/~vhouten/mipsel/appB.html
> 
> and comparing them against the list of disassembled kaffe instructions
> gives 2 different results.
> 
> So, can someone recommend a definitive list of r3000 assembler instructions?
> 
> Any help would be greatly appreciated.
> 
> Mark
> 
> _________________________________________________________________
> Find and compare great deals on Broadband access at the MSN High-Speed 
> Marketplace. http://click.atdmt.com/AVE/go/onm00200360ave/direct/01/
> 
> 
-- 
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
