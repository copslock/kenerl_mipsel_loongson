Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 14:11:49 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:1001 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S28591014AbYB1OLr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 Feb 2008 14:11:47 +0000
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JUjTv-0006d5-LG; Thu, 28 Feb 2008 15:11:31 +0100
Message-ID: <47C6C10E.9000300@aurel32.net>
Date:	Thu, 28 Feb 2008 15:11:26 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.14pre (X11/20080208)
MIME-Version: 1.0
To:	"John W. Linville" <linville@tuxdriver.com>
CC:	Michael Buesch <mb@bu3sch.de>, Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SSB] PCI core driver: use new SPROM data structure
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218100126.GA22519@hall.aurel32.net> <20080218100257.GB22519@hall.aurel32.net> <200802181910.46581.mb@bu3sch.de>
In-Reply-To: <200802181910.46581.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Michael Buesch a écrit :
> On Monday 18 February 2008 11:02:57 Aurelien Jarno wrote:
>> Switch the SSB PCI core driver to the new SPROM data structure now that
>> the old one has been removed.
>>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> Acked-by: Michael Buesch <mb@bu3sch.de>
> 
> John, can you please apply this?

John, any news about this patch?

>> ---
>>  drivers/ssb/driver_pcicore.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
>> index 2faaa90..191db7a 100644
>> --- a/drivers/ssb/driver_pcicore.c
>> +++ b/drivers/ssb/driver_pcicore.c
>> @@ -362,7 +362,7 @@ static int pcicore_is_in_hostmode(struct ssb_pcicore *pc)
>>  	    chipid_top != 0x5300)
>>  		return 0;
>>  
>> -	if (bus->sprom.r1.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
>> +	if (bus->sprom.boardflags_lo & SSB_PCICORE_BFL_NOPCI)
>>  		return 0;
>>  
>>  	/* The 200-pin BCM4712 package does not bond out PCI. Even when
>> -- 
>> 1.5.4.1
>>
> 
> 
> 


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
