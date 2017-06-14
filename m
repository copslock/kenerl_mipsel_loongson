Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 11:14:31 +0200 (CEST)
Received: from mail-it0-x232.google.com ([IPv6:2607:f8b0:4001:c0b::232]:38273
        "EHLO mail-it0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991786AbdFNJOXDRpRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jun 2017 11:14:23 +0200
Received: by mail-it0-x232.google.com with SMTP id l6so43735598iti.1;
        Wed, 14 Jun 2017 02:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cjPghfWGc5drGosuge0puul1LpDxfbMYVJnAOJuzxp4=;
        b=nH92GCEdi5kAaRv/OnbxcOReyq6kWaoITv/+yVKhm7VqvKKXq1neqsc7bPX+UaNxfV
         /WvoMYvSDQ8QWq3Zz1OBpzvB/t7t6jzv+poJmEXQf8tAsxk20xCbJcG/B34C0/BfR638
         c5i7d59SMuak6SyW0TsjSxbrvmAXw3kxvhHKKmN5dCnxMJBphZGJ8ZujNljGfjzbkdTH
         wJUgeGyAB0vlMzwwBDiMmo77vIOw9dl50Puvw3zm03rvWUJ8p7Y5z2GntZ9OIxenjy6s
         pllz2rxrbbzJpVC7kbqujTD9NbYBL28BzJMHuPk2ze8o5OaIdxR+3a0CNddeQHQ1gMTm
         YQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cjPghfWGc5drGosuge0puul1LpDxfbMYVJnAOJuzxp4=;
        b=RksHCGPoeHvOxLZR3BcFHL3BA39rJEcGBIdBIA5MZWhDdUe5rr5fQ+Rh5VnxaroI7t
         CmEnWJUf3Ek6E3sS7m/92H0IXYIEodpYw+1Yy4mPnfmeEK/c55/ZQQtzqMI34WdymdSG
         eiGSMZiC4k2JNKanAf3pyYFFIBaL2k3KQEf8mBdvI6MZbGarTU6sJvz+hRnWnqBOviah
         OJaX8w3DxudasDqpioNCMWl8DLMGAUt2Sp3NRdht/EcSGr8xdW6Ygm5icytVFAAcTYJA
         o6Jron76ZgyFL0/f6eLE7Kiv+32lIUFd8aJk1tU3CateCs5Typz6gK9tKC/k5zPMbRel
         alOw==
X-Gm-Message-State: AKS2vOwr68FIABX2+g1GVIFjJBVQJuOyK6RMno2T5W9ANEMX1LGuSizc
        98CNKScbq7A0R/L8Nlt8UWHlRKyA9DsE
X-Received: by 10.36.120.136 with SMTP id p130mr211965itc.73.1497431657018;
 Wed, 14 Jun 2017 02:14:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Wed, 14 Jun 2017 02:14:16 -0700 (PDT)
In-Reply-To: <20170613094525.GB31492@linux-mips.org>
References: <1496718888-18324-1-git-send-email-chenhc@lemote.com>
 <1496718888-18324-4-git-send-email-chenhc@lemote.com> <20170613094525.GB31492@linux-mips.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 14 Jun 2017 17:14:16 +0800
X-Google-Sender-Auth: ixpO0nCs35s2H-H6SXRcEk8m3sM
Message-ID: <CAAhV-H7pXq_a-JuzdyWL_2yCo9HWXB5C7PyFyuXeV4ZStoYfAA@mail.gmail.com>
Subject: Re: [PATCH V4 4/9] MIPS: Loongson-3: Support 4 packages in CPU Hwmon driver
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58444
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

On Tue, Jun 13, 2017 at 5:45 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jun 06, 2017 at 11:14:43AM +0800, Huacai Chen wrote:
>
> (Fixing the Steven.Hill@imgtec.com address on cc, this email address is
> stale since a long time.  Steven is now Steven.Hill@cavium.com.
>
>> Loongson-3 machines may have as many as 4 physical packages.
>
> Any reason why not dynamically allocating all structures, static allocations
> just won't scale to many packages nor are they very maintenance friendly.

Loongson-3 will no more than 4 packages, so we needn't allocating all
structures dynamically. However, I'll improve maintenability by
unifying get_cpu0_temp/get_cpu1_temp/get_cpu2_temp/get_cpu3_temp and
cpu0_temp_label/cpu_temp1_label/cpu2_temp_label/cpu3_temp_label.

Huacai

>
>   Ralf
>
