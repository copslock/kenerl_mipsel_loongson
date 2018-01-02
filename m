Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 03:28:55 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:41371
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992105AbeABC2rTX-aa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 03:28:47 +0100
Received: by mail-it0-x242.google.com with SMTP id x28so37470283ita.0;
        Mon, 01 Jan 2018 18:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mzQjM4pvk90NJUf5XjCT0UJx1yJnW8/BOAlVuT673Jc=;
        b=b0v3yzeXWh3XnofvMzbw5X9z3gI3MQlJiKL7oY+VBoRINgaAhrEND/CxM8o7WynIHa
         OAP1oZ2F3OTSoA3NG9i03/Cf6x7r8ZBxl3JQGZC8ftsyJprx8a0JhuoiFlXyAZdmQWCt
         D16mQNjcZ9ja8Y1rGz60LYcPxgzs3jdjTsxpGTONhpWWGia6dJg9GfomEL2inTOAfe3b
         TLQh85cAAamIQcbcUcdQ0FkaIX8Lzg4A67Vs74ESTufpocqWIjlsplocTdiVmVWw0Pes
         4ZVaoLseuJkOFoysJZmyq6EHqYrweELUSFYB2WeSHzJHANGnbeZ8SkR9y9ydeX8d7trJ
         zn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mzQjM4pvk90NJUf5XjCT0UJx1yJnW8/BOAlVuT673Jc=;
        b=NgCyjsgG5C2myGwCWrv1ERPrNF8sqIE3vRyoSyuGRdtV1xuDBqZJlQ5T+s93L5f+NA
         nshBFIbp/sgiP2/QYWFs/pGVUrOZFaLIJq0mLSip2vGCI5evMPfV6wE9NXCkDvve/P9O
         f0NL8pf+Fd4Ci9qRYQe7mpQrDAirD02prTCk3ZrxeNxnj6l1k//QRqCLbxPgdWrLVqw8
         ms+gLjn50TuBN0fDBIoGMC6Lip26spCmqN8MiLrLhNx5EAj4qrDv1nPQpOEOzsdNqe1s
         ZZgWwE4w2nBcKvsl1Ct6EKoYPB+EnjwCPdVJRXDE53Yq1/pj0qO+NZvy1iL+30g36coS
         POoQ==
X-Gm-Message-State: AKGB3mK0fd6X/T+JdcNtUxeb8qWeYKFehh4nX2jqHVkpPGqhC++dteTM
        Lwe5ns8ySXzzv0nOPjcjC3jer66HZOLDrbWl3yPliw==
X-Google-Smtp-Source: ACJfBotYetj6t01PABGLzLkcaSIKNjZ6jzib1GDorX6BNu078N7P4zONH8B5/BD3PhsoOqrYGklGTZB8gyvGlI0OMAo=
X-Received: by 10.36.23.212 with SMTP id 203mr60212559ith.130.1514860119898;
 Mon, 01 Jan 2018 18:28:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.152.7 with HTTP; Mon, 1 Jan 2018 18:28:39 -0800 (PST)
In-Reply-To: <20171230160928.GB3883@lst.de>
References: <20171230160928.GB3883@lst.de>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Tue, 2 Jan 2018 10:28:39 +0800
X-Google-Sender-Auth: LkKVNqIjBOSLnwfXOEfKyQmHfC4
Message-ID: <CAAhV-H4fzuocu6wx3kmTO96vY-0YkRqQboqtRVXzn7b0YZSS6Q@mail.gmail.com>
Subject: Re: mb() calls in octeon / loongson swiotlb dma_map_ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Daney <ddaney@cavium.com>, Hongliang Tao <taohl@lemote.com>,
        Hua Yan <yanh@lemote.com>, Alex Smith <alex.smith@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Loongson's code is derived from octeon. So, I also don't know whether
mb() is really needed.

Huacai

On Sun, Dec 31, 2017 at 12:09 AM, Christoph Hellwig <hch@lst.de> wrote:
> Hi David and others,
>
> I've recently been refactoring the dma direct mapping and swiotlb
> code, and one odd thing I noticed is that the octeon and loongson
> swiotlb ops have mb() calls after basically all swiotlb calls.
>
> None of that is explained in either the earlier octeon dma map
> commits, nor the commit that added the octeon swiotlb support
> (b93b2abce497873be97d765b848e0a955d29f200), and neither in the
> loonsoon commit that apparently copy and pasted it
> (1299b0e05e106f621fff1504df5251f2a678097e).
>
> Can someone explain what these memory barrier are supposed to do?
>
