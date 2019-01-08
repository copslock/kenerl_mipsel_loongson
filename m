Return-Path: <SRS0=z0u9=PQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3841C43387
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79724206BB
	for <linux-mips@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfAHTzp (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:55:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:44471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbfAHTzo (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 8 Jan 2019 14:55:44 -0500
Received: from [192.168.178.28] ([31.18.251.131]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3u86-1hYVvh2zSM-00rYXL; Tue, 08
 Jan 2019 20:55:35 +0100
Subject: Re: MIPS: ath79: net boot related regressions
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Crispin <john@phrozen.org>,
        "antonynpavlov@gmail.com" <antonynpavlov@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
References: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
 <de5f0808-11e2-0e7c-573d-327b66235e86@rempel-privat.de>
 <EC57E8B2-0E44-45F6-9D23-8FE41A1CC76E@hammerspace.com>
From:   Oleksij Rempel <linux@rempel-privat.de>
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 rnzn0GXR0xYSTiUvuvpLsoo=
Message-ID: <4cb50484-77ee-4d85-fdc5-aeef88db48e2@rempel-privat.de>
Date:   Tue, 8 Jan 2019 20:55:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <EC57E8B2-0E44-45F6-9D23-8FE41A1CC76E@hammerspace.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Df8/B8YiEzG6EfwR7OfjnHzk2CIR4XFPJ2KIQFo7U+MsvgwFzAx
 7KJ4g0vXBZvi1rHRwjgAFR7S3ScVIDD72E5LzlBR7JAY4IxMYgKzLaeUR67wap9wWwCpXUq
 qSSGFx1QjescP473loDHT14nuFhQJyrcay3gN46opOJLFwoa6Zh+/72Jd0W8s3oINd/vPb7
 F8aI1TYCrZIXwdMQhjxRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N7BlrxaLVnw=:HPC8L7lf6zzOUSUHThCPtK
 HeWkAJmhXA4qTtH4rQHXWfF7/+jH5dpszO6vxIKJkoHJ4GT/flaeE9sMU34CmlJL4hnNMWJPr
 fZEQXbA36zuGIytWA8gubfRqgNjiLADMJxGBYGR1ngqEvXU0SHUOrOOFYbcPECX4u05nP7Tt7
 6m/R4xancp0L7mIzpzafsbGn5i+26lXUnTmNwYWHAeq/jUlB75spqk5HU4UagsOwOM6HcJ7Hd
 CQdJv2xVe8mZoxvuBW/PYIxmh7si962Nzrv977vFtt7yX62oYNK8gM3xSdUYQH3X6Cm/P+UuH
 rTRyrd7NQ8rxqTU62oWYtwa66neD0wxZg1EJ003zxImQb8dJ88EkYH2cTHo0j0hvu4nTWwyQI
 Yd1sH3thus19iiKUUgp+F7hdvKd26/+Zz+S49K2bucjQmUCPpQjjvt5W7LD8wwPP4lcB9KrBi
 KPMET0APY5for7eLqfMlfk74Kv010nTDA5fLn1L92DP4Qsj4NunLsUd2/A5kc+uUMtQFwA9wV
 oefsreK19XtKndI5ErWySHAr+puWY/ZSO7Z6kwjWL2WrMLddSsR5Q46WwN6YKYhMfSiypybhW
 Z0SOFJRiB4ZjJOKJ/M4jYbogRpx4e2b2zrLwvq53++Cgvnf8taVnWjHM0ctm/JjzKMLhPkJ3V
 9WT5Bebuh8ZuX0lWYlxqlfFjP2JnX3dd/FpywhEPlhiz1hd/B7gqlSa1/gaudnNvsBX/PbYzL
 BTZGY1GERdd3qYShzhb6skHEinibjOCTJuKHuZiZunS+wqq6NAGyLvT84+0yNLaOOkV0GQdks
 pRs3f0bJ61PfJjDtQTTnxEjzFCUqaHvzW01079A+dNhQKfMQYGVQbQNxibD1KAOzncjH7weRX
 MR1MwDqY9MVNmd6OvyG0jtVEeh7mYxvmAmw085FXCIHaJ2R/IkzI+pgEsL9Np6epkDtJ8tU4N
 z8AaV/GSPwg==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Am 08.01.19 um 19:19 schrieb Trond Myklebust:
> 
> 
>> On Jan 8, 2019, at 13:02, Oleksij Rempel <linux@rempel-privat.de> wrote:
>> First patch seems to be:
>> commit 277e4ab7d530bf287e02b65cfcd3ea8f489784f6 (HEAD, refs/bisect/bad)
>> Author: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Date:   Fri Sep 14 09:49:06 2018 -0400
>>
>>    SUNRPC: Simplify TCP receive code by switching to using iterators
>>
>>    Most of this code should also be reusable with other socket types.
>>
>>    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>>
>> nfs-for-4.20-6 tag do not have fixes covering this issue. @Trond, can
>> you please help me here?
> 
> 
> Please see https://lore.kernel.org/linux-nfs/20190103140445.22627-1-trond.myklebust@hammerspace.com/T/#u

Thx! It works. Finally I can run v4.20 :)

-- 
Regards,
Oleksij
