Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 09:06:06 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:44977 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20022946AbXHGIGE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 09:06:04 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IIK4i-0008QS-Fj; Tue, 07 Aug 2007 10:05:56 +0200
Message-ID: <46B827DE.4040406@aurel32.net>
Date:	Tue, 07 Aug 2007 10:05:50 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Florian Schirmer <jolt@tuxbox.org>
CC:	Michael Buesch <mb@bu3sch.de>, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org, Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support (v2)
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net> <200708062037.05995.mb@bu3sch.de> <20070806191712.GA2019@hall.aurel32.net> <46B7851B.1050008@tuxbox.org>
In-Reply-To: <46B7851B.1050008@tuxbox.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Florian Schirmer a écrit :
> Hi,
> 
> Aurelien Jarno wrote:
>> The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
>> It originally comes from the OpenWrt patches.
>>
>> Cc: Michael Buesch <mb@bu3sch.de>
>> Cc: Waldemar Brodkorb <wbx@openwrt.org>
>> Cc: Felix Fietkau <nbd@openwrt.org>
>> Cc: Florian Schirmer <jolt@tuxbox.org>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>   
> 
> I'm not sure whether it's a good idea to export a symbol named "ssb". 
> Maybe bcm47xx_ssb would be a better name? I've no idea what the general 
> rule on exporting symbols is though. Otherwise:

I don't not either, but looking in other parts of the kernel it seems it
is done the other way, ie ssb_bcm947xx would be the correct name.

I will send an updated patch.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
