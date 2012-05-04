Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 13:17:28 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54757 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903664Ab2EDLRW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2012 13:17:22 +0200
Received: by lbbgg6 with SMTP id gg6so2439395lbb.36
        for <linux-mips@linux-mips.org>; Fri, 04 May 2012 04:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=ba75U3UMf0M0K0fqnzW9S5Fxge2qW+wAvYB3wpaXoe0=;
        b=OujX8dyG8IuGPrS/aDHkDSTbemZLCQDbl8v00R9771E2kwGlt2FZpBvYS8B5SeQann
         KjFKGrVJMN6Q92fBdyvDR+SiBGf3xgDrj3X9srxVJtKE31IoGHb4H5k40hUsF/+nL+0T
         hHSyDh9o0HCWVTBZKGQzWGoGjsIh2pPOTYneTsQ1FLyMDeHf/D8h8QrYLAwc45PSHDVA
         8UbVpQ2V3Lnd57SLDNogr82smk4m3+1wdIr8uK52w9LJMXFoky5LJQMEF3I6mI3WrUv0
         os8kSuA6niyjzuskGz4No1rcph6ZTGbkAs19sHZXhr7Jo+Gy2Ap3QH9PWLnj49TxX/Za
         /0NQ==
Received: by 10.112.86.101 with SMTP id o5mr2738744lbz.1.1336130236588;
        Fri, 04 May 2012 04:17:16 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-80-122.pppoe.mtu-net.ru. [91.79.80.122])
        by mx.google.com with ESMTPS id o9sm10583668lbm.14.2012.05.04.04.17.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 04:17:14 -0700 (PDT)
Message-ID: <4FA3BAA6.5060200@mvista.com>
Date:   Fri, 04 May 2012 15:16:54 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Matt Turner <mattst88@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: set ST0_MX flag for MDMX
References: <1336084845-28995-1-git-send-email-mattst88@gmail.com>
In-Reply-To: <1336084845-28995-1-git-send-email-mattst88@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkUDAQARdnwS7eDQog0sjDw4W5jHeZdukclQ6gZH4JrMyyn29TmBwamsMwkcanwiarJ7Q6Z
X-archive-position: 33139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 04-05-2012 2:40, Matt Turner wrote:

> As the comment in commit 3301edcb

    Please also specify that commit's summary in parens.

> says, DSP and MDMX share the same
> config flag bit.

> Without this set, MDMX instructions cause Illegal instruction errors.

> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
> Is MDMX implemented by anything other than some Broadcom CPUs? Is it
> totally replaced by DSP?

> I had a terrible time finding any documentation on it (which is annoying
> because Volume IV-b covering MDMX is referenced by all the MIPS64 documents.)
> but finally found a copy here: www.enlight.ru/docs/cpu/risc/mips/MDMXspec.pdf

> If it's dead, it's too bad because it's a pretty cool ISA.

WBR, Sergei
