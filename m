Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jan 2018 17:19:41 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:36898
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991526AbeAGQTd1pdeW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Jan 2018 17:19:33 +0100
Received: by mail-wm0-x241.google.com with SMTP id f140so10197843wmd.2
        for <linux-mips@linux-mips.org>; Sun, 07 Jan 2018 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexb-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l4G6co0AviQxlDOx6IUmsG+Fem8LiWfkXDydwGM3NxI=;
        b=wrM6LE0iaRNZ2zFG+YLoE74JriwaBm42vnGIztHFRN1DEEcTDg2bGuezby5LjXERtf
         Lf6qqEyWFvvr7Kg5EQtKeumr44CrXIBc0u26290HAjoL8D0Dv2PHjHvEle20sgqS9BFW
         UKKIHNXJ/0n8yqsqIHh7eUZD5oSYlNnITPCabT9Ye6N5h72H0K2GJ66KdyuxilU3qR/J
         +gl45XUrATFMBQ9xhh3GrDBfZfNMG8jVuxmpg0x21FaciGREQ09w5L5g9NZiQxza7Ekl
         fU0Doczmp/MPktn7+xnsGH7EgHGgkldTAxB1d8TatcJOLfN1GEMmYue0KjlIXo9/rCbx
         swbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l4G6co0AviQxlDOx6IUmsG+Fem8LiWfkXDydwGM3NxI=;
        b=M1YATARPWp1tnab2rCZN4MI1GCglcGMzip87d5Z2MipC9BIFnEZl6IXiK6XKTUaAL/
         A6fi5tKPp1691KztTbV1tdW7VVI5yu5q4EkJluETv/Rrdqz7wy9UuOAP+5EgcHcM3SG0
         ZGEbsauSQcJEg7mnu5nIGWadGdqjGOxYEYrWgBLVE2gO19poIlfS3BCKmmk7O+y3z0kf
         21xuyp163TfcZafAo0I4rYOPFQoynQCsz3n1wDQSaNUh06WT1XEEbauE3DbC+A6qYd6l
         7SiFvcw1ap0qRwn7jIe0V2U/PQ419aVQbgvtj0dFD9a4NNxoCbqMfUgRuV9PLC8tHuk1
         p4PA==
X-Gm-Message-State: AKGB3mK5rpGuKhPsaFtW5GQmwnlRHiC9jyVan1CW5AWpaRKelzOC45Pf
        m/7LJciNljg7+7G15tbMUgNk1yeN4FVLoudCF+cXxw==
X-Google-Smtp-Source: ACJfBosvjeDnxKoqRXXcmI1ByLNwB458cbxU/f/Fbu9YxtaFLVEC5t8HKHrTEzsVKGTnQQoa/rlNUR0Lis01MCTTskU=
X-Received: by 10.28.17.149 with SMTP id 143mr7229764wmr.96.1515341967929;
 Sun, 07 Jan 2018 08:19:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.157.206 with HTTP; Sun, 7 Jan 2018 08:18:47 -0800 (PST)
In-Reply-To: <20180105182513.16248-16-paul@crapouillou.net>
References: <20180102150848.11314-1-paul@crapouillou.net> <20180105182513.16248-1-paul@crapouillou.net>
 <20180105182513.16248-16-paul@crapouillou.net>
From:   Philippe Ombredanne <pombredanne@nexb.com>
Date:   Sun, 7 Jan 2018 17:18:47 +0100
Message-ID: <CAOFm3uHr0a5Poz+PKUC=KpjTcowZUGr6pSxgPN+j8URr=Nu3pA@mail.gmail.com>
Subject: Re: [PATCH v6 15/15] MIPS: ingenic: Initial GCW Zero support
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Paul Burton <paul.burton@mips.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <pombredanne@nexb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pombredanne@nexb.com
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

On Fri, Jan 5, 2018 at 7:25 PM, Paul Cercueil <paul@crapouillou.net> wrote:
> The GCW Zero (http://www.gcw-zero.com) is a retro-gaming focused
> handheld game console, successfully kickstarted in ~2012, running Linux.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/boot/dts/ingenic/Makefile |  1 +
>  arch/mips/boot/dts/ingenic/gcw0.dts | 62 +++++++++++++++++++++++++++++++++++++
>  arch/mips/configs/gcw0_defconfig    | 27 ++++++++++++++++
>  arch/mips/jz4740/Kconfig            |  4 +++
>  4 files changed, 94 insertions(+)
>  create mode 100644 arch/mips/boot/dts/ingenic/gcw0.dts
>  create mode 100644 arch/mips/configs/gcw0_defconfig
>
>  v2: No change
>  v3: No change
>  v4: No change
>  v5: Use SPDX license identifier
>      Drop custom CROSS_COMPILE from defconfig
>  v6: Add "model" property in devicetree

For the use of SPDX tags for the whole patch set: thank you!

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
-- 
Cordially
Philippe Ombredanne
