Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 19:56:37 +0200 (CEST)
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35970 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006684AbbEVR4dG02Xm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 19:56:33 +0200
Received: by qkx62 with SMTP id 62so17626178qkx.3
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KJ8BhgNmJdMknF44QkUkk3udhg+l33g7jpE8IygPt+M=;
        b=SUHXBV6DmTLXtAYXo60B4KvWe5EiHpOjmasUHEfpz/JV1YiSLt8bYO+jd1LZdrixHG
         86nzTgqVdCPIIY/5CqhCTV7t+NfnNXY6apRkQEtQjaziI4PcuHxDePNXtpcAWytHResL
         BJWGzDEM3IUUYFEZYTv04Bj8JqbafYBL6o24aOmKrHWQptr9ky5M2txG17DoNeQL+yHL
         k6ZfDWJu9Wc5PtbXeJmrg5ZpJ7ak0oLkm/Dpg1t7u4h8C20mUQK8k/+AUOYiYqCGsR4J
         Mgy3wpHu4yQ/pSyjekraVwQPtPTlMmg9vetidGhOrJ1Xnialb4rXS+9McTPJ7i+xV7cF
         IkVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KJ8BhgNmJdMknF44QkUkk3udhg+l33g7jpE8IygPt+M=;
        b=fX15KZYVQ9CanVNqDJ/AT2EYeoV7LtGfjV4dWeSmsx5+rOZ9KLTq8mf7dgPQYJSAfe
         XbzjkbXm7dyqSrQgiFiIZ02YzvRuK/QMPjyTYXFGGJvTAfriKSWtUdivyjBFru/NhFVh
         fOCDtXczIISJ3vxqtZBG9hkde5BgT9I9/K34Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KJ8BhgNmJdMknF44QkUkk3udhg+l33g7jpE8IygPt+M=;
        b=iseylQNYJdDSW4Qrdc6flXUm3OJAmjJM5k8rilzbUk9k7LxgCgJ+ll9h6E8L4EGiAG
         YnkTCkbuNl5edAeMcjNA9gJdOHc6gcUvY5YRW/bEfzE3g0yJqviJWKDhgfywK65etabs
         5z4NoOoM60HnwjSc+16qOFS0usLe8Cd6qFtVnygHYdxCk9iWAH4eo2/lb1FjpQnp+0M1
         wjKXFkQqZ429kMSTktOfeJHE7HDcjCdjX56mzNqAGjyIl+fSUqCQ4MWs2IZE8bMf5swC
         0eK/zBQdc0wBGMoQcqMcc2OwXE8TdJ6hh2tBHhf4BVn8qi/HJX8yrBHePdSf6xiJ6puW
         fPSQ==
X-Gm-Message-State: ALoCoQnFNqXDyLs98RLeJJB3bm+TVq4Rgm7rCGMhX/Rvazd7PSEeEinADESK11L9Z06jTZ32MOV9
MIME-Version: 1.0
X-Received: by 10.55.56.8 with SMTP id f8mr20519384qka.97.1432317389512; Fri,
 22 May 2015 10:56:29 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Fri, 22 May 2015 10:56:29 -0700 (PDT)
In-Reply-To: <1432252663-31318-10-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432252663-31318-10-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Fri, 22 May 2015 10:56:29 -0700
X-Google-Sender-Auth: BKI8Q7Y-I5lMURvewX9qLgkgXQI
Message-ID: <CAL1qeaFJBtjzDGqqa-qRb=+5_36QCyssGAKAZk2A2Tos3xK5LQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] clk: pistachio: Correct critical clock list
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        James Hartley <james.hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47585
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

On Thu, May 21, 2015 at 4:57 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> From: Damien Horsley <Damien.Horsley@imgtec.com>
>
> Correct the critical clock list. The current one is wrong, and may
> fail under some circumstances.
>
> Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

The commit message could be more descriptive, e.g. explaining which
additional clocks must be enabled at all times and why, especially
since forcing on clocks form the clock driver is very much frowned
upon unless absolutely necessary.  Otherwise,

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
