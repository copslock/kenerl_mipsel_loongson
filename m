Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 18:12:44 +0100 (CET)
Received: from conssluserg-06.nifty.com ([210.131.2.91]:43817 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994833AbeBARMgrdraz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2018 18:12:36 +0100
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com [209.85.213.46]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w11HBou8020264;
        Fri, 2 Feb 2018 02:11:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w11HBou8020264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1517505110;
        bh=EApA63iqdSjk6RJBEzZVRzS12wult6h3oKv+NmK3koQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1yh3QorZLLW8lUjrKvHNyNZvJwI+mfJnpzhYfauxd91ju186LgiXPJVgd791DV5HY
         eDnPc/3qHI+RuCyNbdd8uV+PToExn5aHjNhOKuUzW/Yi0wN41oY8hEqT8V6JCRuIqb
         /83yCcUheMPW8CprcjsJz4v7qxnUHDyTxZErt3j4WFc7mDa7XwSeLmvTk207N+Njm0
         5uWVSCxrzyR+n5p+5Nq5aYhUgRVyymDjF/SQzN79a4/H96MyZRwnsUqCA7SL3eFZqf
         pLt6QOyjoFbvy2EHXkQl7vlpiLNwrg2b/9i4IWRlcCCUSqL1v/wxrvjqt7D7gqfmuv
         YQ1GaNYhgu7Lw==
X-Nifty-SrcIP: [209.85.213.46]
Received: by mail-vk0-f46.google.com with SMTP id e125so11731439vkh.13;
        Thu, 01 Feb 2018 09:11:50 -0800 (PST)
X-Gm-Message-State: AKwxytfnauQMS6D2brTZxCvkfy2eEcXgcJ3ahm6c/yIbsH3nwJ5HXiF0
        h4hnPgI3aruwWK59W15vfdHfuupWsKyu8SXyp60=
X-Google-Smtp-Source: AH8x224J15gACqddXhOo/Uu7bgyTuXCwsmtYhB6Vt6ioa0yZw5b6fr5HuTB75mNoJ5h+IJRerCi/d7TsOmNgBgYdcNk=
X-Received: by 10.31.92.142 with SMTP id q136mr29161598vkb.29.1517505109243;
 Thu, 01 Feb 2018 09:11:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.49.90 with HTTP; Thu, 1 Feb 2018 09:11:08 -0800 (PST)
In-Reply-To: <20180131093434.20050-9-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com> <20180131093434.20050-9-ulfalizer@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 2 Feb 2018 02:11:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYoPzzHgNw8JfCDcCMATBGjf6r8R91RWgd4jMxYmgipg@mail.gmail.com>
Message-ID: <CAK7LNATYoPzzHgNw8JfCDcCMATBGjf6r8R91RWgd4jMxYmgipg@mail.gmail.com>
Subject: Re: [PATCH 08/11] MIPS: kconfig: Remove blank help text
To:     Ulf Magnusson <ulfalizer@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62404
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
>
> Best to remove them, IMO.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---


FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series next week.



-- 
Best Regards
Masahiro Yamada
