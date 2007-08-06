Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 20:50:22 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:50397 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022065AbXHFTuU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 20:50:20 +0100
Received: from volta.aurel32.net ([2001:618:400:fc13:216:d3ff:fe17:fd00])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1II8Ze-0000yo-Sm; Mon, 06 Aug 2007 21:50:13 +0200
Received: from localhost.localdomain ([127.0.0.1] ident=aurel32)
	by volta.aurel32.net with esmtp (Exim 4.67)
	(envelope-from <aurelien@aurel32.net>)
	id 1II8Zu-0000RS-DB; Mon, 06 Aug 2007 21:49:22 +0200
Message-ID: <46B77B41.6000003@aurel32.net>
Date:	Mon, 06 Aug 2007 21:49:21 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070328)
MIME-Version: 1.0
To:	Michael Buesch <mb@bu3sch.de>
CC:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 3/4] MIPS: Add BCM947XX to Kconfig
References: <20070806150931.GH24308@hall.aurel32.net> <200708062009.14971.mb@bu3sch.de>
In-Reply-To: <200708062009.14971.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Michael Buesch a écrit :
> On Monday 06 August 2007, Aurelien Jarno wrote:
>> The patch below against 2.6.23-rc1-mm2 adds a BCM947XX option to 
>> Kconfig.
>>
>> Cc: Michael Buesch <mb@bu3sch.de>
>> Cc: Waldemar Brodkorb <wbx@openwrt.org>
>> Cc: Felix Fietkau <nbd@openwrt.org>
>> Cc: Florian Schirmer <jolt@tuxbox.org>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -38,6 +38,22 @@
>>  	  Lemote Fulong mini-PC board based on the Chinese Loongson-2E CPU and
>>  	  an FPGA northbridge
>>  
>> +config BCM947XX
>> +	bool "Support for BCM947xx based boards"
>> +	select DMA_NONCOHERENT
>> +	select HW_HAS_PCI
> 
> Not sure what this does.
> My 47xx machines do _not_ have a PCI bus.

Without HW_HAS_PCI, it is not possible to enable the PCI bus, as it
depends on this variable. However having it defined, does not mean the
PCI bus has to be enabled.


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
