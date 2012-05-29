Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2012 15:05:27 +0200 (CEST)
Received: from Smtp1.Lantiq.com ([195.219.66.200]:19199 "EHLO smtp1.lantiq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903548Ab2E2NFU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2012 15:05:20 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap0EADbIxE8KQLW9/2dsb2JhbABEtjyCGAEBBHkQAgEIDQEUJB8TJQIEAQ0NwESPVGADiAyEbI4QjGA
X-IronPort-AV: E=McAfee;i="5400,1158,6725"; a="208741"
Received: from unknown (HELO MUCSVECH044.lantiq.com) ([10.64.181.189])
  by smtp1.lantiq.com with ESMTP; 29 May 2012 15:05:14 +0200
Received: from MUCSE039.lantiq.com ([169.254.3.50]) by MUCSVECH044.lantiq.com
 ([10.64.181.79]) with mapi id 14.02.0247.003; Tue, 29 May 2012 15:05:20 +0200
From:   "Langer Thomas (LQDE CPE AE SW)" <thomas.langer@lantiq.com>
To:     John Crispin <blogic@openwrt.org>,
        Grant Likely <grant.likely@secretlab.ca>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "spi-devel-general@lists.sourceforge.net" 
        <spi-devel-general@lists.sourceforge.net>
Subject: RE: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Thread-Topic: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
Thread-Index: AQHNNo77Z0i1R71JSEmL/txXede8opbbEGeAgADtHACABHeJQA==
Date:   Tue, 29 May 2012 13:05:18 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6049FCE@MUCSE039.lantiq.com>
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org>
 <20120525233845.BD93C3E0BD2@localhost> <4FC0DEEC.8050204@openwrt.org>
In-Reply-To: <4FC0DEEC.8050204@openwrt.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.174.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 33476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.langer@lantiq.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello Grant, hello John,

John Crispin wrote on 2012-05-26:
> 
>> What exactly does this mean?  How does it not support any other type
>> of SPI peripheral?  SPI is a really simple protocol, so what is it
>> about this hardware that prevents it being used with other SPI
>> hardware?
>> 
>> I see a big state machine that appears to interpret the messages and
>> pretend to be an SPI slave instead of telling linux about the real
>> device.  /me wonders if it should this instead be a block device
>> driver?
>> 
> Thomas will need to comment on this part
> 
The hardware is an "EBU" (External Bus Unit) for different type of memories 
and flashes (NOR, NAND and serial).
One of the features of this EBU is the "execute in place" for serial flashes.
This shows that there is some logic in the hardware for automatic reading,
all other actions must be done using a specific cmd register.

Even if there are some restrictions from the hardware state machine,
the goal was to use the standard driver for serial flash devices (m25p80).
Otherwise, with a dedicated block device driver, we would have to duplicate
much of this code and had to maintain an own list of supported flash chips.

I hope this reason is good enough for getting this driver accepted.

Best Regards,
Thomas
