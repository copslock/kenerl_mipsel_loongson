Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:42:15 +0200 (CEST)
Received: from mail-yh0-f49.google.com ([209.85.213.49]:48253 "EHLO
        mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6894409Ab2JDJl6qgjBI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 11:41:58 +0200
Received: by mail-yh0-f49.google.com with SMTP id j52so23697yhj.36
        for <multiple recipients>; Thu, 04 Oct 2012 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kkaD6PuS2lnJhb6TdMJXM+VW+vZ5nK2zSpmwm7dkAaE=;
        b=0HRxO3d/8pDYEjfBSl8DybVZg01hjPLxqeCO9D9Fs82wZiluHwPYxgMKNqDq+lpIkS
         AvxMnmhk0IEs4z55XYaAbe/CooeZBvjU1ZG0v8goKSSDcnLK/FS6QlRvinsEkboEkbx9
         jAgh0sj1y3f5Z/3GAKz0S7B5d9jR28MU6IcTKHmy6LBg4gzkrwz8Zeh45qjbmfuw16c8
         PDNLFa5JfohiBomIlrHu9Q5HtRGTP6uKy1eCuid9KlJR3He0hPiQ0ufMtspZ18lGFj1W
         +9AQhXZcHVkzYxVv2UchNCXaoreK3b8L3p1Pep1yDf3y+fltu8SxLGvNa+9BFpmTQ8ZY
         FWcw==
Received: by 10.236.199.230 with SMTP id x66mr2099977yhn.87.1349278052333;
 Wed, 03 Oct 2012 08:27:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.176.229 with HTTP; Wed, 3 Oct 2012 08:26:52 -0700 (PDT)
In-Reply-To: <2608261.j829MQZAuC@flexo>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org>
 <1349276601-8371-26-git-send-email-florian@openwrt.org> <CAOLZvyHyQGZ=Rs1=k07Saq16aZcntUe8N0Fc5iMoeOTeMpjcSw@mail.gmail.com>
 <2608261.j829MQZAuC@flexo>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 3 Oct 2012 17:26:52 +0200
Message-ID: <CAOLZvyGSbqN-wMDYJcoB_6GPXvZo3wKPMn1oCWxyFETOerMLSA@mail.gmail.com>
Subject: Re: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
To:     Florian Fainelli <florian@openwrt.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34568
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Oct 3, 2012 at 5:24 PM, Florian Fainelli <florian@openwrt.org> wrote:
> On Wednesday 03 October 2012 17:21:37 Manuel Lauss wrote:
>> On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
>> > This also greatly simplifies the power_{on,off} callbacks and make them
>> > work on platform device id instead of checking the OHCI controller base
>> > address like what was done in ohci-au1xxx.c.
>>
>> That was by design -- the base address is far more reliable in identifying
> the
>> correct controller instance than the platform device id.   There are systems
>> in the field which don't use the alchemy/common/platform.c file at all.
>
> Fair enough, but the way it was done previously was very error-prone if the
> base address changed for any reason in the platform code, and you did not
> notice it had to be changed in the OHCI driver too, then it simply did not

Since the Alchemy line is dead this point is moot.


> work. By systems in the field you mean out of tree users? If so, I'd say that
> it's up to you to get them maintained or merged.

I'm not against the patch at all, quite the contrary.

Manuel
