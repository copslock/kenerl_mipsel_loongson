Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:23:45 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:50470 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013482AbaKLJXoOyfgg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:23:44 +0100
Received: by mail-wg0-f48.google.com with SMTP id y19so2823572wgg.7
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 01:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=53R8vlXvPle6sR8rY5p7aNKCXfxmRMDwFapk1CtVujs=;
        b=JKoDZUjLCqRASav5B0zKt1mCqcqDOfhqJ9oUH7RZ9u9HT7DhO0W2HzTP++SoR8Liy7
         /GPs2SxgiAktkDnBZ8LVBDXzJaWApBmmxoQKRxixo6THylySze6xPhSbAA6gawPcuENz
         0B/Fv250QxWF07He19ilLMAz3c8jGjdW5V+xRMpBW2v+1u1r4SfN4mlIAwfRssc9X14t
         vLTdg8uWVathUJ2PgAMkSOABurfu+zP0rCgA2mzW1exdugWbDaN5aEEg+vPt0VSNdktL
         S6YJ/pM00RmUcwLzW4ZyObOotx3/z6bdlEOkhlWfc2OQNeKmNsl4XrlDapJjAvbw+nhI
         psEw==
X-Received: by 10.180.182.233 with SMTP id eh9mr40161111wic.31.1415784219082;
        Wed, 12 Nov 2014 01:23:39 -0800 (PST)
Received: from ?IPv6:2a01:4240:53f0:43fb::cbb? ([2a01:4240:53f0:43fb::cbb])
        by mx.google.com with ESMTPSA id wr9sm30608536wjb.42.2014.11.12.01.23.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Nov 2014 01:23:38 -0800 (PST)
Message-ID: <54632718.9030603@suse.cz>
Date:   Wed, 12 Nov 2014 10:23:36 +0100
From:   Jiri Slaby <jslaby@suse.cz>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, tushar.behera@linaro.org,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register
 endianness
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-4-git-send-email-cernekee@gmail.com> <54631F64.8080009@suse.cz> <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
In-Reply-To: <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 11/12/2014, 10:04 AM, Kevin Cernekee wrote:
>> This should actually return bool and use true/false.
> 
> Well, the other APIs currently return an int:
> 
> extern int of_device_is_compatible(const struct device_node *device,
>                                    const char *);
> extern int of_device_is_available(const struct device_node *device);
> [...]
> extern int of_machine_is_compatible(const char *compat);
> 
> Do you think it is best to change all of them at once, or just the
> newly introduced function?

Possibly fix all these in a separate patch and then add the new one
fixed :).

-- 
js
suse labs
