Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 23:16:55 +0100 (CET)
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36482 "EHLO
        mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009429AbbCWWQxvUUf8 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Mar 2015 23:16:53 +0100
Received: by igbud6 with SMTP id ud6so56010861igb.1;
        Mon, 23 Mar 2015 15:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nWevnwXziK0oddG08AVkyfwfwLIvXslDzb5XPYAf3ow=;
        b=gNO92j0URoLdnsZgVlOVXoSpFb866CjguJWnvSwh+hZtueAAAzunDMBd0mzMhAAV5+
         n5zl/uK1Q3Y7TLjrw9oRJ8echJkqEFuFN1GL2vvRHHouM4iH8jlrfA1CSAfDXEJ8dCFw
         qJL0rIWC6B0uN14QuW+VWNJnqqP84YxbbT03HPfQ40OR4YL5uzP+FelswxZkIXaLt5+T
         Gt3p7Q9/JJp/FnJIozT+vnM6GeG0Zngnt5LkD5etk5cv7O6HAsVAP8AgVOhY6bBVwYoT
         VTC7NexEyWqGoE1hsqCigyGh4LzGvJO/axJoakMgQn7zF5CZKGR9NJozYtcO1cjW3u+J
         9Y0A==
MIME-Version: 1.0
X-Received: by 10.50.73.99 with SMTP id k3mr17678673igv.21.1427149009096; Mon,
 23 Mar 2015 15:16:49 -0700 (PDT)
Received: by 10.107.16.139 with HTTP; Mon, 23 Mar 2015 15:16:49 -0700 (PDT)
In-Reply-To: <20150323212524.GU14954@sirena.org.uk>
References: <E1YZyoN-00019n-50@debutante>
        <20150323212524.GU14954@sirena.org.uk>
Date:   Mon, 23 Mar 2015 23:16:49 +0100
Message-ID: <CACna6rzRO=vtiv_RfC9nDz+nCZdGGvCh4-zx5cm-W2GSRC1U6w@mail.gmail.com>
Subject: Re: next-20150323 build: 1 failures 23 warnings (next-20150323)
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        kernel-build-reports@lists.linaro.org,
        linaro-kernel@lists.linaro.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46504
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

On 23 March 2015 at 22:25, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Mar 23, 2015 at 09:38:19AM +0000, Build bot for Mark Brown wrote:
>
> In current -next the bgmac driver does not compile in an ARM
> allmodconfig:
>
>>       arm-allmodconfig
>> ../drivers/net/ethernet/broadcom/bgmac.c:20:27: fatal error: bcm47xx_nvram.h: No such file or directory
>
> because this include file is only present on MIPS.  This looks at first
> glance to have happened in the merge commit edb15d83a875a1f4 from the
> MIPS tree though I think that needs a bit more investigation.

Sorry & thanks. Will fix that tomorrow.

-- 
Rafał
