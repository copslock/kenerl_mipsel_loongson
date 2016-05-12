Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 15:30:25 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35366 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026834AbcELNaXf5dwu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 15:30:23 +0200
Received: by mail-wm0-f65.google.com with SMTP id e201so16109146wme.2
        for <linux-mips@linux-mips.org>; Thu, 12 May 2016 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9pop2LP4zSTsTUBwiYxpxodLWQnhI6MVDIvsvYXzUk=;
        b=lTK/n6br44Z0CqKC409djR3fpmduW21kBB35FdE0CfbGJmtzaqb819BEzukhfzWrDh
         LiMBOHA/gbCG60RPC/2VGVM66UWchxK2r3/UOgdLphY7QeJMvffTwZjWT5WvIHm/wFnN
         uNL4bVyaJa3t1yjqnjmKtZqnQNxC4wHpsaYfr9TC24LW2iVPweLwyzwkFW1l9C5vkcYL
         fPh5cVXAi8yhxT42sdtzjwN8JTwvzdFmcr+FO9/7z4WQ4BCeSwN47GOJr/81JoU36SXg
         g/yG9kfFc6u3x5snTsITC8wodu1N2E6JG9WLy0Zpfk6naQRr6jiFQR9XbiIwGvOxwBCu
         yDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w9pop2LP4zSTsTUBwiYxpxodLWQnhI6MVDIvsvYXzUk=;
        b=RVsPLfMm0DZvjD238C9ITweKxl6sTvsyfu2ubToQTl6xKKb8eSryiPg2RfKP5odWvp
         VY87XAs/pOWUdt4+RKWrg9BtxO+kZnOOzo1eTxdawFsKNqCirQhTAvvh8cDq9o0IWQHJ
         LSKaqg/FJi+iK92ydLBezRS+z5i+MsNsY+TYdhZHfbgpwYVOXd6Eigy4+yBhPmkdWEu+
         dXp5+uoQBqqOQ99koNaDb9FJjq/nBpEr3RGhQ1w5a+G4C2NiR4DMUpF0lDVybZ28YIwW
         Uvf79xbChngElkiogLFZtL9zPPZ8yRI3F6wDizDZSONu5EL48edhG5pQV2Z1U7hEsuUV
         QRCw==
X-Gm-Message-State: AOPr4FWfpugKqFrMZCDGEeG9e8tvIOMLa5MTkloraBilkPfdanmI3stB/wizawGY0ouI6Q==
X-Received: by 10.28.184.78 with SMTP id i75mr11127573wmf.36.1463059818308;
        Thu, 12 May 2016 06:30:18 -0700 (PDT)
Received: from debian64.daheim (pD9F89BEC.dip0.t-ipconnect.de. [217.248.155.236])
        by smtp.googlemail.com with ESMTPSA id kc2sm11419900wjb.5.2016.05.12.06.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2016 06:30:16 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.87)
        (envelope-from <chunkeey@googlemail.com>)
        id 1b0qgx-0007uM-Cs; Thu, 12 May 2016 15:30:15 +0200
From:   Christian Lamparter <chunkeey@googlemail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Thu, 12 May 2016 15:30:15 +0200
Message-ID: <2856271.3aAGK3LarU@debian64>
User-Agent: KMail/4.14.10 (Linux/4.6.0-rc5-wt; KDE/4.14.14; x86_64; ; )
In-Reply-To: <2924514.Pic5Z1NUsc@wuerfel>
References: <4231696.iL6nGs74X8@debian64> <7745292.ZB3149zIk7@debian64> <2924514.Pic5Z1NUsc@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <chunkeey@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chunkeey@googlemail.com
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

On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> > > > > Detecting the endianess of the
> > > > > device is probably the best future-proof solution, but it's also
> > > > > considerably more work to do in the driver, and comes with a
> > > > > tiny runtime overhead.
> > > > 
> > > > The runtime overhead is probably non-measurable compared with the cost
> > > > of the actual MMIOs.
> > > 
> > > Right. The code size increase is probably measurable (but still small),
> > > the runtime overhead is not.
> > 
> > Ok, so no rebuts or complains have been posted.
> > 
> > I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> > and it works: 
> > 
> > Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> > 
> > So, how do we go from here? There is are two small issues with the
> > original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> > #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> > 
> > Arnd, can you please respin and post it (cc'd stable as well)?
> > So this is can be picked up? Or what's your plan?
> 
> (I just realized my reply was stuck in my outbox, so the patch
> went out first)
> 
> If I recall correctly, the rough consensus was to go with your longer
> patch in the future (fixed up for the comments that BenH and
> I sent), and I'd suggest basing it on top of a fixed version of
> my patch.
Well, but it comes with the "overhead"! So this was just as I said:
"Let's look at it and see if it's any good"... And I think it isn't
since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
archs etc...
 
> Felipe just had another idea, to change the endianess of the dwc2
> block by setting a registers (if that exists). That would indeed
> be preferable, then we can just revert the broken change that
> went into 4.4 and backport that fix instead.
Just a quick reply. I have the docs for the thing. There's something
like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
for the DMA descriptors (which is not always used, there are devices
with PIO only)! It doesn't deal with the MMIO access at all. 

The pin that would select which endian the device uses is probably
connected to a DCR or GPIO but I don't know which or where so this
is more or less useless. (Or the selectable endianness was dropped
during synth).

Regards,
Christian
