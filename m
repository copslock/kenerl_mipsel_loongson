Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:10:25 +0200 (CEST)
Received: from mail-vc0-f172.google.com ([209.85.220.172]:46041 "EHLO
        mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVKYvchS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:10:24 +0200
Received: by mail-vc0-f172.google.com with SMTP id im17so13063396vcb.3
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6sYLeSMVu4e7r5Cwge8vpTLmh77m0mY++pgu/J+ziWE=;
        b=WsMWTzgBsi8p09auqtrRSXneczSLm+gwKDc54ANcfwfL/HU+dQVeoW4S0z/MFE3iZT
         LRcdfB8l41KKtFkdrqX0JBPAhHU7vb/NDGAoNU03TpvMDfpRYEnq3MV3iljQzQ3ocmBe
         a+LcLdEKuGk9lAXdYlFLV9xQZkxzHxLIbuDPqN6X5LkEEt5wp42NTB83AU/+04KuQLMN
         Xp8J4CZo5F6F14Tk7ATXhV5OThljC0KIYR6GawLLnbaBnwM90ukPG2cT49URGD93h79j
         vShr9O1yZjKGjjUsBLTvVvpoIEVWYROPYieUTB+Alw7oyekvgHKP3Rz+uK8sgldst2PH
         Of7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6sYLeSMVu4e7r5Cwge8vpTLmh77m0mY++pgu/J+ziWE=;
        b=iWcOtABfpD1nvQ1LT3Gw0SFPsdQNAv6UZ3+cII1Mq+EgXwzjHZsGwlfS5ezxpM4LEj
         OIHg/6m66iE7I4SnxRgoV67qKr5P+MpAPlkCeDFmny9KjlN1Sp/P3fRCz+rn/bDLbXfC
         SOA/WtuZlfiGEPnApmeioIo44VzA+IlffHQog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=6sYLeSMVu4e7r5Cwge8vpTLmh77m0mY++pgu/J+ziWE=;
        b=D2VyeRsfPm88QV6sWa0qWddY+ZHqlefDmrf1DyiNkyyC7jbyZdkZh1uqUlA3AxPZC4
         3lNW65JVhkhYzrL6IHnwUct2EvUy8GlusfDVgk7OL9HVt/Nxh+HlXicCEfkzfd6j3H8n
         N5y6Qobe6FsPxa/tPzeBaFFraIm2yr8cimPAwboZzw4BNMTcAx4oAq/QaTpONC7+7/Ho
         35kyawR5xctSa0RxTwC44JbogvyhPRxYfFtrYHvz6jsyruEwARtv664A0M8uGn/d0hee
         tMgaDpCVXQsGgfp3JGVdojuXnP/GqEi95VXJGKEqTu8KWW1Ev6ka7D3xDipS0KLx5TvB
         cHKQ==
X-Gm-Message-State: ALoCoQnR/D/aXMFJKgZ0BXsydEYs21dCmufwAwNg5v99zNlFg3TvOvMB1qVGJ+jI4t8lIn3xgYsa
MIME-Version: 1.0
X-Received: by 10.220.190.197 with SMTP id dj5mr5398776vcb.19.1408741823846;
 Fri, 22 Aug 2014 14:10:23 -0700 (PDT)
Received: by 10.53.5.133 with HTTP; Fri, 22 Aug 2014 14:10:23 -0700 (PDT)
In-Reply-To: <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
        <CAGVrzcZobuL4z0WNX+Sz4p_uwaPL-S5yvEmgRUwZPJi4+qq0tg@mail.gmail.com>
Date:   Fri, 22 Aug 2014 14:10:23 -0700
X-Google-Sender-Auth: Xts5yKtEyb28XbhiEuJCARUpm1s
Message-ID: <CAL1qeaGb-o0P7x4nZPJ+dGfoSKz+2ANrB0gGrBi19TtPxVTAZQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] MIPS: Move device-tree files to a common location
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        John Crispin <blogic@openwrt.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42177
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

On Fri, Aug 22, 2014 at 1:42 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On Aug 21, 2014 3:05 PM, "Andrew Bresticker" <abrestic@chromium.org> wrote:
> >
> > To be consistent with other architectures and to avoid unnecessary
> > makefile duplication, move all MIPS device-trees to arch/mips/boot/dts
> > and build them with a common makefile.
>
> I recall reading that the ARM organization for DTS files was a bit unfortunate
> and should have been something like:
>
> arch/arm/boot/dts/<vendor>/
>
> Is this something we should do for the MIPS and update the other architectures
> to follow that scheme?

I recall reading that as well and that it would be adopted for ARM64,
but that hasn't seemed to have happened.  Perhaps Olof (CC'ed) will no
more.
