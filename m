Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 17:05:19 +0100 (CET)
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34760 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009483AbbJZQFRHt5In (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 17:05:17 +0100
Received: by vkgs66 with SMTP id s66so41634072vkg.1
        for <linux-mips@linux-mips.org>; Mon, 26 Oct 2015 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=e+RiJA5YzlZyjNeJrMn9v4aDH8nHrmqHQ1Dzrc/qRkU=;
        b=qQ5/ikfozRXsREHoe03y6dYyJcxXuKstS3eFt167euXKUPNj3D/zx6b6lvnwLByB00
         Kj+iYqnabQ9TLizRd9qAwgjXXBG4T2l7y6iApgFawyPwDUBt+c5s0bfpvp91eEKdRT1t
         S3PNUEQXblwDOwlOxCFulN5b0q0cEzNA6/FwXO1Bt0Mf6qwFiHExHh3f0/TIR1nkfQDm
         78OmDwJrNq/e2fbWctGfCOj25Jho+5tX85BOS39ImkgSe3xMpdm6K3p0OhhkEybspgx4
         I8aTEGBmWDH1BGKR5NNYspVU8pxb6WVpsEB7UaITryG91dHmL3ctEZy1PFdCOr4mCKjR
         qfFw==
X-Received: by 10.31.130.9 with SMTP id e9mr19521925vkd.78.1445875511113; Mon,
 26 Oct 2015 09:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.99.198 with HTTP; Mon, 26 Oct 2015 09:04:51 -0700 (PDT)
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 26 Oct 2015 17:04:51 +0100
Message-ID: <CAGm1_kuehh3Xe9Y+vmx6p8=+E=XOxj8ASJ2vEOU4oGo5MtvaOA@mail.gmail.com>
Subject: Mainline support for QCA9531
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yegorslists@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegorslists@googlemail.com
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

Hi,

what is the current mainline state of the QCA9531 SoC? I could only
find some mentions of the chip:

http://wiki.openwrt.org/toh/netgear/wnr2000
https://wikidevi.com/wiki/Qualcomm_Atheros

No info about BSP or what driver are already available upstream.

Thanks.

Regards,
Yegor
