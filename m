Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2016 15:03:50 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33269 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992497AbcGQNDna8rY0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Jul 2016 15:03:43 +0200
Received: by mail-pa0-f66.google.com with SMTP id q2so9255881pap.0
        for <linux-mips@linux-mips.org>; Sun, 17 Jul 2016 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYzHQiallarDhpYZJX6h0IKcuV6hXz8YNfxE7BMQ864=;
        b=CaegcyoVHkosIKoebMeZbgxgKg5vm4m00EdwDKkPH1vHQ+7K6qw8cuLPeb+uv+mybk
         uX2PzIjOJ3OJW91o+dH6sOEB52ak+9CetnEW43tMvDRyfaRXHzhfnVPHFnPk1Nn2OVUH
         XiSJgpg/1a8HcpZl1jkrtPrpsAZDu7QVPY67Ue6mk88biP/IeS2/zY4ciLwGGtJkCObk
         9rnLF5XWfBXyVLNUHR6fw8mAaeNQNWT/T055+xnSdnb0PUwKrs8i36CLNU9z19NV7cYC
         OA+VRHOW99fwG9ONPK3/wjAMwGOqHfxcv/GAB/QLmLBhUlP7FIzDSjyPJepde2h+ek11
         eWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYzHQiallarDhpYZJX6h0IKcuV6hXz8YNfxE7BMQ864=;
        b=JM/ARqn6nw/iUYkmiwCpw0GkuBtm+Mr3jOqx759rCHZXlJ+QBBsf91qzTwvlt8ydhj
         /1nuWUxiRmWx1EyBpveADH+ULs1grGqZnDqexBSxMKkCkXfkTpU+gxsmGRKiOigyVaQV
         KxjLFihSvcJFAomke/z1ahqryGw2N2gAoQjW30fhHa6d48ltAa024JlI39A5FBpZjPfV
         jf4gTf3f0ZO0mhNZiP6uITkzuBoQCJ8Idzms6MzzNkDSKSxJedrR7N6Ix3VNBmiMqIdt
         wlK3j4UD8zhaDE8icAwjfjyMmcVYmLE3RutW2iU1UERdbu0E2u8VnXMeYoNojqUzJfQb
         nXiQ==
X-Gm-Message-State: ALyK8tJlD8aqwQSEWk0kxPWY2xmeXH1JKzNI6QWcKvN1jBog7tAEnvja5HoZgQfmZWwyzg==
X-Received: by 10.66.26.105 with SMTP id k9mr48804911pag.103.1468760617548;
        Sun, 17 Jul 2016 06:03:37 -0700 (PDT)
Received: from ?IPv6:2601:645:c200:33:8448:14f3:f178:f083? ([2601:645:c200:33:8448:14f3:f178:f083])
        by smtp.gmail.com with ESMTPSA id e187sm2923308pfg.43.2016.07.17.06.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2016 06:03:36 -0700 (PDT)
Message-ID: <1468760611.6100.20.camel@chimera>
Subject: Re: [PATCH v2 2/2] MIPS: store the appended dtb address in a
 variable
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>
Date:   Sun, 17 Jul 2016 06:03:31 -0700
In-Reply-To: <CAOiHx==dcJMTaHggOW1skRcAfL7Zu3rOXGytvbz0rMi8O=zBcA@mail.gmail.com>
References: <1466414857-30456-1-git-send-email-jogo@openwrt.org>
         <1466414857-30456-3-git-send-email-jogo@openwrt.org>
         <1468758512.6100.10.camel@chimera>
         <CAOiHx==dcJMTaHggOW1skRcAfL7Zu3rOXGytvbz0rMi8O=zBcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Sun, 2016-07-17 at 14:52 +0200, Jonas Gorski wrote:
> On 17 July 2016 at 14:28, Daniel Gimpelevich
> <daniel@gimpelevich.san-francisco.ca.us> wrote:
> > On Mon, 2016-06-20 at 11:27 +0200, Jonas Gorski wrote:
> >> Instead of rewriting the arguments to match the UHI spec, store the
> >> address of a appended or UHI supplied dtb in fw_supplied_dtb.
> >>
> >> That way the original bootloader arugments are kept intact while still
> >> making the use of an appended dtb invisible for mach code.
> >>
> >> Mach code can still find out if it is an appended dtb by comparing
> >> fw_arg1 with fw_supplied_dtb.
> >>
> >> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> >> ---
> >> v1 -> v2:
> >>  * no changes
> >>
> >>  arch/mips/ath79/setup.c          |  4 ++--
> >>  arch/mips/bmips/setup.c          |  4 ++--
> >>  arch/mips/include/asm/bootinfo.h |  4 ++++
> >>  arch/mips/kernel/head.S          | 21 ++++++++++++++-------
> >>  arch/mips/kernel/setup.c         |  4 ++++
> >>  arch/mips/lantiq/prom.c          |  4 ++--
> >>  arch/mips/pic32/pic32mzda/init.c |  4 ++--
> >>  7 files changed, 30 insertions(+), 15 deletions(-)
> > [snip]
> >> -       else if (fw_arg0 == -2) /* UHI interface */
> >> -               dtb = (void *)fw_arg1;
> >> +       else if (fw_passed_dtb) /* UHI interface */
> >> +               dtb = (void *)fw_passed_dtb;
> >
> > I just now realized that this is also incorrect, on each platform. The
> > check for fw_passed_dtb should be in addition (prior) to checking for
> > UHI via fw_arg0 == -2, not instead of it.
> 
> No it isn't, the code in head.S already does this, so there is no need
> to check fw_arg0 again, unless you need to know if this was an
> appended dtb or a UHI passed one. The whole point of using
> fw_passed_dtb is that you *don't* need to check individually for UHI
> and appended dtb.
> 
> 
> Jonas

Not quite. The idea behind the old code was to mimic UHI bootloaders so
that the kernel would not distinguish between them and a passed DTB.
With fw_passed_dtb separate, the case of a real UHI bootloader is
unhandled unless fw_arg0 is checked separately after it. It cannot
presently be known for certain which platforms will have UHI available,
and it does not hurt the kernel to conform to an overall MIPS spec even
when unused, so removing the check for fw_arg0 even in the presence of a
check for fw_passed_dtb at this point is feature removal, which there is
no need to do.
