Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 21:53:56 +0200 (CEST)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:51276 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011629AbaJPTxyZayZw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 21:53:54 +0200
Received: by mail-vc0-f180.google.com with SMTP id le20so3278922vcb.39
        for <linux-mips@linux-mips.org>; Thu, 16 Oct 2014 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8+h/+Gxa6tdLIUGWuhNCIXOy4K4rsKLsaqlKcQVewNY=;
        b=ZAOp5WuIIzBIJ8PHIL2QxLb7vCJ2UavcblQFYdsUI+vLFh8fQo8gFrtEUhx7rxrRro
         nsHyDdPx+FddV3cId2pkeRMw0OUxSDJ9vKrhyQpFcAZc5Gi85FRhxUmp/WNNryKhRRQ3
         mRKduV/wSURSV0XrMBT0zby2x1u0wUVP8QpCXsYAsXSukes8bTUHLgqdik0Km/yVd5Wp
         jetdq3sEsrY5XrXPVHfz1dI3khR7AkDDWG6WI94513vJS5KJtl4LbR1HyincHOu0DR/z
         0OKbmMNPzUgRYPhlNeAncMBkEy1kc0xVqgGWGpsT19ogTIb1abznVwfklJiaCjtm/ej0
         tynw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8+h/+Gxa6tdLIUGWuhNCIXOy4K4rsKLsaqlKcQVewNY=;
        b=Ch8FfhGEI9jjYA6FFjStALeTyDtuFNqii+FImON0B9BMq63bvPIan3e6LxgPgdTBZF
         eiJfklB+5BOXg5UQRn1xHbtVYEWtJOxbqC8eX4RWz/sB3LnjYIMH0Yu3ZyTwydyruOj2
         hVj5jdZMT3xoioTntabU/pU/4wTddTRI5ZenM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8+h/+Gxa6tdLIUGWuhNCIXOy4K4rsKLsaqlKcQVewNY=;
        b=UTnmpCq3g2pGf4tmRu9HWPY6HvEG7dPHKAHorJbQ3Pia8YKT//e3kwKofx5VTcRgm0
         pgvrd/khMPs67WUMvVFyrY3CZrWV79VhDYaxrOZv6OyKMJ4SnHL3HlhMHM+lfl/+Z84T
         Ijx03xYCS45dfTK9M6f5EZyFea9XhgERx1AFpZ4obwHTxI5U/TZS1qdzL5+W/v+cC2I9
         6EMu7K1v7X7JT/L6Yq7ehWF/2DloR8dgPDCokocf/uG74UH/Mwpw1Ba8RYZ5B3oYIq1Q
         BcRIlL+LOjOEKvw6aFEsKUQJlwEjGVYLhLQzmS850tYAN5cmejwp9mnpRrHA3/tENmRP
         idOw==
X-Gm-Message-State: ALoCoQnV/hU9k6QQ57bGmlzW4xMv0pdJ1MWQA2S0yfOIaOlKzqe3dswOX8JW6l30FoqxadF9KSGh
MIME-Version: 1.0
X-Received: by 10.52.37.71 with SMTP id w7mr3061130vdj.27.1413489228195; Thu,
 16 Oct 2014 12:53:48 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Thu, 16 Oct 2014 12:53:48 -0700 (PDT)
In-Reply-To: <1413198978-61926-1-git-send-email-blogic@openwrt.org>
References: <1413198978-61926-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 16 Oct 2014 12:53:48 -0700
X-Google-Sender-Auth: 2_Q20bbPoA3qFOyJ7eeKtfmFUIE
Message-ID: <CAL1qeaF5am7hDDWn_0Kxu9adv27uG6R9WWNk=AG06iAA_qJt6Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: disabling CM regions deadlocks mt7621
From:   Andrew Bresticker <abrestic@chromium.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi John,

On Mon, Oct 13, 2014 at 4:16 AM, John Crispin <blogic@openwrt.org> wrote:
> While updating the mt7621 code to make use of the mips-cm i had to apply the
> following patch to get the unit booting. With this patch applied the SoC boots
> fine with and all 4 cores work.

Hmm... where does it hang?  Can you tell if it's the access to the GCR
registers causing the hang or some subsequent access?

> The MT7621 has a broken iocu so i guess this might be related ? could someone that
> actually knows what those registers do enlighten me please :)

Adding Paul who probably knows more.

Do you know what the initial values of the GCR_REGn_{BASE,MASK}
registers are?  Perhaps they're initially enabled and by writing the
base address first we screw up some translation?  It looks like just
writing 0 to the mask register should also disable the region, at
least according to the interAptiv manual I have.
