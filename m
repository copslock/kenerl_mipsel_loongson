Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 23:06:31 +0200 (CEST)
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33540 "EHLO
        mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012850AbbHSVG3No0sh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Aug 2015 23:06:29 +0200
Received: by igfj19 with SMTP id j19so118382426igf.0
        for <linux-mips@linux-mips.org>; Wed, 19 Aug 2015 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uf2kRMRiels5r2LZfdSC0HsbNx2xKQaaRvrjLcBM3eg=;
        b=In7QqqH2Tcar+qbdNB+dqyhBHhGwH5KT1p7ZMZO6d51mXFMtnWaWX/+qLohYvRRoFI
         TFfqA8Pa+qap4XwffKYe4xs8n+0/103NGbJw+dQNpZlWUCSksBNX65bE+GjYegoMgxSt
         fd+2x9OBP+UZJkXIaSX2QxUIdOH10+XFIWHPaMcGuuOmI+K0Q7E1SFx9qC7MdlCCepXj
         M6h6/M1gXF/MChl4Jqj0ZEtBHXhfcULmHr05s7flGHBtL++zyXKoGrNflEKavX3X0mFO
         yrGQefKnRE8rOoifEqCCZNtsUht3e70GjWnNXnI1QA4cDV82HmXO2xoWuEpOGCvMydYl
         BbVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uf2kRMRiels5r2LZfdSC0HsbNx2xKQaaRvrjLcBM3eg=;
        b=etr+fqYsmW68PxiYNuuRSdH0bLbTcNR3DCHUDUmJFbRPP/4Izlhhb1hnL/L79Br+V8
         H1Wb+cyAouor242gJEcuw1TlGivx53hUkeKoNKg2MiUK044PxjTCnDOkBNCLxfA0Xjor
         atEx1CWzY2sTtlSGQoab/cyTaIthgYkuWJcxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uf2kRMRiels5r2LZfdSC0HsbNx2xKQaaRvrjLcBM3eg=;
        b=GY7NLQSeLNMh2dCnWQYksC9fecSfZ3QWi0TbPR4bNOX5IwFSsacLbwc7XggHz9L8vq
         OzW8KRFCBBGiI92nwIs8Q6f0O56lhDRPlA6xwW7Ic20Y2aEjVO++2K0uswxnQLRchMhm
         4VpI5a8z4MVLpwUZsyfjQ4HhHkZxo2HSCsZ7BxWTsvej4zfmD3SmYnq3Kg7IXbaim/nz
         aqHLp9/Zr5fOMoXKpsEpPZeDH+ZDMp/Hny4JWDnxztiVVC4ZoH3iwlm/K2sFk77UO9Gf
         NsTR5bQT4qNiteCHxo9+hvNlr+6Nf/PekHrbXyAvXnukiDlh8F/XRUGyM0uUbKA8G6+n
         9tuw==
X-Gm-Message-State: ALoCoQkNt8dASB5rbk7NaadJvnynO6vsqa15QeM7tGMYgm7ZlBzyv0WOy/rDM5gFPo4QkYt68Wj7
MIME-Version: 1.0
X-Received: by 10.50.18.43 with SMTP id t11mr29228364igd.25.1440018382738;
 Wed, 19 Aug 2015 14:06:22 -0700 (PDT)
Received: by 10.64.236.98 with HTTP; Wed, 19 Aug 2015 14:06:22 -0700 (PDT)
In-Reply-To: <1439890337-13803-2-git-send-email-govindraj.raja@imgtec.com>
References: <1439890337-13803-1-git-send-email-govindraj.raja@imgtec.com>
        <1439890337-13803-2-git-send-email-govindraj.raja@imgtec.com>
Date:   Wed, 19 Aug 2015 14:06:22 -0700
X-Google-Sender-Auth: rOief0ae82OZhZg0omwZ7pWP9UY
Message-ID: <CAL1qeaFDaw3ywkdwGZi1=W+=Kmi=AAEMBx0tEJJ84q1Re3tiFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: pistachio: Fix 32bit integer overflows
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Govindraj Raja <govindraj.raja@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48948
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

On Tue, Aug 18, 2015 at 2:32 AM, Govindraj Raja
<govindraj.raja@imgtec.com> wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
>
> This commit fixes 32bit integer overflows throughout the pll driver
> (i.e. wherever the result of integer multiplication may exceed the
> range of u32).
>
> One of the functions affected by this problem is .recalc_rate. It
> returns incorrect rate for some pll settings (not for all though)
> which in turn results in the incorrect rate setup of pll's child
> clocks.
>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
