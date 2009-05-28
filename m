Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 22:36:25 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:50759 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023944AbZE1VgT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 22:36:19 +0100
X-IronPort-AV: E=Sophos;i="4.41,267,1241395200"; 
   d="scan'208";a="191622093"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 28 May 2009 21:35:54 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n4SLZsCK013928;
	Thu, 28 May 2009 14:35:54 -0700
Received: from cuplxvomd02.corp.sa.net ([64.101.20.155])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n4SLZs4D015923;
	Thu, 28 May 2009 21:35:54 GMT
Date:	Thu, 28 May 2009 14:35:54 -0700
From:	David VomLehn <dvomlehn@cisco.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/3] mips:powertv: Integrate Cisco Powertv platform
	into MIPS architecture (resend)
Message-ID: <20090528213553.GA24783@cuplxvomd02.corp.sa.net>
References: <20090504225821.GA22833@cuplxvomd02.corp.sa.net> <49FF8DAC.8090701@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49FF8DAC.8090701@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1287; t=1243546554; x=1244410554;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH=203/3]=20mips=3Apowertv=3A=20Int
	egrate=20Cisco=20Powertv=20platform=0A=09into=20MIPS=20archi
	tecture=20(resend)
	|Sender:=20;
	bh=gM3MAYeodaV9c9JJu63442IIMzEQvo9ExFS5wi/ItQE=;
	b=Xadhc5k+ip72gt6RPjLjverxGWRcrP5JvLnJqa70QYl2LzceVaTlZUKRpf
	J2tReGchcLHHRGlqYihuY4t28LErzlPgxBH+KIvpjMh2aWBGSqWp9Mkkw4bM
	ZI+j5Kd500;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Mon, May 04, 2009 at 05:51:56PM -0700, David Daney wrote:
> David VomLehn wrote:
>> Adds the Cisco PowerTV platform to the configuration and Make files so
>> that we can build a kernel for it.
>>
>> Signed-off-by: David VomLehn <dvomlehn@cisco.com>
>> ---
>>  arch/mips/Kconfig                   |   30 +
>>  arch/mips/Makefile                  |    8 +
>>  arch/mips/configs/powertv_defconfig | 1484 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 1522 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 99f7b6d..b23ec4c 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
> [...]
>>  +#
>> +# The flag for POWERTV clock source.
>> +#
>> +config CEVT_POWERTV
>> +	bool
>> +
>>  config CEVT_SB1250
>>  	bool
>>  @@ -742,6 +766,12 @@ config CSRC_R4K
>>  	select CSRC_R4K_LIB
>>  	bool
>>  +#
>> +# The flag for POWERTV clock event.
>> +#
>> +config CSRC_POWERTV
>> +	bool
>> +
>>  config CSRC_SB1250
>>  	bool
>>  
>
> Could/should CEVT_POWERTV and CSRC_POWERTV be either eliminated or moved  
> to your processor specific directory?  That is where the corresponding  
> code lives.

Yes, these can be moved. I've got to dig a bit to see about eliminating them.

> David Daney
