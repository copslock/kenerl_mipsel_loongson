Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 03:02:38 +0200 (CEST)
Received: from mail-ve0-f175.google.com ([209.85.128.175]:45891 "EHLO
        mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822284AbaDPBCgKreIG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 03:02:36 +0200
Received: by mail-ve0-f175.google.com with SMTP id oz11so9826879veb.6
        for <multiple recipients>; Tue, 15 Apr 2014 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9ExrD9n1MlAsP/NFw7ryQFjV8aiYfyX27BdcMuavYlM=;
        b=rZZY+z1ha/YUvlKWreW+qUNVa/eHzf0tLVCFlSaapWRtrXrsnYZdsvUbx3W7mynwuJ
         arOkrZMVjlCLZv5L5xLZYlcNuvVU2giqT29HTMCBaUYLHa6sEX6MOF0O7qTI7Plb0TQM
         y1YYXCJKkA6MTnIwxh+TD0/DnX+LsxlEaoQaoLJple9dPYt6dAs/ITk6NglpM5u4f2kk
         vuRwjIrjU0ArOFu4EbVENv355/BXFZZJar2qAa6GLz7VWUfzF7RT0HhsskRuauKd5rxu
         M1xBECQHv3RTj7XpVIJq7wQUm/3lfxHugvAkltr1fCknfh5WHyAOuBEjo5d8Rznmxw+w
         FTQQ==
MIME-Version: 1.0
X-Received: by 10.58.46.207 with SMTP id x15mr3155vem.17.1397610149945; Tue,
 15 Apr 2014 18:02:29 -0700 (PDT)
Received: by 10.220.50.132 with HTTP; Tue, 15 Apr 2014 18:02:29 -0700 (PDT)
In-Reply-To: <20140407174617.GA12379@alberich>
References: <1396563423-30893-1-git-send-email-robherring2@gmail.com>
        <1396563423-30893-2-git-send-email-robherring2@gmail.com>
        <20140407174617.GA12379@alberich>
Date:   Tue, 15 Apr 2014 20:02:29 -0500
Message-ID: <CAL_JsqL7Of9_NofFd2ym47PNPtYWSMmshe+sJSGTwKmOa5C50Q@mail.gmail.com>
Subject: Re: [PATCH 01/20] mips: octeon: convert to use unflatten_and_copy_device_tree
From:   Rob Herring <robherring2@gmail.com>
To:     Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Daney <ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Mon, Apr 7, 2014 at 12:46 PM, Andreas Herrmann
<herrmann.der.user@googlemail.com> wrote:
> On Thu, Apr 03, 2014 at 05:16:44PM -0500, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> The octeon FDT code can be simplified by using
>> unflatten_and_copy_device_tree function. This removes all accesses to
>> FDT header data by the arch code.
>
> Hi Rob,
>
> I think (in general) this modification is ok. But I suggest to use
> following (slightly modified) version.

Having to compile each platform on MIPS sure is annoying. Reminds me
of ARM a few years ago. We need a good rant from Linus about MIPS. ;)

>
> -       /* Copy the default tree from init memory. */
> -       initial_boot_params = early_init_dt_alloc_memory_arch(dt_size, 8);
> -       if (initial_boot_params == NULL)
> -               panic("Could not allocate initial_boot_params");
> -       memcpy(initial_boot_params, fdt, dt_size);
> +       initial_boot_params = (void *)fdt;

Does calling early_init_devtree here work instead. This will add
parsing memory, initrd and command line. If you don't have those then
it should be a nop other than setting initial_boot_params. It should
only matter if your DT has these things and you want/need to ignore
them. Do this would get things more inline with other arches.

Rob
