Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 22:39:47 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34529 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027159AbcELUjpqoVP6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 22:39:45 +0200
Received: by mail-wm0-f68.google.com with SMTP id n129so18068286wmn.1
        for <linux-mips@linux-mips.org>; Thu, 12 May 2016 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyvJCgqCHje4UTlASMvxS/+uID7g8opeWNsR51A8QQ0=;
        b=onDWAkSisNPslBEPd1cMQPsEU3TZ7QX5oZqtssHP67nzy2rdskO1DY54OwVrUTvrI3
         2ieJUKHNn8BMhjYXnDtxejXNiFKxRQFfiBjtrNp/esvv7KScWnzMXnu28WCdsJd3LNtN
         +w8EBMJayScjBW4g9pow93PpbQy4CylCgKNKuyYbMonLPHdka/pxa0F5T8XkMGQeFPQr
         vORgTwvvdz2/L7rh/9k3n9b37WE3I+4Y2TUeUpMA4XYJqJbDRMpZi9dfAelxEdsuLxRs
         wODc6RsiMMq8V5CmYcPAtKqoGU+t1MvufT2X+rh9K8G5vD22loV8JfkHAgzymmosbLbp
         Yn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QyvJCgqCHje4UTlASMvxS/+uID7g8opeWNsR51A8QQ0=;
        b=KyKncEXBiA99NmZu3PxIO76ryvSmzKo5J6zUZGN8L5/nr3PRRo0qYH8eIXmKnnmFPS
         JJ+5gAVEUEHdK5NErI58Z5j59iFEKdTLFUbWi4DCVuSRjIz5lhhsHZyn44zM13YwlUMD
         doC4jx2mY/xOBTQKOIb8BfqBOV6scqc8RSduePgHF0CeXDDJCkumQ0oDe7rb5mXAf52D
         NeF8uJEFGz5clqzRb9n1PV2bT76IAVeAuRr9517XPj6R30QtVwjCNyA+AYWDabfjYDH6
         zC9Et5ofVHNb7jG8kgmvcFv0hLLc33UwvfeLjYmJWqxHwiCNVBWwGZ9/+P0nVoDwcbUQ
         2+rw==
X-Gm-Message-State: AOPr4FVkdtaoH8d0uL39b2HSQ3uu1pUdNh/5jC/WGcU6Cd+8bTxrdgjCcAqzc1apswNPmQ==
X-Received: by 10.28.139.137 with SMTP id n131mr8320994wmd.13.1463085580525;
        Thu, 12 May 2016 13:39:40 -0700 (PDT)
Received: from debian64.daheim (pD9F89BEC.dip0.t-ipconnect.de. [217.248.155.236])
        by smtp.googlemail.com with ESMTPSA id x124sm15524721wmg.24.2016.05.12.13.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2016 13:39:39 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtps (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.87)
        (envelope-from <chunkeey@googlemail.com>)
        id 1b0xOT-0004Jj-7j; Thu, 12 May 2016 22:39:37 +0200
From:   Christian Lamparter <chunkeey@googlemail.com>
To:     John Youn <John.Youn@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since 4.3.0-rc4
Date:   Thu, 12 May 2016 22:39:36 +0200
Message-ID: <50455529.fZie4vOnRh@debian64>
User-Agent: KMail/4.14.10 (Linux/4.6.0-rc5-wt; KDE/4.14.14; x86_64; ; )
In-Reply-To: <5734CE1C.8070208@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2856271.3aAGK3LarU@debian64> <5734CE1C.8070208@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <chunkeey@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53415
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

On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> > On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> >> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> >>>>>> Detecting the endianess of the
> >>>>>> device is probably the best future-proof solution, but it's also
> >>>>>> considerably more work to do in the driver, and comes with a
> >>>>>> tiny runtime overhead.
> >>>>>
> >>>>> The runtime overhead is probably non-measurable compared with the cost
> >>>>> of the actual MMIOs.
> >>>>
> >>>> Right. The code size increase is probably measurable (but still small),
> >>>> the runtime overhead is not.
> >>>
> >>> Ok, so no rebuts or complains have been posted.
> >>>
> >>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> >>> and it works: 
> >>>
> >>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> >>>
> >>> So, how do we go from here? There is are two small issues with the
> >>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> >>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> >>>
> >>> Arnd, can you please respin and post it (cc'd stable as well)?
> >>> So this is can be picked up? Or what's your plan?
> >>
> >> (I just realized my reply was stuck in my outbox, so the patch
> >> went out first)
> >>
> >> If I recall correctly, the rough consensus was to go with your longer
> >> patch in the future (fixed up for the comments that BenH and
> >> I sent), and I'd suggest basing it on top of a fixed version of
> >> my patch.
> > Well, but it comes with the "overhead"! So this was just as I said:
> > "Let's look at it and see if it's any good"... And I think it isn't
> > since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> > archs etc...
> 
> I slightly prefer the more general patch for future kernel versions.
> The overhead will probably be negligible, but we can perform some
> testing to make sure.
> 
> Can you resubmit with all gathered feedback?
Yes I think I can do that. But I would really like to get the
regression out of the way. So for that: I back Arnd's patch.
It explains the problem much better and doesn't kill MIPS 
like the revert I was doing in my initial post to the MLs.
Also, another bonus: his patch is suited to port to stable.

The auto-detection approach is not that easy to get right,
given all the stuff that's going on with BE8, LE4, ... So
can we have your "blessing" for Arnd's patch for now? since
that way, I can base my patch on top of his work about the
issues of endiannes? (Just say: ACK :) )

Arnd: do you have a version with the #ifdef lower/uppercase
fix? Or should I give it a try (and fail in a different way ;) )
 
> >> Felipe just had another idea, to change the endianess of the dwc2
> >> block by setting a registers (if that exists). That would indeed
> >> be preferable, then we can just revert the broken change that
> >> went into 4.4 and backport that fix instead.
> > Just a quick reply. I have the docs for the thing. There's something
> > like that in GAHBCFG at Bit 24... BUT it only switches the endiannes
> > for the DMA descriptors (which is not always used, there are devices
> > with PIO only)! It doesn't deal with the MMIO access at all. 
> 
> That's correct. It only affects descriptor endianness for DMA
> descriptor mode of operation.

Ok. The funny thing is that for the MyBook Live Duo this setting might
be important since the PLB_DMA engine is not part of the DWC library...
Instead it's from IBM and operates in: Big Endian :-D.

Regards,
Christian
