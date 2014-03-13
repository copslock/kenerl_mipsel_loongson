Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2014 16:22:33 +0100 (CET)
Received: from mail-oa0-f46.google.com ([209.85.219.46]:41474 "EHLO
        mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817294AbaCMPWbSpd2i convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Mar 2014 16:22:31 +0100
Received: by mail-oa0-f46.google.com with SMTP id i7so1187656oag.5
        for <multiple recipients>; Thu, 13 Mar 2014 08:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Uo49VGvMjrYeopgvtW8Xii9vr8zGN46jXCd2TplNJc=;
        b=TZNotD7nLbGbpHx3pxIjw6jbW5sw8Yf204IpH/LAX4X6JdfwiSz3fJTWujn3mmcQxT
         Dbf6obuS0L/3XQZRegqtB7WxsWg+LGVwruneX6ZAS2umuGfNSDGmxvK+jYl1eIODloRf
         on3If0EmAN7BjWBpz2/clR07QP/7X61lcq34VCsLcD7xW5/t1ZtrAfv/xRvsLoU74/is
         GbBUjZCoUO1EoRc9wpoMOvh79PcC8CIA4j+zEoi6CNAP4b7CCDBlc+YThnZECuZGgDw8
         mDGvqpja5UAUrbT4q7VHSTgqwQZrVGwsGYwNUU1/GHOJGgVLNfpwYCbvGUItvqY2WAAh
         Bieg==
MIME-Version: 1.0
X-Received: by 10.182.92.231 with SMTP id cp7mr745986obb.82.1394724137229;
 Thu, 13 Mar 2014 08:22:17 -0700 (PDT)
Received: by 10.76.33.230 with HTTP; Thu, 13 Mar 2014 08:22:17 -0700 (PDT)
In-Reply-To: <CACna6ryED3bATWzR9uZOyyhcEbOLtCpvQ3D3MOa8R-_5pE0_2Q@mail.gmail.com>
References: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
        <CACna6ryED3bATWzR9uZOyyhcEbOLtCpvQ3D3MOa8R-_5pE0_2Q@mail.gmail.com>
Date:   Thu, 13 Mar 2014 16:22:17 +0100
Message-ID: <CACna6rwaCU8Z6TUsA_28JSTb+2HXGnWoCnO7Ab-9tDUX5VqCqg@mail.gmail.com>
Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when
 looking for a pin
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39463
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

2014-02-28 7:27 GMT+01:00 Rafał Miłecki <zajec5@gmail.com>:
> 2014-02-13 17:48 GMT+01:00 Rafał Miłecki <zajec5@gmail.com>:
>> Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
>> ones too. Example:
>> gpio23=wombo_reset
>
> Ping? Guys?

Anyone? I've posted this patch a month ago.
