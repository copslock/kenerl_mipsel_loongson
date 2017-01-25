Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2017 10:04:52 +0100 (CET)
Received: from mail-yb0-x242.google.com ([IPv6:2607:f8b0:4002:c09::242]:36248
        "EHLO mail-yb0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993021AbdAYJEnUvziC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2017 10:04:43 +0100
Received: by mail-yb0-x242.google.com with SMTP id f67so141877ybc.3
        for <linux-mips@linux-mips.org>; Wed, 25 Jan 2017 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mPgDNHJ9js39Y2Q3nbyRJrDFUdtymn9kNrXZXsNoqv0=;
        b=aIB3cNrkHf+PRiXgIfH/vYQcfdRjkwOVtLNDCPgHt5F+XkYc+m1j0TobgBiiuIAC/q
         uNmUD3ms59tfqoaHHFIBg2ozdFxuTyvBnf9BGjfk50DEKKBuPObRrSQ3vu59aw7d8N7u
         aaH30ByCA17UnuphCQDXheNR7vDLrg81GAJq7nOwcaL31RZJRuKStseOLu3+qxZZ3lgv
         I5WgN6KJlvb1V64ZwzPHllkLNlJIsUyZhQZr9RhWslChzvtUWwprRk8USB8ct0MtKpHY
         yMJrlyHCd95yfRGaYj4IuvpTB7GGVSok6JXK3+9e0RmUyt1rABzQA13+ya8Pvp8fqbkq
         NqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mPgDNHJ9js39Y2Q3nbyRJrDFUdtymn9kNrXZXsNoqv0=;
        b=sq2GTOp6UjhOZkYyfAwr/8XeSDmbQiPNYGUJbmkWNPfF7VlIbq5VGRs4e0MSTc911o
         t4tcJ2qKjW9z961nMfGK0nT5NnSxgo9i1hWqvtSEbY9yocx662NE5eKGr0yf0cWE1Oba
         BgCi0wE9rPSv0Wi92jSxOIddMZZODHixvBIH8uWMsCmJb05qwkLyEBIlkCpdeS/DNCF1
         xJgvyiVjEwQfNbTghWWMEZ12Rol/nTb4T9CH0p61HROtxJAiHgWsUghVADNZ9Riorijn
         RdNohAMVptmVlFkkUXsX3WzKOtGC2n4FvgIAbFj+Jy1zMJAsngIzdrEZgNCVvD1fqGpS
         zeYg==
X-Gm-Message-State: AIkVDXLWL8t8ObxPU5ooo6dMwHue5oW3Ylv08iEAETVkzhRDNaAKYYYaP1V4HEfs5nF+xBDeRnEvrHJJZZ8aZg==
X-Received: by 10.37.39.137 with SMTP id n131mr29170595ybn.10.1485335077551;
 Wed, 25 Jan 2017 01:04:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.192.68 with HTTP; Wed, 25 Jan 2017 01:04:37 -0800 (PST)
In-Reply-To: <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de>
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com> <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de>
From:   Seb <sebtx452@gmail.com>
Date:   Wed, 25 Jan 2017 10:04:37 +0100
Message-ID: <CA+hF=GdKLEN2ue=Q7KpBp+W+bTnj5O_OAoPjuDOScga2efnjPA@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56486
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

Hello,


> I would prefer to use a device tree option to activate this check and
> only access LTQ_EBU_BUSCON0 when this property is set.

If I understand correctly, I have to make something like this :

---

bool mtd_addr_swap=true;

        if (!of_machine_is_compatible("lantiq,falcon") &&
                of_find_property(pdev->dev.of_node,
"lantiq,ebu_swap_check", NULL))
                if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_FLASH_ENDIAN_SWAP)
                        mtd_addr_swap = false;

---

And then set this property directly on my device-specific dts file ?
