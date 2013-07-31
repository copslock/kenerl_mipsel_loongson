Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jul 2013 21:26:14 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:65177 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827280Ab3GaT0Ld0nnW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 Jul 2013 21:26:11 +0200
Received: by mail-wg0-f47.google.com with SMTP id j13so963185wgh.14
        for <linux-mips@linux-mips.org>; Wed, 31 Jul 2013 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=E38yIpHMuGTajVVJXrSdFpidfP2iOvaz4LAXL6esRDg=;
        b=a0tkqISZNIZKxrahocAv4KVxe8bGDsNxhK98q4RGENKcicWIHALgo3IKdrpayX870e
         rhLXO+hS1rSHGg6Yl60EuaiuOBsOYm2amA1JW6zW2x7rywLQZ1MVMkOISQBzJryuJrlA
         LDyul9EhZya5joru5yCIQlgB3o+oawVg42qc+LqZTOK8PXArSRC2UafYJn0LHqrknWxT
         FKlfmp48nS2B7XlzOqrGq6+xgwZGo27lAba+XshvibkpiqHoZoXFRmnnmidxtEi/2RpC
         H25VqmKxQxuG3KQuixGewFK3NOyq+W5nMbGp/tekd5WLhk2SIm6PmsjFUZRP46IWeCPF
         ClTQ==
X-Received: by 10.180.89.101 with SMTP id bn5mr5254640wib.45.1375298766186;
        Wed, 31 Jul 2013 12:26:06 -0700 (PDT)
Received: from lenovo.localnet (cpc24-aztw25-2-0-cust938.aztw.cable.virginmedia.com. [92.233.35.171])
        by mx.google.com with ESMTPSA id l2sm267151wif.8.2013.07.31.12.26.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 12:26:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
Date:   Wed, 31 Jul 2013 20:26:02 +0100
Message-ID: <1687511.8JA8mPPmNW@lenovo>
User-Agent: KMail/4.10.5 (Linux/3.8.0-27-generic; KDE/4.10.5; x86_64; ; )
In-Reply-To: <51F963E7.50407@gmail.com>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com> <51F963E7.50407@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37409
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

Le mercredi 31 juillet 2013 12:22:15 David Daney a écrit :
> On 07/29/2013 04:14 AM, Florian Fainelli wrote:
> > 2013/7/29 John Crispin <john@phrozen.org>:
> [...]
> 
> >>> It looks to me like you are moving the irq setup later just to ensure
> >>> that your ralink clockevent device has been registered before and has
> >>> set cp0_timer_irq_installed when the set_mode() r4k clockevent device
> >>> runs, such that it won't register the same IRQ that your platforms
> >>> uses. If that it the case, cannot you just ensure that you run your
> >>> cevt device registration before mips_clockevent_init() is called?
> >> 
> >> i dont like relying on the order in which the modules get loaded.
> > 
> > plat_time_init() runs before mips_clockevent_init() and the ordering
> > is explicit, would not that work for what you are trying to do?
> > 
> >> the actual problem is not the irq sharing but that the cevt-r4k registers
> >> the irq when the cevt is registered and not when it is activated. i
> >> believe
> >> that the patch fixes this problem
> > 
> > Your patch certainly does what you say it does, but that is kind of an
> > abuse of the set_mode() callback.
> 
> I might as add my $0.02...
> 
> There are many other clockevent drivers that do this type of thing
> aren't there?  The clockevent framework uses this to
> install/remove/switch drivers, so why should cevt-r4k not be made to
> work like this?

Whatever works for you. I still would like to understand why plat_time_init() 
is not suitable for John's specific use case.
-- 
Florian
