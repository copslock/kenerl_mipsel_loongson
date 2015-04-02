Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2015 18:15:17 +0200 (CEST)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34411 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006802AbbDBQPQBrJTM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2015 18:15:16 +0200
Received: by qgep97 with SMTP id p97so73537586qge.1
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2015 09:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+n6QV247qATx9WV8hn7iSL+YaeNL+B53Ep2E26SRjN0=;
        b=BjwT/2o666daBmMAlBac809ZtPNVfxmcTn0dImGij/jfenO7s+z5AJ94fZYho5fb4t
         gbKle77uz1xRa48W7qVH8jQ/QNd9/Y8AHrfK1v/zH3RO6/PSq9DMtKFDzEHNxlzWV577
         OEj8trBmsgWF67NvbO1XAKJ6GlSaFcoBPOmNTa0Zk4kiZlDfft1Pviwy2lbaiS5lLVSw
         h+IV3CrU+G8Ts5gLBzWLKD8RBie3Tm4zy1srT4t5qjTglvw21YAZU5iahzFV++y0tGVk
         JaMjK+knqTkIZ5o1h9QaFPqmY11AFYoSG4GAL2kbTbUBkBWxPMGVSGTNkkMKgkx9DDwM
         SLvw==
X-Gm-Message-State: ALoCoQl+0nE8S/2rLINSf0bBBeZyU4WvKBrrYtQz0dVJr/sRXl5/Ue0tVD3EPcl3fPQCIVVS71Gn
X-Received: by 10.55.21.221 with SMTP id 90mr24870112qkv.44.1427991311243;
        Thu, 02 Apr 2015 09:15:11 -0700 (PDT)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id o4sm3732849qko.49.2015.04.02.09.15.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2015 09:15:10 -0700 (PDT)
Message-ID: <551D6B09.6060100@hurleysoftware.com>
Date:   Thu, 02 Apr 2015 12:15:05 -0400
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
In-Reply-To: <CAJiQ=7AS5+HkHcjRsYKi-EHVc3F1fg3Zp=1fCor1HrKeSWU72Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 03/28/2015 03:28 PM, Kevin Cernekee wrote:
> Side note:
> 
> AFAIK we still have a problem if somebody wants to build serial8250 +
> (any other tty driver that occupies major 4 / minor 64) into the same
> kernel, and use DT to pick the correct driver at runtime.

Yep, exactly.

> serial8250_init() starts registering ports before it knows whether the
> system even has an 8250.

This behavior is required to support hw configuration from userspace.

> I talked to Rob about it earlier this week
> and he suggested that you might have some thoughts on how to fix it.
 
A big piece of that will land in 4.01 (once I get the actual 8250 split
commit to Greg).

The 8250 driver has been split into a legacy/universal 8250 driver
and separate port ops module; one of the benefits of this is that the
objectionable legacy behavior of the 8250 driver (especially limitations
wrt ttyS sharing) can be left behind in that driver without breaking
existing users.

The idea is that an alternate 8250 driver(s) with none of the legacy
baggage can be taught to share (4,64) ports with other drivers.
Unfortunately, I haven't made further progress with because of other
projects.

Regards,
Peter Hurley
