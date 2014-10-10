Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 19:01:31 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:44389 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011109AbaJJRB34sBkw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 19:01:29 +0200
Received: by mail-vc0-f171.google.com with SMTP id hy10so2966179vcb.2
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 10:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gEc4kFIpdFPWLyu/G9a5Wv89kFh0CNpLcpvIxR2CnCM=;
        b=MfgoSczmemr1DLpDSbSAWP69rChpGoKORCisb67L6gYo9HHx6VdjOzSJTuKADlGoox
         Q9rEEsONB28omP5XxOxVPwsVNc7kSqSLdpHD88kg4Xemdw+X4Vv/KkOBi+g0k4x0s1Mb
         lQGXQVEB9o+6ocAo9VcirPp7/IzE8MroT1PW+Vcmx047tuMq2YFWbhrO2wulhyhHUEY3
         6lDF4vbk5Xwz5vcOrgLyvgSauYbekByzp10RTd2TBm3CACGXouVVrpaNy9BtlNog9eZ+
         xvmlMC06RqkwCdsg20YQjxY3Bj11PSMR3X/F1kuTwO+YSrH045xPhcMNdraiYKRHvu5p
         Atig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gEc4kFIpdFPWLyu/G9a5Wv89kFh0CNpLcpvIxR2CnCM=;
        b=nL563aSNxNWSVnpMb6tgkZdKts9smaQcO0Rwsi+YoNh86JxEnB4TmrL8JDGi7BcxbE
         tBgin6zrvj3UA6DMfEem+/xkCX/I4tDyR1QC87NEfjm6bDtAC2neu+XHDbLmyMMT6OHy
         qxBiDidbN2P0Ppn7hZrBRfRDEL128TJnRODr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gEc4kFIpdFPWLyu/G9a5Wv89kFh0CNpLcpvIxR2CnCM=;
        b=Z1JBjMzlYf1gXNdgOMKjtCZRe3NHz3aUhoaqhd+Oa6sg8SmHOA5Sh/y9nqU1awDnC2
         YmH5err39K5ohTrLGArvCOuZVhMOyt+62Vdjp+FrlCiAlZV+L7+JeZXt2Xuj0XvADrxR
         9hcPffZrbkcqjO2Xyi4HGCQmzMZgjvvyIJxAk7/AyCGsJO6CPAFQr0MYqwQvcY/nnQTb
         vQa4BZ4woNBvu124pbwsSWTeOGImbVTYcYkY5o8aZfZsJwAfag6kapPteN5PErBr+knl
         MxmdhQwrsKLecIWEBZqg4WDbFKuymYMlLXk8YBTY7wf6SSaGrg5SKHSc85B1VqNhvr5+
         X2rQ==
X-Gm-Message-State: ALoCoQmy0jUP/IcOQwn167q/ES2qTm6u0os6yKNMt+D5CNQdnMDuz7dOAdpni71Zs/yQKxFGBSF8
MIME-Version: 1.0
X-Received: by 10.220.112.75 with SMTP id v11mr3085899vcp.53.1412960482485;
 Fri, 10 Oct 2014 10:01:22 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Fri, 10 Oct 2014 10:01:22 -0700 (PDT)
In-Reply-To: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
References: <1412933645-55061-1-git-send-email-blogic@openwrt.org>
Date:   Fri, 10 Oct 2014 10:01:22 -0700
X-Google-Sender-Auth: BAG7nb7auU3zue10r0DqCU-HEvo
Message-ID: <CAL1qeaHPSdLwec5-V8PHLuyicgNUF74vO0gY7Y7U2k-etQ7eBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ralink: add gic support
From:   Andrew Bresticker <abrestic@chromium.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43213
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
> The mt7621 has a GIC. rather than handle both irq coree in one file we add a
> secondary irq-gic.c.

Why not use the current GIC driver that I've been fixing up?  I
believe Ralf will be applying the first set of clean-ups soon and I'm
planning on doing additional clean-up and adding device-tree support.
I have a work-in-progress branch here if you're interested:
https://github.com/abrestic/linux/tree/mips-gic-dt-wip

> diff --git a/arch/mips/ralink/irq-gic.c b/arch/mips/ralink/irq-gic.c
> new file mode 100644
> index 0000000..0ae7ea0
> --- /dev/null
> +++ b/arch/mips/ralink/irq-gic.c

> +static int __init
> +of_gic_init(struct device_node *node,
> +                               struct device_node *parent)

> +       if (of_address_to_resource(node, 2, &gcmp))
> +               panic("Failed to get gic memory range");
> +       if (request_mem_region(gcmp.start, resource_size(&gcmp),
> +                               gcmp.name) < 0)
> +               panic("Failed to request gcmp memory");

Ah, so this SoC has a CM2 as well.  Is it at the address reported by
C0_CMGCRBase?  If so, then mips_cm_probe() will be able to find it and
set it up.  Otherwise, device-tree based probing should probably be
added to the mips-cm driver.
