Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 09:36:41 +0200 (CEST)
Received: from mail-qt1-x842.google.com ([IPv6:2607:f8b0:4864:20::842]:39351
        "EHLO mail-qt1-x842.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbeJZHgh4Blnu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2018 09:36:37 +0200
Received: by mail-qt1-x842.google.com with SMTP id g10-v6so200867qtq.6;
        Fri, 26 Oct 2018 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8s8U3JSu5h8uRbuI5LIATNyorUWP4l/UhJUD3ZFyujk=;
        b=iTNd9j5UsWAntMBrUEskClvdHJ5HZvVQm39le+y0dQkH+Du9a1NfiAN+jaUvrA9ZRu
         pfLgynOyW4f8Y73D+ov0j8I4UqkoXM5NaRjbrqJsIp3iCGWkwpazuQMztRBPUBcyXGdg
         WPQf+Z3GC9Q9tS6upTCzfk60xEpe2i7EWNakaMX4SHdavWWM/MdXbrGPgC/ueCAijPp6
         MW0Au63+D0MQE86TnyTHmwXEPqPq5IPD1+Bf1qp45+KneNX4bONtC66IjIKcJKdSn5H9
         6GER/36/h/q5ivtNNQdpBzLT+yrx1dP5S/SJ9k1ZUzgkNHnmcadCk6NTYPURC3x3/U/u
         8KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8s8U3JSu5h8uRbuI5LIATNyorUWP4l/UhJUD3ZFyujk=;
        b=IjbaGD4SoNSFmIj0bItggnYie4MFjlMVIQHRq6T2XWTUySZsUROhp/fP+j+1Ssq1NC
         JxYHVG0hsuQo1bGqYHHZjj69Z6Nb9xXx9EC6YUby+4C1jW1SdBqj35KzOoC3Y365Vyqy
         DsRq7m5cIuOPKhbG7fNRkuF/kGMBjbJi+GcTzNxBxQHS1NW8nh+JS+FCgec/y4ORUsk2
         /uHggllrklJbNG1mJqJlANA5M2pNZ16FpEXBXakFrDEObcvPYTVZF8BFVs8GO4ExsmF/
         auTf4Ki+n9f9YJJIyEBsb1HTw7pX+VHK0WqlYz5trcZRZ8V83uxOeKFhx5m11cwPE3nj
         1VPw==
X-Gm-Message-State: AGRZ1gJLrs0ABzbmuKxOMNm2XlhOL9Qz+x//h0mM2oiuRQLomG5VeBjP
        sr7nIajj8KHHjBYMhgB1/BMVVHHHI5EbV0JxpXU=
X-Google-Smtp-Source: AJdET5fbxJ18ZZbIJjbZHtT4i7DtfwMB4ZlZXfLx6mEJWWrbGsUEtnBuzmkFTTiHySJfzkZRH7HR8R62HYRJ4AEUqOA=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr2118326qtl.343.1540539391683;
 Fri, 26 Oct 2018 00:36:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 00:36:30
 -0700 (PDT)
In-Reply-To: <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
References: <20181025141053.213330-1-sashal@kernel.org> <20181025141053.213330-33-sashal@kernel.org>
 <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 09:36:30 +0200
X-Google-Sender-Auth: 0bljCwgwnlGGTJ5q_lvavqjly3U
Message-ID: <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
To:     Paul Burton <paul.burton@mips.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On 10/25/18, Paul Burton <paul.burton@mips.com> wrote:
> On Thu, Oct 25, 2018 at 10:10:40AM -0400, Sasha Levin wrote:
>> From: Paul Burton <paul.burton@mips.com>
>> ---
>>  arch/mips/Kconfig                |  1 +
>>  arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>
> In principle I'm fine with backporting this - it does fix broken builds.
>
> It's only going to be of any use though if you also backport commit
> 04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h"). I'd
> recommend backporting both or neither.
>
> In practice I think it's unlikely anyone will need a microMIPS kernel &
> be tied to the particular versions affected by the bug this patch fixed,
> so I don't think it's a problem to backport neither.

I think the current practice of the stable kernel these days is to take
both patches in this case: They fix an actual bug in the mainline kernel,
and it seems unlikely enough that they cause a regression if backported,
so putting them into 4.14 has more advantages than disadvantages.


       Arnd
