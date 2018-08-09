Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 20:09:26 +0200 (CEST)
Received: from mail-qt0-f194.google.com ([209.85.216.194]:38084 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994752AbeHISJWJ3HTm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2018 20:09:22 +0200
Received: by mail-qt0-f194.google.com with SMTP id w26-v6so7547387qto.5;
        Thu, 09 Aug 2018 11:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjoF065IRk/7+ukucg8ToAw6/LtabORihLrsbYubnY4=;
        b=hanpI2LEO/Gkkd2zUQGTXg1/d1AAgAf5l2j8FIK2X575klIKwAJHWvj6Af7e09O5MQ
         yhCc5BIxBYbbzZvrpYmNXQPKWt3DSCoC2JVAhg53Ys283lTB7v7Izzw3arOcJr+xpDOU
         r+IGtmQNSD0WTtR/PzZVwpynls8WFN2KI40+R04E2Z/cErqHspzp0T0sv7oxO+21Sg8a
         B2fdBBOKF7CY92bmbSuU8VUNiXd+wA0Uek0uSTuw5io17Jdzui6NpKFbO7aOKUeP5EbW
         dNsIM+TRqgEzxqeXIlOO4YVODCIpW1Z8oiixChJ6JvGiov99Ox3Nr2hGrudG54D52x3V
         rh8w==
X-Gm-Message-State: AOUpUlE2vpuQNYdp5VYTNUWj60Kb8hZmYSkSzXwblI7KPbdWBWcLF07u
        CVx7LLuW1Ywr6iJMVi/IGn2CXLO5roML0dKh5+Q=
X-Google-Smtp-Source: AA+uWPzE7CmNaQJFkU/uiWruiHYRQyXa4V8EyNPhgsWQyiJo0ZDfO831PnckBNSXGmt59vN68jplnA3a76OFDItZoMM=
X-Received: by 2002:ac8:274a:: with SMTP id h10-v6mr3253772qth.187.1533838156051;
 Thu, 09 Aug 2018 11:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com> <20180809174444.31705-4-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-4-paul.burton@mips.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 9 Aug 2018 20:08:59 +0200
Message-ID: <CAK8P3a2AxGr2_r2jsrf3S+xAqaszXGozWwV7tc16VjmP6yx3fg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] compiler.h: Allow arch-specific overrides
To:     Paul Burton <paul.burton@mips.com>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Include an arch-specific asm/compiler.h and allow for it to define a
> custom version of barrier_before_unreachable(), which is needed to
> workaround several issues on the MIPS architecture.
>
> This patch includes an effectively empty asm-generic implementation of
> asm/compiler.h for all architectures except alpha, arm, arm64, and mips
> (which already have an asm/compiler.h) and leaves the architecture
> specifics to a further patch.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> [jhogan@kernel.org: Forward port and use asm/compiler.h instead of
>  asm/compiler-gcc.h]
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-um@lists.infradead.org

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
