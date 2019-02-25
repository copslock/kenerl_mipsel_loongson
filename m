Return-Path: <SRS0=DhUk=RA=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4358AC43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 06:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0045420842
	for <linux-mips@archiver.kernel.org>; Mon, 25 Feb 2019 06:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="MhMmU1TK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfBYGFe (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:05:34 -0500
Received: from [115.28.160.31] ([115.28.160.31]:55838 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfBYGFe (ORCPT
        <rfc822;linux-mips@vger.kernel.org>);
        Mon, 25 Feb 2019 01:05:34 -0500
Received: from hanazono.local (unknown [116.236.177.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 411FC600AB;
        Mon, 25 Feb 2019 14:05:29 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1551074729; bh=ujrrzKwt/R4ZIGb1w7aIY2gWPXW9ZhKtsF6s90WkrCs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MhMmU1TKoGISNFFg2BFb7t42xLpgRjVkFMXUY4noOYeimjL4Snbbxyp2/ksEVoeWj
         Tx76OnKWKLkq5pbuFHOliyxldfwUCoLFzxSsvcu0Y71Ohfrul2aiPAY5hgm8d0Om8g
         EG+ifpHAZknvUpiYTzZVBAy3bhM0fNp3twoL7/mo=
Subject: Re: [RFC PATCH 0/2] MIPS: Loongson: ExtCC clocksource support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wang Xuerui <wangxuerui@qiniu.com>,
        Huacai Chen <chenhc@lemote.com>
References: <20190225082840.SZReoeJx@smtp4o.mail.yandex.net>
From:   Wang Xuerui <kernel@xen0n.name>
Message-ID: <b17d7490-3067-8e65-6f00-fe10628c5adb@xen0n.name>
Date:   Mon, 25 Feb 2019 14:05:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:67.0)
 Gecko/20100101 Thunderbird/67.0a1
MIME-Version: 1.0
In-Reply-To: <20190225082840.SZReoeJx@smtp4o.mail.yandex.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 2019/2/25 13:28, Jiaxun Yang wrote:

>
> 2019年2月24日 下午5:36于 kernel@xen0n.name写道：
>> From: Wang Xuerui <wangxuerui@qiniu.com>
>>
>> Hi,
>>
>> This is my WIP patchset to add support for using the on-chip ExtCC
>> (external counter) register as clocksource, to boost the real-time
>> performance on Loongson platform. I'm posting this to solicit comments
>> and get some of the unresolved questions answered.
> Hi Xuerui
>
> Thanks a lot for your works, however, the ExtCC can be influenced by the frequency of CPU core, and we have cpufreq working on Loongson-3 processors, so you should mark it conflict with cpufreq driver.
>
> And as far as I know, ExtCC is even not synchronous between different cores.
>
> I'd prefer to use gs3_HPT(0x3ff00408)  register to implement this feather. Also it can be accessed from all the nodes, and the clock comes from "node clock" which will not effected by core frequency.

This is interesting, but according to Section 2.4.3 of the 3A3000 User 
Manual (Vol. 2), the ExtCC register is explicitly stated to be 
core-frequency-independent.

Maybe you confused ExtCC with Count (rdhwr with rd=2), of which update 
freq does vary with core freq?

