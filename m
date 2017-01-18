Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 18:12:21 +0100 (CET)
Received: from mail-yw0-x230.google.com ([IPv6:2607:f8b0:4002:c05::230]:34744
        "EHLO mail-yw0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdARRMPYIzod (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jan 2017 18:12:15 +0100
Received: by mail-yw0-x230.google.com with SMTP id w75so12430125ywg.1
        for <linux-mips@linux-mips.org>; Wed, 18 Jan 2017 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fYsukCUo7XADslzQfmzHcaX6JeAyT4IZUDiusyfB9Lg=;
        b=fLHRnht5kjcqU+PP6EMJO7J+txXudaRcp2V2ts0IEcHtb5GDy+eilmrTx21ZiAnTxt
         O0HkMMGXl5IuefUTGKmQbyyvsJsHgt2QdvJd5O4wSozvx52NJWSqdWlwsFmSw58PLCfk
         aQD/9OF8CzM25DOWIkyjxjKFRK8SjPGDk0UqR6f9+C8hiPH/Nm2MwY88RY3EvbVn+rNa
         1Ts98QiiiFMvxLP8sinLE+HNIJBHvT/TGw9t79xeFf9eFn+ZuEd0zxojYfyWSpQjxy+G
         xMLtY0TiOGFGEIfjtHYLCmJW3e3JOxf7uu3wCfd9Rlvtz/ksxlMUhuGLLOmuxe9gVSlq
         VXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fYsukCUo7XADslzQfmzHcaX6JeAyT4IZUDiusyfB9Lg=;
        b=l+8YnnjDDtUDr/ppUDEk0/SDMupeziBmubXLoCKiB6bDDqypkuTmvN5P2IdKoh0SuV
         nZLDRM9WL9nCPVqeT7KqLiP92cgWr4pIfYfAExTdM03piHVewy5YDRsP/DyJrFSO01yt
         dEIEFvhOAeG+osWNEP72M301QF4aSJ1+knume0PM5eX8n9alg7HAg6uf3KQPPwUkSPCb
         OWMdfTSaGpgXf2AGcoBNVqAzxALv/hINwz+oCaFopMGV6Lxqe+2KgyhWqcgixbG9RgLh
         RV8Qq4v68tJQiUr3sv74NZG2Bbrnh6RWHZWXerzOniKjQagUlVWZoV0VOIiCXwwJ/474
         e7+Q==
X-Gm-Message-State: AIkVDXKuD++GMJXrCo00Ax27XdSkS1ip0UBiEiQ9aCyz58Ile5Eh0TB9H9GZyp2924sB+lUed6lKm9DigIiizQ==
X-Received: by 10.13.212.149 with SMTP id w143mr3658469ywd.180.1484759529711;
 Wed, 18 Jan 2017 09:12:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.192.68 with HTTP; Wed, 18 Jan 2017 09:12:09 -0800 (PST)
In-Reply-To: <845374ff-62b0-983b-b399-4965421a9066@phrozen.org>
References: <1484741452-27141-1-git-send-email-sebtx452@gmail.com>
 <e5bb2245-a0d0-5b66-2c75-9af26c6ea846@phrozen.org> <CA+hF=GeD0dhBUkR+wR_35pSXgSnU0kW6EfYWa9h2QrGOTReMnA@mail.gmail.com>
 <845374ff-62b0-983b-b399-4965421a9066@phrozen.org>
From:   Seb <sebtx452@gmail.com>
Date:   Wed, 18 Jan 2017 18:12:09 +0100
Message-ID: <CA+hF=Gc5ZBLqo65fbchZeqtyEUgH-kdqpf8i3A-Z5nFTt58a4A@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     John Crispin <john@phrozen.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebtx452@gmail.com
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

> the bug is also fixed on the 300 and 500 series chips, so we would want
> to check for that aswell.
>

I added this to the begin of "ltq_mtd_probe" function:

bool mtd_addr_swap;

        if ( ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_ENDIAN_SWAP ) {
                switch (ltq_soc_type()) {
                        case SOC_TYPE_VR9_2 :
                        case SOC_TYPE_AR10 :
                                mtd_addr_swap = false;
                                break;
                        default :
                                mtd_addr_swap = true;
                }
        } else mtd_addr_swap = true;


It's easier to add other architectures as needed. I tried it on my
OpenWrt release, and got it working fine. Is it correct in this way ?
