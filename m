Return-Path: <SRS0=1crz=QO=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A54C282C2
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 15:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EAA21904
	for <linux-mips@archiver.kernel.org>; Thu,  7 Feb 2019 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P2XAeqCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfBGPCQ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:02:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53043 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBGPCQ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 7 Feb 2019 10:02:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190207150215euoutp01598484943c4b89809d679556cd4f9b64~BHRfh47eL2733027330euoutp01I
        for <linux-mips@vger.kernel.org>; Thu,  7 Feb 2019 15:02:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190207150215euoutp01598484943c4b89809d679556cd4f9b64~BHRfh47eL2733027330euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549551735;
        bh=TWg2qNt9N7rdOfhdgeICGOCK++MML2U91rv3yMdgOec=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P2XAeqCBqY9kvjIWEurlqoPlPtyJlgyC0UBZtlN4opAsFSaK9sqWokbpgKVOjDwrk
         21jbg5wSWbevuh78itHf1LMoxwQlcw9MgQcNkydYBO/gnL28o2v9WNeLQy7uWU6bUj
         xLptbuwTAnYUHZjy4JrGfLa8jjRzWPSzAJqYnzyw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190207150214eucas1p24a59bfd30ecb118f22ceb5ddacec8396~BHRfLSfGw0761907619eucas1p2H;
        Thu,  7 Feb 2019 15:02:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id BB.38.04441.6784C5C5; Thu,  7
        Feb 2019 15:02:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190207150214eucas1p19c563f804ce02178ae58aa957854a445~BHRecGXin3182231822eucas1p1c;
        Thu,  7 Feb 2019 15:02:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190207150213eusmtrp163fd53667a6abba3204ffdb54f781ba5~BHReN7U_U0678406784eusmtrp1R;
        Thu,  7 Feb 2019 15:02:13 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-ae-5c5c48767934
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.CB.04128.5784C5C5; Thu,  7
        Feb 2019 15:02:13 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190207150213eusmtip2be5283c534b1682e331abee35eab46fe~BHRd90OMr0333603336eusmtip2w;
        Thu,  7 Feb 2019 15:02:13 +0000 (GMT)
Subject: Re: Loongson 2F IDE/ATA broken with lemote2f_defconfig
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <66a23e7c-2ba8-b505-8382-d13c1912ea88@samsung.com>
Date:   Thu, 7 Feb 2019 16:02:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190126184351.GE2792@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzned0yj5gYgxs7lSzWvHCwWH23n83i
        2I5HTBadm7YyOrB4HP66kMXj8tlSj8+b5AKYo7hsUlJzMstSi/TtErgyri96wFrwR7Li3ooW
        xgbGmyJdjJwcEgImEqc2rmXtYuTiEBJYwSjRM3c+M4TzhVFi0ck5TCBVQgKfGSXevOOD6Vh6
        6ChU0XJGiflNnVDOe0aJXxPuMoJUCQvYS6z4PBvMFhHQkHi1r58VxGYWiJQ4t6MFzGYTsJKY
        2L4KrIZXwE6iYTJEL4uAisTBWzNZuhg5OEQFIiT6z6hDlAhKnJz5hAXE5gQqn3hpESPESAOJ
        I4vmQI2Xl9j+dg7YPRICv9kkbs/6wgRxtYvEz3uH2SFsYYlXx7dA2TISpyf3sEA0TAf68tdS
        KGc9o8SaM8eguq0lDh+/yAphO0q07+hnA7lOQoBP4sZbQYjNfBKTtk1nhgjzSnS0CUFUq0ls
        WLaBDWZX186VzBC2h8SbR01sExgVZyH5bRaSf2Yh+WcBI/MqRvHU0uLc9NRiw7zUcr3ixNzi
        0rx0veT83E2MwMRx+t/xTzsYv15KOsQowMGoxMN7QTsmRog1say4MvcQowQHs5IIb5ULUIg3
        JbGyKrUoP76oNCe1+BCjNAeLkjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVANjXUJL8i/1FA+j
        HQXxOZ/fHoyyvnWV1eFm1tk37MsKisr/9GSKrPFXjzjp7rNbxv9zsIsGp7jSxVy9/jNOcsU3
        5eLnRaopeM99699quLgg6lGTevhSa7Evh6pD7ITtjW+s2WpZeVLhXv/dPTqs96RuPzry8vED
        T7+sk6rH7r/f18+spTHTW0WJpTgj0VCLuag4EQC37tvQGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4Pd1Sj5gYg7MXdS3WvHCwWH23n83i
        2I5HTBadm7YyOrB4HP66kMXj8tlSj8+b5AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws
        9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyri96wFrwR7Li3ooWxgbGmyJdjJwcEgImEksPHWXu
        YuTiEBJYyihx48c6li5GDqCEjMTx9WUQNcISf651sUHUvGWU2H9rHRtIQljAXmLF59mMILaI
        gIbEq339rBBFG5gkPlyewwKSYBaIlLg99xsziM0mYCUxsX0VWAOvgJ1Ew+S7YDaLgIrEwVsz
        wepFBSIkbj3sYIGoEZQ4OfMJmM0JVD/x0iJGiJl6Ejuu/2KFsOUltr+dwzyBUXAWkpZZSMpm
        ISlbwMi8ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzAeth37uWUHY9e74EOMAhyMSjy8F7Rj
        YoRYE8uKK3MPMUpwMCuJ8Fa5AIV4UxIrq1KL8uOLSnNSiw8xmgI9MZFZSjQ5HxireSXxhqaG
        5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGKVEFfb8Xhwod4mh8E9Qwjux
        riW/tn5qtz11hpNTZd79qdt2r3vffzbmrbpS1t4Hcv/j98Q6bY44MkvvuU7r1abLrCnlFYKn
        7oeaawckn/LWz59/9t/raawy1hcTT2YeYDwSetvSRTmoz+zSTGsD3fcWy1WSzQ4Fb5/Ht/tk
        SlRPxcmF5SuvTFNiKc5INNRiLipOBACdA8mlnQIAAA==
X-CMS-MailID: 20190207150214eucas1p19c563f804ce02178ae58aa957854a445
X-Msg-Generator: CA
X-RootMTR: 20190112152659epcas5p3953165de5118dba017c94b164dd725a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190112152659epcas5p3953165de5118dba017c94b164dd725a2
References: <20190106124607.GK27785@darkstar.musicnaut.iki.fi>
        <CGME20190112152659epcas5p3953165de5118dba017c94b164dd725a2@epcas5p3.samsung.com>
        <20190112152609.GE22416@darkstar.musicnaut.iki.fi>
        <08c48218-2bc5-a100-4b01-edb08b4225c4@samsung.com>
        <20190126184351.GE2792@darkstar.musicnaut.iki.fi>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org


On 01/26/2019 07:43 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Jan 14, 2019 at 02:16:42PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> On 01/12/2019 04:26 PM, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> On Sun, Jan 06, 2019 at 02:46:07PM +0200, Aaro Koskinen wrote:
>>>> Commit 7ff7a5b1bfff ("MIPS: lemote2f_defconfig: Convert to use libata
>>>> PATA drivers") switched from IDE to libata PATA on Loongson 2F, but
>>>> neither PATA_AMD or PATA_CS5536 work well on this platform compared
>>>> to the AMD74XX IDE driver.
>>
>> Sorry about that.
>>
>>>> During the ATA init/probe there is interrupt storm from irq 14, and
>>>> majority of system boots end up with "nobody cared... IRQ disabled".
>>>> So the result is a very slow disk access.
>>>>
>>>> It seems that the interrupt gets crazy after the port freeze done early
>>>> during the init, and for whatever reason it cannot be cleared.
>>>>
>>>> With the below workaround I was able to boot the system normally. I
>>>> guess that rather than going back to old IDE driver, we should just try
>>>> to make pata_cs5536 work (and forget PATA AMD on this board)...?
>>>
>>> Hmm, even with this hack I get ~500 spurious IRQs during the boot.
>>>
>>> Also compared to old IDE, there's 33 vs 100 speed difference:
>>>
>>> [    3.324000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
>>> [    3.584000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
>>> [    3.588000] ata1.00: 312581808 sectors, multi 16: LBA48
>>> [    3.592000] ata1.00: limited to UDMA/33 due to 40-wire cable
>>>
>>> [    4.540000] Probing IDE interface ide0...
>>> [    4.992000] hda: WDC WD1600BEVS-00VAT0, ATA DISK drive
>>> [    5.716000] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
>>> [    5.716000] hda: UDMA/100 mode selected
>>
>> Can you try booting with "libata.force=1:80c" (and if that doesn't work with
>> "libata.force=1:short40c")
> 
> (Sorry for delay, this machine is in use so I couldn't reboot it randomly...)
> 
> OK, the speed issue can be fixed with command line. So "libata.force=1:80c"
> works with cs5536 libata driver.
> 
>> and also provide full dmesg-s for working (ide) and not working
>> (libata) kernels.
> 
> Logs are below:
> 
> 1) working IDE (no spurious IRQs)
> 2) working PATA AMD (around ~90k spurious IRQs, so it's just a matter of luck)
> 3) failing PATA AMD (100k spurious IRQs reached)
> 4) working PATA CS5536 (same as with PATA AMD)
> 5) failing PATA CS5536 (same as with PATA AMD)

Thank you.

I've looked a bit more into the problem and came with two possible
approaches to investigate it further:

* The major difference between IDE and libata during probing is that
  IDE keeps the port's IRQ (if known) disabled during whole probe time.

  To replicate this behavior in libata it seems that we would need
  to cache IRQ number used in ap->irq, then call disable_irq(ap->irq)
  when ATA_PFLAG_LOADING flag is set and enable_irq(ap->irq) when
  ATA_PFLAG_LOADING is cleared.

* The other idea is to try to modify your workaround patch to implement
  dummy ->sff_set_devctl helper ("empty" one) instead of adding custom
  version of ->freeze one.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
