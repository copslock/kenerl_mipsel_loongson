Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 21:34:44 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:38718 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865331Ab3HNTeju9ZLQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 21:34:39 +0200
Received: by mail-oa0-f49.google.com with SMTP id n10so8407891oag.36
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 12:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OKWWl6CmTIedc/IDN4NGfAHhO5ZIK82S+oCXWVNebzc=;
        b=QVINwihSiwah2+U2CuXyWNFG2iLoCB1mVTud/usyqZRkP49UICfan4COHllxSIZ421
         H1i1cnwP+DlUBEjlagHs77M++EsohAixXlf6DOy9w/wrfNX3KTxbFPVdWQRD6wpTIUj1
         vy547VwTHm05zRzu2ZbKlyYXc30jX8qXdxRmBRIgMgSwOF/JSfE0LhAlg4W6cS5GVlWK
         3CDop7vEQGoKjC75gXza8weYvD/Gxc8oVAKvnrSINwU7MkCiEmoQxLNozvFTFEypW0xy
         +MHgpskRlJLu7FFfKZhqd9ip6G/sTDaiJ2et/sVCnaKUUfrEg+GZNBQaH39NtJ8bLfxh
         xQyg==
X-Gm-Message-State: ALoCoQlzaxd5P9GmngeHPF9l3P4P/YnLWoFpP2W3bjqXBHXV3Oe7XSJ0bgD28cWs89qbOYOONAmi
MIME-Version: 1.0
X-Received: by 10.182.119.229 with SMTP id kx5mr25196934obb.23.1376508873656;
 Wed, 14 Aug 2013 12:34:33 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Wed, 14 Aug 2013 12:34:33 -0700 (PDT)
In-Reply-To: <1375955300-31682-1-git-send-email-blogic@openwrt.org>
References: <1375955300-31682-1-git-send-email-blogic@openwrt.org>
Date:   Wed, 14 Aug 2013 21:34:33 +0200
Message-ID: <CACRpkdaMKCD7U9iVwjxP0gV8mGoCxw7STChccKaxi6xZYvRfHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl/lantiq: add missing pin definition to falocn
 pinctrl driver
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Aug 8, 2013 at 11:48 AM, John Crispin <blogic@openwrt.org> wrote:

> From: Thomas Langer <thomas.langer@lantiq.com>
>
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>

Patch applied. But I changed the subject to "falcon".

Yours,
Linus Walleij
