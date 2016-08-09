Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 16:15:17 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35440 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993107AbcHIOPKmMmlC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 16:15:10 +0200
Received: by mail-ua0-f193.google.com with SMTP id 109so1073038uat.2;
        Tue, 09 Aug 2016 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VHuRv6gonVAOSKKdZqkIdqxrCMdmu5rql3a6nMtdyNI=;
        b=jho6sBOuKgnk14U9hFQDN8MQWsnDaeX5RMxCOyEETXeIh1hB6ATMNUAFHR5SxJVzXP
         3AoiXtgz4m/NseeIdz8BmvYX+YGSv7Ohcg+ZxHXijEA69Dx+FXmlPjUVrwNfJaSQarGR
         U7wqmFLb+uTdTQkWJW0JRcSU90OSatCWmOQfSVXThITq1WOnR5WFEYOwe7IDU+yzPNk4
         6wTBFK2vPkECnZLpQnIc0CPpXwROpxbq0d5lbBLTn+2iEGPq94N+bF/jclenzK4Loam8
         I02gaquV/BbX6sNxk2sZeeaBDH0GiGGkn9I9AsDsdoS4cNVfVM6z3gMrkQA6rMA7ib7d
         WKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VHuRv6gonVAOSKKdZqkIdqxrCMdmu5rql3a6nMtdyNI=;
        b=DltKxkCQEZONkBo3C83Bus+cX7hwXkQT80PNBmBPxMc52UwOsp+8P1KXvnxGquAb/s
         iRChRIiZWjdHaaSO2vxjfGEbwhljurph3e0nCFmNEm9OLGNTwEFoveuu1OjWI4b+l+w6
         Rj01HKSC+uT47HJAcNUBU+4heJDzwL1hXQ5ttpb4KbnqvTjt46bs9YRcElCGYGULRPqx
         qzoZIEpnj62mtcMMBVuDBkaXWBrGvEZgsxlqbIwaYWi1F83y7m8pSEx9Q1BuS3yTeoUt
         1zrT4ENzvvsCZ1HJ6NE2nPOM+hBq7scNQzdGwOd4+MwY2SKiNLnIi6cgLPqrAjDTeP/D
         qXhA==
X-Gm-Message-State: AEkoouspt15QIdocnIatJrij11LkUPpCjEAVZxLU5cflYL0nqVxRUFjd0m1Y0MNGPXqppp3/zO2qO3Bl97Nnng==
X-Received: by 10.31.109.193 with SMTP id i184mr5923576vkc.10.1470752103119;
 Tue, 09 Aug 2016 07:15:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.129 with HTTP; Tue, 9 Aug 2016 07:14:42 -0700 (PDT)
In-Reply-To: <D5F26D94-8312-4CAC-8577-205A1AAFB0E5@gmail.com>
References: <20160808021719.4680-1-jaedon.shin@gmail.com> <20160808021719.4680-3-jaedon.shin@gmail.com>
 <CAOiHx=kxjXiYm_4S3rLOjB0wM-UpQsqfXn+EVq6+FGOH4whuuQ@mail.gmail.com> <D5F26D94-8312-4CAC-8577-205A1AAFB0E5@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 9 Aug 2016 16:14:42 +0200
Message-ID: <CAOiHx=n19Sb3B1_FGkdzqxWqi5Vpy5PQbYWdaVvNaUTW+Njcog@mail.gmail.com>
Subject: Re: [PATCH 2/4] MIPS: BMIPS: Add support GPIO device nodes
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 9 August 2016 at 03:44, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Hi Jonas,
>
> On Aug 8, 2016, at 11:06 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>>
>> Hi,
>>
>> please always include devicetree for any dts(i) related changes.
>>
>> On 8 August 2016 at 04:17, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>> (snip)
>>> diff --git a/arch/mips/boot/dts/brcm/bcm97435svmb.dts b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>> index 9db84f2a6664..dd8b8fb97053 100644
>>> --- a/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>> +++ b/arch/mips/boot/dts/brcm/bcm97435svmb.dts
>>> @@ -59,6 +59,14 @@
>>>        status = "okay";
>>> };
>>>
>>> +&upg_gio {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&upg_gio_aon {
>>> +       status = "okay";
>>> +};
>>> +
>>
>> You don't set their status in the dtsi, they will be enabled by
>> default, and you can drop this change.
>>
>>> &enet0 {
>>>        status = "okay";
>>> };
>>
>>
>> Regards
>> Jonas
>
> The status="disabled" has been missing. It will be added in v2.
> The interrupt-controller@ will also be changed.

I thought that was indented, since GPIO controllers usually are always
present (you don't disable the irq controllers by default either).

Not that I want to tell you how you do your dts(i) files, but I would
expect things that you usually always need (irq, clocks, gpios) are
present by default.


Regards
Jonas
