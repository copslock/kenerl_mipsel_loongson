Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Feb 2015 20:18:27 +0100 (CET)
Received: from mail-qa0-f54.google.com ([209.85.216.54]:44275 "EHLO
        mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006619AbbBTTSZW59o1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Feb 2015 20:18:25 +0100
Received: by mail-qa0-f54.google.com with SMTP id x12so13885162qac.13
        for <linux-mips@linux-mips.org>; Fri, 20 Feb 2015 11:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pz0CO5ddajunZrIoVi/xVhMMfkSMeyoFl6xYYSmeVBw=;
        b=YWRBeeYeAEKiV8Q447cql+PsCHdipoXuwHT9xFrb9Xq6NLDXJpKrmW4EZRIMVBwNz/
         tIQef/5VXrOMSw09nlckroa/SgmsQPzX2XDdQbQ/23E31JegISwHH2Arh+Uv0TYJOBdS
         i3l2ZWEiGAOxlUXSW52UOItF8hIP3ErniMFVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Pz0CO5ddajunZrIoVi/xVhMMfkSMeyoFl6xYYSmeVBw=;
        b=c13U2tRmQbyoMGVyAa+7PwDTscMjOXc1tpAXJRWfsVEqY4VkjseI1d6WO3QXfeVB9+
         QuvBDjfVrTf1pRkDQZwpxZ8FP6HKjNPDrSLxJ+9VjIsu9So8lnTVx6Z7rlAi3dBiNAz9
         ulmALHgMAmoefy2gKL427YyVSHY0qGKsTiX+fWctQTcBHY+cYB2DANcOig7TyHEKfItl
         j0cBaT7bWtq+2W6AW6+WSQzlvcbR1CgYx33Tpm/IB7LnRx6jS/5KOw+VBmQ1Jf2ZlvT7
         pWUqqovEROy8AacPc+u+g8OzzBMUqA5LaUc9bq1Gf1jP//MuKbFAxjQeHAm9U/oXsrt4
         Byww==
X-Gm-Message-State: ALoCoQn3KD9B7corfMRxMtY2F18VvpqmdHuWnkYflCD7VtCj6i2XAXMA+xO2ZNP1inYE0R+/SBPO
X-Received: by 10.140.239.136 with SMTP id k130mr27536630qhc.2.1424459899773;
        Fri, 20 Feb 2015 11:18:19 -0800 (PST)
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com. [209.85.192.43])
        by mx.google.com with ESMTPSA id 75sm11865990qhy.1.2015.02.20.11.18.18
        for <linux-mips@linux-mips.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 11:18:18 -0800 (PST)
Received: by mail-qg0-f43.google.com with SMTP id i50so15721289qgf.2
        for <linux-mips@linux-mips.org>; Fri, 20 Feb 2015 11:18:18 -0800 (PST)
X-Received: by 10.229.221.197 with SMTP id id5mr8459765qcb.16.1424459898308;
 Fri, 20 Feb 2015 11:18:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Fri, 20 Feb 2015 11:17:58 -0800 (PST)
In-Reply-To: <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com>
From:   Kevin Cernekee <cernekee@chromium.org>
Date:   Fri, 20 Feb 2015 11:17:58 -0800
Message-ID: <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with
 non-DMA I/O.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     IMG-MIPSLinuxKerneldevelopers@imgtec.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

On Thu, Feb 19, 2015 at 8:17 AM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> Flush the D-cache before the page is given to a process
> as an executable (I-cache) page when the backing store
> is non-DMA I/O.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

This patch seems to make several different changes to the cache
maintenance code all at once:

1) Add logic to handle virtually tagged D$ and perform extra flushes
on TLB updates

2) Add new write barriers betwen D$/I$ or D$/L2 flushes

3) Make __flush_anon_page() play nice with HIGHMEM on systems with cache aliases

and maybe a few more that I missed.

Would it be possible to split this out into individual commits, and
include more comprehensive changelogs for each one describing the
exact problem being solved?

Also, it would be helpful to clarify how this relates to the use of
swap (?) with a backing store that is non-DMA I/O.  Do you have an
example of a situation where the existing code broke?  A play-by-play
postmortem would make for interesting reading.
