Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2012 09:49:56 +0100 (CET)
Received: from mail-we0-f175.google.com ([74.125.82.175]:49318 "EHLO
        mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817293Ab2L0ItvfA6gW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Dec 2012 09:49:51 +0100
Received: by mail-we0-f175.google.com with SMTP id z53so4445648wey.34
        for <multiple recipients>; Thu, 27 Dec 2012 00:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LZq5sdpqm08SPOg6AR0ayOMar1jdxiMbx8Y3qS1Ygas=;
        b=ZxiY87jyVUNZFff6YfNNZUz4AOC2F0QFNYJm9nhuFbM1KVF20U8lw9Hs+Xu2rw5EMI
         IuTv6MA7Nbd7g1uQerdKvvIXxepFbZyyj1kZpHqB4tpAIRMLSm7nZof9AWPvNtbji46K
         vHgf1ljPNCUR2YniBZUR8Z+8WUTtHPIQgiBV1D4LNgbShpmsbdXUL2pqFKSPvgRlPBxT
         neMb1XNyhCvsTTj2DmdXZLISRdbKaIx54E/zgv9TdqR7Fnxa8MRfSHVEMGxH7dIKbCII
         eEK3mQXvcKCqlXaWAndekBJj7LfvNG6mXUXIKQnPlPx6DXq+wEoQLOZyh5cKlS3Wsvcc
         RGyA==
MIME-Version: 1.0
Received: by 10.180.86.36 with SMTP id m4mr46505513wiz.5.1356598186133; Thu,
 27 Dec 2012 00:49:46 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Thu, 27 Dec 2012 00:49:45 -0800 (PST)
In-Reply-To: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
Date:   Thu, 27 Dec 2012 09:49:45 +0100
Message-ID: <CACna6rwqPtCb7GqXYQw5qL3_cUQ8xn6z_U5zCq0E0vZ0yhJXTA@mail.gmail.com>
Subject: Re: [PATCH 0/6] MIPS: BCM47XX: nvram read enhancements
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35334
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2012/12/26 Hauke Mehrtens <hauke@hauke-m.de>:
> Clean up the nvram reading code and add support for different nvram
> sizes.
>
> This depends on patch "MIPS: bcm47xx: separate functions finding flash
> window addr" by Rafał Miłeck, Patchwork:  https://patchwork.linux-mips.org/patch/4738/
>
> Hauke Mehrtens (6):
>   MIPS: BCM47XX: use common error codes in nvram reads
>   MIPS: BCM47XX: return error when init of nvram failed
>   MIPS: BCM47XX: nvram add nand flash support
>   MIPS: BCM47XX: rename early_nvram_init to nvram_init
>   MIPS: BCM47XX: handle different nvram sizes
>   MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names

Hm, the only question? Why so late ;) I've spent 3 hours yesterday
debugging nvram on my WNDR4500, it didn't fill SPROM of PCIe cards
correctly. Will test your patches today.

-- 
Rafał
