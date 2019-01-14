Return-Path: <SRS0=henU=PW=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98841C43387
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 13:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D120659
	for <linux-mips@archiver.kernel.org>; Mon, 14 Jan 2019 13:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IPuevjze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfANNQu (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:16:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34624 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfANNQt (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 14 Jan 2019 08:16:49 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190114131648euoutp01cb7ecb57c357ce15e42da1a48d0bc292~5uWkrakYV2798527985euoutp01O
        for <linux-mips@vger.kernel.org>; Mon, 14 Jan 2019 13:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190114131648euoutp01cb7ecb57c357ce15e42da1a48d0bc292~5uWkrakYV2798527985euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547471808;
        bh=1eUuB1GZ4HqYvP6j8pui+QCIf8jIQBMfzuH3Zl0Ga8s=;
        h=Subject:To:From:Cc:Date:In-Reply-To:References:From;
        b=IPuevjzepl3gHaDdHsx04NtmkH6nnceBPc+GxbtzlHpdkAkFLqu7mjODBZAxk7IMf
         xuPgiMHg38wE/3APqWZVcxOP+3NBnGLeSQGBmafWVfJezfb95LTvlaSs2q1Xor7A/D
         LDlN7XB1eiHUlwnUShf3WplFMW+inJIXa7J+Fe+g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190114131647eucas1p2fec5248904b783a33ec1373be5cf6ac3~5uWkBdpQF0545405454eucas1p2r;
        Mon, 14 Jan 2019 13:16:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B0.70.04441.FBB8C3C5; Mon, 14
        Jan 2019 13:16:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190114131646eucas1p163e134a42a757c55aa011b11f54fc344~5uWjUmjUd1130711307eucas1p1R;
        Mon, 14 Jan 2019 13:16:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190114131646eusmtrp1254d8e17cc533db421a960755debad3d~5uWjGWS6c1615816158eusmtrp1t;
        Mon, 14 Jan 2019 13:16:46 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-50-5c3c8bbfc1a8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.EC.04284.EBB8C3C5; Mon, 14
        Jan 2019 13:16:46 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190114131646eusmtip1f267994b43e15a0301526e418cc91526~5uWi1FkaW2170521705eusmtip1F;
        Mon, 14 Jan 2019 13:16:46 +0000 (GMT)
Subject: Re: Loongson 2F IDE/ATA broken with lemote2f_defconfig
To:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mips@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Message-ID: <08c48218-2bc5-a100-4b01-edb08b4225c4@samsung.com>
Date:   Mon, 14 Jan 2019 14:16:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190112152609.GE22416@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned393TYxBle+ilqseeFgsfpuP5vF
        sR2PmCw6N21ldGDxOPx1IYvH5bOlHp83yQUwR3HZpKTmZJalFunbJXBlXFj5mbWghb+i9dsc
        tgbGH9xdjJwcEgImEjs2HWbtYuTiEBJYwSjx/vpXJgjnC6PEwiMvoDKfGSVmXFzFDNPy8t4f
        qMRyRolvN86zQzjvGSUWbLvPCFIlLGAvseLzbDBbRMBFYvmXSewgNpuAlcTE9lVgcWYBa4nZ
        i9czgdi8AnYSbbM2sYLYLAKqEj/eXQfaxsEhKhAh0X9GHaJEUOLkzCcsIGFOoPFr5zFDTDGQ
        OLJoDiuELS+x/e0cZpBzJAR+s0mcPf2GDeJoF4lN/1ZB2cISr45vYYewZSROT+5hgWiYzijx
        5tdSKGc9o8SaM8eYIKqsJQ4fv8gKYTtKtO/oZwO5QkKAT+LGW0GIzXwSk7ZNZ4YI80p0tAlB
        VKtJbFi2gQ1mV9fOldBA9JB486iJbQKj4iwkr81C8s8sJP8sYGRexSieWlqcm55abJiXWq5X
        nJhbXJqXrpecn7uJEZg4Tv87/mkH49dLSYcYBTgYlXh4JWZbxwixJpYVV+YeYpTgYFYS4S1z
        sokR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzlvN8CBaSCA9sSQ1OzW1ILUIJsvEwSnVwBh8w0Ho
        9olj5uvPefvOP/qSbWI1u0jG7OOxr0XCPu7NZHM92cY95UZC/AzjtZv+M3fvOeQxK2VX+Pe7
        1jdnTr5teKItpEQ/L1vibqXmz4Pxqdl3z8xlCJ6wrufZ24MKTovK/y68vzq7gdFnf39HrPGU
        rVrJYulaUnbFRSvX87PY/Z8y+fIkqclKLMUZiYZazEXFiQCYj+7IGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Xd193TYxBs/+KluseeFgsfpuP5vF
        sR2PmCw6N21ldGDxOPx1IYvH5bOlHp83yQUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY
        6hkam8daGZkq6dvZpKTmZJalFunbJehlXFj5mbWghb+i9dsctgbGH9xdjJwcEgImEi/v/WHt
        YuTiEBJYyijxtO0oWxcjB1BCRuL4+jKIGmGJP9e62CBq3jJKXF+1gB0kISxgL7Hi82xGEFtE
        wEVi+ZdJ7BBFxxklJnYcYQJJsAlYSUxsXwVWxCxgLTF78XqwOK+AnUTbrE2sIDaLgKrEj3fX
        mUFsUYEIiVsPO1ggagQlTs58wgJyECfQsrXzmCHG6EnsuP6LFcKWl9j+dg7zBEbBWUg6ZiEp
        m4WkbAEj8ypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAaNh27OfmHYyXNgYfYhTgYFTi4ZWY
        bR0jxJpYVlyZe4hRgoNZSYS3zMkmRog3JbGyKrUoP76oNCe1+BCjKdAPE5mlRJPzgZGaVxJv
        aGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBMWbd1kmtKxbUxUYlb78e
        qvz2fvQthtPh8z4eqixkOHGCt+Gzg1jkpstO+5/ncjuExQlHROyoWbDCJv/3tNbLTMnMm8W0
        Y3wOLF4p2lC/wuso90uWlVM23f64YlGZu1bOInet+PmCk6J2TBG8999n4QzJkIe337nGzmIS
        +M1eomShsP5Sxb5b+5VYijMSDbWYi4oTAYdQEPOcAgAA
X-CMS-MailID: 20190114131646eucas1p163e134a42a757c55aa011b11f54fc344
X-Msg-Generator: CA
X-RootMTR: 20190112152659epcas5p3953165de5118dba017c94b164dd725a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190112152659epcas5p3953165de5118dba017c94b164dd725a2
References: <20190106124607.GK27785@darkstar.musicnaut.iki.fi>
        <CGME20190112152659epcas5p3953165de5118dba017c94b164dd725a2@epcas5p3.samsung.com>
        <20190112152609.GE22416@darkstar.musicnaut.iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


Hi,

On 01/12/2019 04:26 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Jan 06, 2019 at 02:46:07PM +0200, Aaro Koskinen wrote:
>> Commit 7ff7a5b1bfff ("MIPS: lemote2f_defconfig: Convert to use libata
>> PATA drivers") switched from IDE to libata PATA on Loongson 2F, but
>> neither PATA_AMD or PATA_CS5536 work well on this platform compared
>> to the AMD74XX IDE driver.

Sorry about that.

>> During the ATA init/probe there is interrupt storm from irq 14, and
>> majority of system boots end up with "nobody cared... IRQ disabled".
>> So the result is a very slow disk access.
>>
>> It seems that the interrupt gets crazy after the port freeze done early
>> during the init, and for whatever reason it cannot be cleared.
>>
>> With the below workaround I was able to boot the system normally. I
>> guess that rather than going back to old IDE driver, we should just try
>> to make pata_cs5536 work (and forget PATA AMD on this board)...?
> 
> Hmm, even with this hack I get ~500 spurious IRQs during the boot.
> 
> Also compared to old IDE, there's 33 vs 100 speed difference:
> 
> [    3.324000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
> [    3.584000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
> [    3.588000] ata1.00: 312581808 sectors, multi 16: LBA48
> [    3.592000] ata1.00: limited to UDMA/33 due to 40-wire cable
> 
> [    4.540000] Probing IDE interface ide0...
> [    4.992000] hda: WDC WD1600BEVS-00VAT0, ATA DISK drive
> [    5.716000] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> [    5.716000] hda: UDMA/100 mode selected

Can you try booting with "libata.force=1:80c" (and if that doesn't work with
"libata.force=1:short40c") and also provide full dmesg-s for working (ide) and
not working (libata) kernels.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
