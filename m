Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 12:30:16 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:5815 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021756AbXHILaH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 12:30:07 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IJ6AD-00077R-QD; Thu, 09 Aug 2007 13:26:52 +0200
Message-ID: <46BAF9F0.5060900@aurel32.net>
Date:	Thu, 09 Aug 2007 13:26:40 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>, nbd@openwrt.org,
	jolt@tuxbox.org
Subject: Re: [PATCH 2/4][RFC] MIPS: BCM947xx support
References: <20070806150900.GG24308@hall.aurel32.net> <200708091200.09615.mb@bu3sch.de> <46BAEEB3.8030205@aurel32.net> <200708091251.37073.mb@bu3sch.de>
In-Reply-To: <200708091251.37073.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Michael Buesch a écrit :
> On Thursday 09 August 2007 12:38:43 Aurelien Jarno wrote:
>> Michael Buesch a écrit :
>>> On Thursday 09 August 2007 02:44:30 Aurelien Jarno wrote:
>>>> +struct ssb_bus ssb_bcm947xx;
>>>> +EXPORT_SYMBOL(ssb_bcm947xx);
>>> Huh, which module does need this internal structure?
>>>
>> This is needed for mtd mappings. The size and the location of the flash
>> is taken from this structure.
>>
> 
> So mtd is compiled as a module? Really? From where is it loaded,
> if not from flash?
> 

Well you don't have to compile it as a module, but you can. Then you can
load it from the hard drive.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
