Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 07:20:35 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56798 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859997AbaGBFUbuDSth convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jul 2014 07:20:31 +0200
Received: by mail-pd0-f174.google.com with SMTP id y10so11291615pdj.19
        for <linux-mips@linux-mips.org>; Tue, 01 Jul 2014 22:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=EPq6jYTO+PGIHuRj34ryU5j4DQkVdoZwsE/nunLspdI=;
        b=bdv8pKG9FyqH3WCwQ/BeEd4y4vke+dTpf7MgaiiWK88bhuEtJss3QabXM/lu7Cgd+c
         G8qo5nVLnRy9Z10FFgWlKiq+P3FicNahlpwhPmv4K8quS4woEk21ahCSJl1scgGPMGVS
         Ab5xs+Wr3gDbkZNt6tDZ71c+cnF3HruwQ4hCXvQyX3RRRW26trYtJHdQsQBApHhUergj
         19TE7muGpji2MB60OJCdZDmd0HnVPB2NnA7Jg4uXcvwLwhKK6cyzD2Ly2Pn6xeoPdo1x
         U4698QTxRAKptoyCUs8EWi45Zpx4VLDfBSxmSJbXr3eTkJ124cuEn4mKWdgrYOiSmbWQ
         q5Ig==
X-Gm-Message-State: ALoCoQlk1iuWJ5Ftzt4lf4TE6snN7RiSezkbft0CPvoYm/5b30Hrn7ZoNSFVnKRrMYquDCV8DPn5
X-Received: by 10.66.100.200 with SMTP id fa8mr62198737pab.23.1404278425374;
        Tue, 01 Jul 2014 22:20:25 -0700 (PDT)
Received: from localhost ([2601:9:5900:1fe:ca60:ff:fe0a:8a36])
        by mx.google.com with ESMTPSA id pr8sm35198138pbc.74.2014.07.01.22.20.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 22:20:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        "Linux-MIPS" <linux-mips@linux-mips.org>
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1404061055-89797-3-git-send-email-manuel.lauss@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Manuel Lauss" <manuel.lauss@gmail.com>
References: <1404061055-89797-1-git-send-email-manuel.lauss@gmail.com>
 <1404061055-89797-3-git-send-email-manuel.lauss@gmail.com>
Message-ID: <20140702052012.23338.54536@quantum>
User-Agent: alot/0.3.5
Subject: Re: [PATCH 2/2] MIPS: Alchemy: common clock framework integration
Date:   Tue, 01 Jul 2014 22:20:12 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Manuel Lauss (2014-06-29 09:57:35)
> Expose chip-internal configurable clocks to the common clk framework,
> and fix a few drivers to take advantage of it.

Thanks for the patch series! Both patches cover a lot of ground, but
I'll focus on #2. It would be best to split the driver changes out
separately. You can introduce the common clk changes but not compile
them in, then change the drivers, then add the logic to compile the new
common clock driver all as separate patches.

<snip>

> diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
> index cb83d8d..2e4d505 100644
> --- a/arch/mips/alchemy/common/Makefile
> +++ b/arch/mips/alchemy/common/Makefile
> @@ -5,7 +5,7 @@
>  # Makefile for the Alchemy Au1xx0 CPUs, generic files.
>  #
>  
> -obj-y += prom.o time.o clocks.o platform.o power.o setup.o \
> +obj-y += prom.o time.o clock.o platform.o power.o setup.o \
>         sleeper.o dma.o dbdma.o vss.o irq.o usb.o

As stated above, in the first patch only introduce
arch/mips/alchemy/common/clock, but don't compile it here in the
Makefile.

A quick glance through clock.c below looks pretty good. I'll go through
it in more detail once the other parts of the series are split out.

Additionally, it would be cool to push this driver out to drivers/clk/
if you are so inclined. It looks like your header dependencies are not
so bad as to make that task impossible. Just a suggestion from me.

Regards,
Mike
