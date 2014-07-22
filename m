Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 19:50:58 +0200 (CEST)
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60270 "EHLO
        mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6863128AbaGVRPAMp8Uf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 19:15:00 +0200
Received: by mail-oa0-f42.google.com with SMTP id n16so10236151oag.29
        for <multiple recipients>; Tue, 22 Jul 2014 10:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y7Zw5SNUxl+Xjw2+7jxBq8/4hBDrzZMTTTSk8MCTDXE=;
        b=h4rFRrSK1c+NrriIKgVInQ0DGEVKOwGBhdJIFDFZIiH7b6C4HjW9SfQP9E+utfrOFc
         V7jWOAp/lvumwxij2NcDMxT1wJE7yY4DOy3phmP0AyNBuE/23RUUVy14m26fSbYr9ebO
         +s+bj1bFObvnM6d09YwRdUEOfh80FnEzFIUTJp8KdXC+IJwffVf5aVbqlleHZq70fjrN
         CKushwxCWlUjdCnUWVzjzn3GmGTE+/IxYeHpZasUSuZ+F+QpPXTnnyg1dpZ6Cuysuld/
         kwp2pnzJw8Wq5AZFA/W636XlzzuIHQz84n9vwVomvUT+ioN4dxYA3omSzxV7e/ewt0tV
         8Pmg==
X-Received: by 10.60.70.205 with SMTP id o13mr50257886oeu.38.1406049293280;
 Tue, 22 Jul 2014 10:14:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.9.82 with HTTP; Tue, 22 Jul 2014 10:14:13 -0700 (PDT)
In-Reply-To: <CAPDOMVhUkF49L1jJgfXdRdMW2qkGsbPfGVwrdaETqTUs3bEcsQ@mail.gmail.com>
References: <CAPDOMVhUkF49L1jJgfXdRdMW2qkGsbPfGVwrdaETqTUs3bEcsQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 22 Jul 2014 10:14:13 -0700
Message-ID: <CAGVrzcb665srrVTojY+E1Raec5=E6oK+CAdPrP3Fx15Zt+piBQ@mail.gmail.com>
Subject: Re: decompress.c : Add cache support
To:     Nick Krause <xerofoify@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <blogic@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41480
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

2014-07-21 21:24 GMT-07:00 Nick Krause <xerofoify@gmail.com>:
> Hey Ralf and others
> We seem to be flushing this cache after decompressing the kernel on
> mips. Can't we cache this?

I am not sure I fully understand what you mean here. What would we be
caching, instruction, data, both?

> If anyone has any advice on how to fix this it would be great:).
> Nick

One patch that I carried locally and which works for a bunch of
MIPS32r1 compatible platforms out there is this one, I tried to
address some of Ralf's comment as well about the code duplication
(maybe I can get around to resubmit it):

http://patchwork.linux-mips.org/patch/1565/
-- 
Florian
