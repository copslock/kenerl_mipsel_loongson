Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2017 12:02:19 +0100 (CET)
Received: from mail-yb0-x243.google.com ([IPv6:2607:f8b0:4002:c09::243]:35797
        "EHLO mail-yb0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbdAZLCLFiRJJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jan 2017 12:02:11 +0100
Received: by mail-yb0-x243.google.com with SMTP id j82so12808686ybg.2
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2017 03:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tAyCbgHVBbmOgLNp9kWxEWhG/KBOZjLjhLGxLI8JzNA=;
        b=olxYcpoDkwiGS9tLASadVykg8geTN66LfaU0sxZYsnqpLFpD1Lwyh3iVtaiYntw1vk
         G355RaMlcck9b7RH0w+a0mSDn3UneacOygovizeJAL70ME8Y+Xo4+3vAWZas8O//y1FK
         +jc7FxLKipjfwk4WM2GXcPCyq5DiWsH/GwS0T7fHt7NtMw5e/H0S+sjvP0HJXW1z1YCl
         4WhZZ2QQdfVAuTscgJYesSkdKHwM9ISGlHrS0z3rFwuMKs/MZ/LUxbIZKOo6Gt9qHCvw
         VbGgceaUMvcSn6lbKC9rsIqahsbTct3GLhOJvyB06wj5s3OpN4ANe/EXDMvGFYHG15EW
         Zetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tAyCbgHVBbmOgLNp9kWxEWhG/KBOZjLjhLGxLI8JzNA=;
        b=P7MhyTpPeon4ATX1w9o1+lHW099su9Fyi8wOu9ElFgJMr/dt/BXLCd0ZwZVuNmM9Q3
         kdwalOQt7kqq0OXQ8B4mOU0EQTS5TCR0/iBGbIJwEj1EzUu5RuIa1413+285zXCgFwWI
         yBhLFGAleLAqgwxpRDf7/8Js1xcDrSMh0KXZ3g53vXUd7+O84ItNvnOZYXJTjrwzne5j
         iQddPOMLqmxjv7BId7sVr/pHFEAYfLwEXoxGKVgve/39H57ULH6k5IOpIAyhW+E9htgu
         J9hr+oA9U/7a1AaRejwkWGzUU3L5T4/5X+Kl4wMbx8tW3yytoQFt0m1xHzNtDQmlanZR
         FgPw==
X-Gm-Message-State: AIkVDXJECDN0LGOXzGk2Byuj9Ot9frp7X3gBdRJ3E4z7YW171rNqkZvVnW1RGvmcEAwgz0R8SAYrsp3NQHoyQA==
X-Received: by 10.129.122.78 with SMTP id v75mr1579877ywc.67.1485428525106;
 Thu, 26 Jan 2017 03:02:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.192.68 with HTTP; Thu, 26 Jan 2017 03:02:04 -0800 (PST)
In-Reply-To: <0DAF21CFE1B20740AE23D6AF6E54843F1E6F607C@IRSMSX101.ger.corp.intel.com>
References: <1484904834-14980-1-git-send-email-sebtx452@gmail.com>
 <3304d64f-38aa-1a3c-0b5d-edb493abd61a@hauke-m.de> <CA+hF=GdKLEN2ue=Q7KpBp+W+bTnj5O_OAoPjuDOScga2efnjPA@mail.gmail.com>
 <0DAF21CFE1B20740AE23D6AF6E54843F1E6F607C@IRSMSX101.ger.corp.intel.com>
From:   Seb <sebtx452@gmail.com>
Date:   Thu, 26 Jan 2017 12:02:04 +0100
Message-ID: <CA+hF=GcW2W6T08BZYXoZQcpe=+QuPp0H7kT2ci+6Td-ZZL+ouQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     "Langer, Thomas" <thomas.langer@intel.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56514
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

Hi Thomas


> No, please avoid "of_machine_is_compatible" in drivers.

OK


> We should introduce specific compatible strings for this driver, which trigger this,
> e.g. "lantiq,nor-vr9" or "lantiq,nor-ar10" (or better using family names "xrx200" and "xrx300")

You mean we can use the same way as other drivers, for example in the
physmap_of_versatile.c file :

static const struct of_device_id syscon_match[] = {
        {
                .compatible = "arm,integrator-ap-syscon",
                .data = (void *)INTEGRATOR_AP_FLASHPROT,
        },
        {
                .compatible = "arm,integrator-cp-syscon",
                .data = (void *)INTEGRATOR_CP_FLASHPROT,
        },

etc...


We can't filter on xrx200 or vr9, but we have to know the VR9 version
(as the VR9 < 1.2 is not compatible with this patch).

Regards,

Sebastien
