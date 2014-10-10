Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 19:30:06 +0200 (CEST)
Received: from mail-vc0-f174.google.com ([209.85.220.174]:58232 "EHLO
        mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011109AbaJJRaF1RaLx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 19:30:05 +0200
Received: by mail-vc0-f174.google.com with SMTP id hq12so3089262vcb.33
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pmkZdVYOATVaN3cvcjEy4hjIYMbdgDOeN1AHBQSOTE8=;
        b=SIsV9GQr+EJ5A8oAnGKZsCEEPvDXyER9lQ/urpdUepScfIEyD/+kBFhqemvwSh64Ea
         7+w+fJKxpDsDYKV/VXpgSKfoirwo6qNvi0Dqzqhd3tfl19R2QG4otAehRaAMuFs1J89l
         uWTuiCJGnCWbwEs7M9MMPMhiVZHhyrEHIl8U7NvI3pgW5bZPazqGUVuBFkgWAmouxqdP
         x1K/ELLbKZ3U7XgfVODFBiEYpqxoz+qr0t1MDYl2y4gAaZr9+eqwmBhWhRc0TgrHoILf
         PHfGVwaD8eBFRJeYd0FyayubL5KdtS6OCiCub0KCSjmN+UgeAE3ZwPgOMKpMYwAR+wYC
         2fbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pmkZdVYOATVaN3cvcjEy4hjIYMbdgDOeN1AHBQSOTE8=;
        b=WIDzORMROjbXUDWV7tDwsjzWTFhw0mXCTXlWRz2ELqESrG7HthPWllbcbOXTHja6Jg
         8ZhePTRwBrN6DioIYhBRQB8/8WQiavTIG/BSmBY3b7Gkes8KXFjcI5oAVHCljoydNIiV
         s6SUs8OAD4ZrdL2MF6oBgFdNYQWbxue2W03CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pmkZdVYOATVaN3cvcjEy4hjIYMbdgDOeN1AHBQSOTE8=;
        b=c6EP9wlITWgfEGNSjEMdg6yP4JrrAP0e5XSedDeiwDlE2itvWKVz3KYPtRf1HnQepH
         viUlyZDa7vOxsvvySW88LDanSilAilzxx28SNcJyK7QegNMeR9wvAu0GivOeemVkcJeA
         o6aQD3H0AjRDxfX4x7lYfmv8NGZf1fWdWy2xaHM7hPn7zJ2kWm9aWNJNysUSp3EPe7SZ
         k5ZlPfkDwjiAbGJnRHxJMCOM1YZ/q8EZk+SLMfvJlK3vvImDghAXNAN3NSQED+ByN4QE
         +X1C5KLctrAQhA1wZhM7zkzDmauTemnhm9lfsP+419GkAFLJl1G1zkOl5JeCU/YXIa2/
         qAMA==
X-Gm-Message-State: ALoCoQmGcahhYqU97EKvnaHF7c91MIa4wUJTRghmhQqShJIJ1FU3Ys5BVr0SjzIjI17fqtbjDC+d
MIME-Version: 1.0
X-Received: by 10.220.161.136 with SMTP id r8mr6704212vcx.21.1412962199614;
 Fri, 10 Oct 2014 10:29:59 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Fri, 10 Oct 2014 10:29:59 -0700 (PDT)
In-Reply-To: <1412933645-55061-2-git-send-email-blogic@openwrt.org>
References: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
        <1412933645-55061-2-git-send-email-blogic@openwrt.org>
Date:   Fri, 10 Oct 2014 10:29:59 -0700
X-Google-Sender-Auth: EBGHMBc68aLEudyDJsQIAPDibB8
Message-ID: <CAL1qeaH_8dkqm8i8SPfhhvfFK_OvbbXMdLUHkdFpRowcgwYUFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: ralink: add MT7621 support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43215
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

On Fri, Oct 10, 2014 at 2:34 AM, John Crispin <blogic@openwrt.org> wrote:
> This is the big APSoC made by mediatek. It is based on 1004k and has 2 cores
> running at 800mhz. Each core has 2 VPEs. Unlike all the other SoCs from this
> family, MT7621 has no wireless mac. It relies on pcie cards being present for
> wifi.

Doesn't the 1004k have CPS?  I think you can use smp-cps instead of
smp-cmp in that case.
