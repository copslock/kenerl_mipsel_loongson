Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:18:20 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:41198 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865306Ab3HHLSR7KL-J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 13:18:17 +0200
Received: by mail-pa0-f54.google.com with SMTP id kx1so3285835pab.13
        for <multiple recipients>; Thu, 08 Aug 2013 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/gf8Vc75FoXXwMxID0VzAbI+PbgPXHMhMM3VXGKkUjg=;
        b=VheA0Twze5w/iaSpWFP7p2lWJlRgRcXMQMMz96kQdMi35aRl+KGTkoqa1YxNw++6cY
         PhEOI1oMD/oLBhOT/qXU4t/bTglXxu+XscIKllibnRHzZzMGpMKgepAONMyB8bdUnI8e
         rLKdAWv1N6WDllctXfpMaH5k9unQazwzx514qdilX9iWlfTxXjCKpCZE3KbJk3Uelw6P
         odbapWr5OUJ4VYeJcGL6zhlC5Z7t0OuzZ+bz3sqUkqCNQzAzcfQ22Os3buWPfEKWGKbS
         dJwzgWUVRaCNX/gn0J6m0umn5v06ormBAiI3uGwjgHQCHEZp1DTqqo2w5ZUGoH5BYj6K
         fUSQ==
X-Received: by 10.68.196.202 with SMTP id io10mr5414320pbc.178.1375960691045;
 Thu, 08 Aug 2013 04:18:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.41.193 with HTTP; Thu, 8 Aug 2013 04:17:29 -0700 (PDT)
In-Reply-To: <520379D4.9040903@cogentembedded.com>
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org>
 <1375952846-25812-2-git-send-email-blogic@openwrt.org> <520379D4.9040903@cogentembedded.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 8 Aug 2013 12:17:29 +0100
Message-ID: <CAGVrzcY8NAu0BZBNXVC-sJk7_=40GmepG30ff4+wJQPr4A8J6w@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: lantiq: adds minimal dcdc driver
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/8/8 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
>
> On 08-08-2013 13:07, John Crispin wrote:
>
>> This driver so far only reads the core voltage.
>
>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>
> [...]
>
>
>> diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
>> new file mode 100644
>> index 0000000..6361c30
>> --- /dev/null
>> +++ b/arch/mips/lantiq/xway/dcdc.c
>> @@ -0,0 +1,75 @@
>
> [...]
>
>> +static int dcdc_probe(struct platform_device *pdev)
>> +{
>> +       struct resource *res;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res) {
>> +               dev_err(&pdev->dev, "Failed to get resource\n");
>> +               return -ENOMEM;
>> +       }
>
>
>    You do not need to check this with devm_request_and_ioremap() or
> devm_ioremap_resource().
>
>
>> +
>> +       /* remap dcdc register range */
>> +       dcdc_membase = devm_request_and_ioremap(&pdev->dev, res);
>
>
>    Use devm_ioremap_resource().
>
>
>> +       if (!dcdc_membase) {
>> +               dev_err(&pdev->dev, "Failed to remap resource\n");
>
>
>    Error messages are already printed by devm_request_and_ioremap()
> ordevm_ioremap_resource().
>
>> +               return -ENOMEM;
>
>
>    -EADDRNOTAVAIL is the right code for devm_request_and_ioremap().

This is the first time that I read this, lib/devres.c internal returns
-ENOMEM when an ioremap() call fails (see devm_ioremap_resource),
-EADDRNOTAVAIL really is for networking matter, this is not.
-- 
Florian
