Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 15:30:48 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40856 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28603518AbZDFOaJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Apr 2009 15:30:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n36EU8SO019088;
	Mon, 6 Apr 2009 16:30:08 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n36EU703019086;
	Mon, 6 Apr 2009 16:30:07 +0200
Date:	Mon, 6 Apr 2009 16:30:07 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marian Jancar <m.jancar@satca.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: gcc: mips32 vs mips3
Message-ID: <20090406143007.GE15625@linux-mips.org>
References: <49B1556E.3030903@satca.net> <20090309193902.GA993@linux-mips.org> <49DA0FE3.1070400@satca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DA0FE3.1070400@satca.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 06, 2009 at 04:21:23PM +0200, Marian Jancar wrote:

>> That question doesn't quite make sense.   A MIPS32 processor can't execute
>> MIPS III code and a MIPS III processor can't execute MIPS32 code.  Only a
>> MIPS64 processor could execute code compiled for either MIPS32 or MIPS III.
>> So choose the option to match the architecture of your processor.
>
> The processor in question is the processos in the Atheros 802.11 SoC  
> AR5312, 4Kc AFAIK.
> OpenWRT uses -mips32 for this target but the GPL SDK for NanoStation
> uses -march=r4600. Both options produce code that runs without oops
> or any other immediately manifested issues.
>
> So you are right, the correct question is "-mips32 vs -march=r4600".
> I got confused because I left some bits compiled with -march=4600 when
> recompiling with -mips32 and gcc complained about it being compiled
> for MIPS III when linking.

That's correct because the the R4600 is MIPS III but but when building o32
binaries gcc will automatically limit itself to the 32-bit subset of
MIPS III which is MIPS II.  MIPS II in turn is a subset of MIPS32.  So
that's actually safe but it won't deliver optimal code.

Occasionally one may have to cheat to the compiler like this for example
if the compiler is very (VERY!!!) old and doesn't know about the 4K or
MIPS32 yet.  Not recommended for those who don't know what gcc will
actually do with the options.

  Ralf
