Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 04:39:28 +0000 (GMT)
Received: from pimout2-ext.prodigy.net ([IPv6:::ffff:207.115.63.101]:13036
	"EHLO pimout2-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8224802AbULVEjX>; Wed, 22 Dec 2004 04:39:23 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iBM4dAGs168866
	for <linux-mips@linux-mips.org>; Tue, 21 Dec 2004 23:39:11 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Tue, 21 Dec 2004 20:39:06 -0800
Message-ID: <41C8FA5E.2030104@embeddedalley.com>
Date: Tue, 21 Dec 2004 20:38:54 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Green <jgreen@users.sourceforge.net>
CC: Eric DeVolder <eric.devolder@amd.com>, linux-mips@linux-mips.org
Subject: Re: Problems with PCMCIA on AMD dbau1100
References: <1103628665.22113.16.camel@SillyPuddy.localdomain>	 <41C8536E.5060507@embeddedalley.com>	 <1103671370.30276.8.camel@SillyPuddy.localdomain>	 <41C8B1B3.9080201@amd.com> <1103687627.12558.11.camel@SillyPuddy.localdomain>
In-Reply-To: <1103687627.12558.11.camel@SillyPuddy.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Josh Green wrote:
> On Tue, 2004-12-21 at 17:28 -0600, Eric DeVolder wrote:
> 
>>cardbus isn't supported....and i'm not sure if the pcmcia slots are
>>even electrically compatible (meaning i hope your card/db1100 isn't
>>damaged).
>>
> 
> 
> Ahh, thanks for that bit of insight.  I wasn't aware that 32 bit cardbus
> was not supported.  I have a compact flash to PCMCIA adapter which I
> have a 128MB compact flash card installed in, it was detected fine (no
> damage seems to have occurred with either the card or au1100 PCMCIA
> slots).  That solves that problem.
> 
> At first I was rather disappointed when I read this reply, but then I
> looked up the wireless card I want to use (Senao NL-2511 Plus EXT2, a
> Prism 2.5 based card) and it is PCMCIA Type II 16-bit which I suppose
> should work using the hostap driver.

I've used the hostap driver on 2.4 with a Db1x board. It should work 
fine with 2.6 as well.

Pete
