Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2004 00:08:30 +0000 (GMT)
Received: from [IPv6:::ffff:217.157.140.228] ([IPv6:::ffff:217.157.140.228]:30510
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225328AbUBRAIa>; Wed, 18 Feb 2004 00:08:30 +0000
Received: from murphy.dk ([10.0.0.105])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id i1I08NRc028457;
	Wed, 18 Feb 2004 01:08:23 +0100
Message-ID: <4032ACF7.7060809@murphy.dk>
Date: Wed, 18 Feb 2004 01:08:23 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: linux-mips@linux-mips.org
Subject: Re: CONFIG_MIPS_RTC for lasat
References: <20040217210431.GC11511@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:

>Hi,
>it makes sense to set CONFIG_MIPS_RTC in defconfig for lasat as the
>board specific get/set_ are implemented:
>
>retrieving revision 1.1.2.37
>diff -u -r1.1.2.37 defconfig-lasat
>--- arch/mips/defconfig-lasat	11 Feb 2004 15:43:26 -0000	1.1.2.37
>+++ arch/mips/defconfig-lasat	17 Feb 2004 21:02:47 -0000
>@@ -615,7 +615,7 @@
> # CONFIG_AMD_PM768 is not set
> # CONFIG_NVRAM is not set
> # CONFIG_RTC is not set
>-# CONFIG_MIPS_RTC is not set
>+CONFIG_MIPS_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
>
>Flo
>  
>
Indeed it does.

/Brian
