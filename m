Return-Path: <SRS0=xLsO=X6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8261C47404
	for <linux-mips@archiver.kernel.org>; Sat,  5 Oct 2019 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9CE222C8
	for <linux-mips@archiver.kernel.org>; Sat,  5 Oct 2019 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570315987;
	bh=k9W9AySitGNzm1RzoSH//i2l8YT8O/lqvo+qY8bLW7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YNWCsxc7Q9WekuDZ6SVxMicgf+8pMqceYHmWJKG1zaazKmhAzH37u8NoQ49Osh4iK
	 cijIksQnK3rxFDRxSfobJVAhjOO8rBzSx2Sh3k8duU/FzsCOw+z99RTm30ylD2fR3G
	 /mOOnVo/2U6yhi0qIBN3hwuvDQVRntqp9pC/Ymyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfJEWxH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 5 Oct 2019 18:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJEWxH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 5 Oct 2019 18:53:07 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD7D222C5;
        Sat,  5 Oct 2019 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570315986;
        bh=k9W9AySitGNzm1RzoSH//i2l8YT8O/lqvo+qY8bLW7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ajpIKm5hu2sdmUnD4bpncHoDDpRdb8JZPMgAXHvjDsQdSZk3OGS5oiyovkmwZFHA
         aWA2EMFSO8p9t45kQ89+PIqNi0AraJesoB6nn1QPW0nWJWdl/4ctZJjlLHBrdNW5gf
         YDIi8jhCfHXgMu1T1gpD95GWbx1b9bOs3UsxRjUI=
Date:   Sat, 5 Oct 2019 18:53:05 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        joe@perches.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.3 20/49] firmware: bcm47xx_nvram: Correct
 size_t printf format
Message-ID: <20191005225305.GA25255@sasha-vm>
References: <20190929173053.8400-1-sashal@kernel.org>
 <20190929173053.8400-20-sashal@kernel.org>
 <feb780d4-c9f7-b662-729c-babd361b223e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <feb780d4-c9f7-b662-729c-babd361b223e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Sun, Sep 29, 2019 at 12:39:05PM -0700, Florian Fainelli wrote:
>
>
>On 9/29/2019 10:30 AM, Sasha Levin wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>>
>> [ Upstream commit feb4eb060c3aecc3c5076bebe699cd09f1133c41 ]
>>
>> When building on a 64-bit host, we will get warnings like those:
>>
>> drivers/firmware/broadcom/bcm47xx_nvram.c:103:3: note: in expansion of macro 'pr_err'
>>    pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>>    ^~~~~~
>> drivers/firmware/broadcom/bcm47xx_nvram.c:103:28: note: format string is defined here
>>    pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
>>                            ~^
>>                            %li
>>
>> Use %zu instead for that purpose.
>
>This is not a fix that should be backported as it was done only to allow
>the driver to the made buildable with COMPILE_TEST. Please drop it from
>your auto-selection.

Now dropped, thank you!

-- 
Thanks,
Sasha
