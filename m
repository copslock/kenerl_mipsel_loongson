Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2014 19:20:42 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:43890 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860376AbaGCRUifXdm8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2014 19:20:38 +0200
Received: by mail-wi0-f173.google.com with SMTP id cc10so11782930wib.0
        for <linux-mips@linux-mips.org>; Thu, 03 Jul 2014 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zdUzWG9Ypkdwx2sY6s4WfBfgiITqzodBrgGh+u2hmgE=;
        b=yPzZoRDBTdhUHu79Es++WZACDg9s6lg7KWZJRXq7k/7pnOYareBT2oRNT8zBeuu6tD
         tl1YaiW4iusJus7bL+t+7SwQpcVs8DpEHKtwWDetvDr+fuVqsiJIABit0C1a/HZwhQzZ
         ndzpgjcEqBZeLFdVEZ52IdB8wMUhCmlqmbPsH6TBz+O3QcikQ4aASImloxxRkVKdgGvF
         dalymhiGvWF4/20HJjcsQ0mVXUIok/WIPCP/7VfNcTva073axtZ+znMabbdk1tfgLZ2Z
         Jah2YnPAUw7V3tRLriwViB7WI2uZ3QjE9h20puiNSTsY2KQnrgdvOMuRDPwU1D8qeizJ
         9VCA==
X-Received: by 10.180.82.199 with SMTP id k7mr12611360wiy.34.1404408032974;
 Thu, 03 Jul 2014 10:20:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.111.72 with HTTP; Thu, 3 Jul 2014 10:19:52 -0700 (PDT)
In-Reply-To: <53B55FA6.5080801@cogentembedded.com>
References: <1404393762-858019-1-git-send-email-manuel.lauss@gmail.com>
 <1404393762-858019-6-git-send-email-manuel.lauss@gmail.com> <53B55FA6.5080801@cogentembedded.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 3 Jul 2014 19:19:52 +0200
Message-ID: <CAOLZvyFit=cuXHjtx=v2oOBAdj9yj1nwODzBQ+3EP7MpongZoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/11] MIPS: Alchemy: pci: use clk framework to
 enable PCI clock
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Mike Turquette <mturquette@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi Sergei,

On Thu, Jul 3, 2014 at 3:50 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> --- a/arch/mips/pci/pci-alchemy.c
>> +++ b/arch/mips/pci/pci-alchemy.c
>> @@ -394,11 +396,24 @@ static int alchemy_pci_probe(struct platform_device
>> *pdev)

>> +       ret = clk_prepare_enable(c);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "cannot enable PCI clock\n");
>> +               clk_put(c);
>> +               goto out2;
>
>
>    Isn't it simpler to add one more label before clk_put() at end of
> function?

Yes, I have changed it locally.


Thank you!
       Manuel
