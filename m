Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2009 17:38:10 +0000 (GMT)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:2020 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28574676AbZCYRiF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Mar 2009 17:38:05 +0000
X-IronPort-AV: E=Sophos;i="4.38,420,1233532800"; 
   d="scan'208";a="161509175"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-1.cisco.com with ESMTP; 25 Mar 2009 17:37:50 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n2PHbob6018700;
	Wed, 25 Mar 2009 10:37:50 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id n2PHboqO015406;
	Wed, 25 Mar 2009 17:37:50 GMT
Received: from jupiter.localdomain (sjc-vpn6-1582.cisco.com [10.21.126.46]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id RAA27585; Wed, 25 Mar 2009 17:37:49 GMT
Message-ID: <49CA6BED.60505@cisco.com>
Date:	Wed, 25 Mar 2009 10:37:49 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Mauricio Culibrk <mauricio@infohit.si>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] Use CP0 Count register to implement more granular
 ndelay
References: <web-5716826@test.infohit.si>
In-Reply-To: <web-5716826@test.infohit.si>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2110; t=1238002670; x=1238866670;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20[PATCH][MIPS]=20Use=20CP0=20Count=20reg
	ister=20to=20implement=20more=20granular=0A=20ndelay
	|Sender:=20;
	bh=vOtc3hy9rrWN2TbfzBslslPHwvX3RgCUJ3yhOhYosx4=;
	b=gF9s92JHyodX2FU9ETDH6dTCoe4/EDXvOcYQBOgdfeNrus4Yc844dwol9E
	ZR/1d4zpm/L7GG/92g731+eOCtdZMg8XNwNykWa5dM4eAG8AqTwpGFwv2Ims
	WBXNQxewCK;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Mauricio Culibrk wrote:
> Hi there!
> 
> I'm really sorry for bothering you.... I noticed your posts and patch on 
> the linux-mips mailing list....
> and I'm very interested in ndelay patch you proposed.
> 
> I'm currently using some embedded mips-based boards for bit-banging SPI 
> and I2C implementations... but the current code uses udelay which is way 
> too "long" for the purporse...
> 
> I'm wondering if you have any updated/fixed patch available as you 
> mention that on the list (that you'll fix your patch a little regarding 
> all the comments received)
> 
> Anyway... I'm using some "consumer" boards based on Atheros WiSoCs 
> AR2315, AR2317... and Broadcom chips which should have MIPS32 MIPS4K 
> cores...
> this cpu should have a "functioning cr0 register", right? (as I have 
> absolutely no "datasheets" available to check for that)

The latest version of the ndelay patch is version 3, which disables 
interrupts to ensure the Count register doesn't wrap. If you have 
interrupts disabled already, there is another function you can can call. 
You can get the version 3 patch from the mailing list archive at 
http://www.linux-mips.org/archives/linux-mips/2009-03/msg00073.html

I haven't received much feedback since the first version of the patch, 
and it's something we're already using, so I think it's in pretty good 
shape. And, as I understand it, R4000-series processors should be in 
shape as far as a good Count register. Part of the version 3 patch adds 
dependencies so that it will only appear in your favorite configuration 
tool if you've selected a processor on which it will work. Ralf has 
mentioned some issues with some R4000 processors, though.

As the code stands on my 24K processor, a requested delay of 100 nsec 
ends up as an actual delay of a bit over 130 nsec. Not perfect, but 
definitely less than 1000 nsec. I have been thinking about adding in a 
calibration constant that should get it closer, but it hasn't been 
important yet and I wanted the basic patch to get accepted before I did 
anything *really* obscure.
