Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 11:11:18 +0100 (CET)
Received: from mail-tul01m020-f177.google.com ([209.85.214.177]:44398 "EHLO
        mail-tul01m020-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903617Ab2BWKLN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 11:11:13 +0100
Received: by obcuz6 with SMTP id uz6so1409180obc.36
        for <linux-mips@linux-mips.org>; Thu, 23 Feb 2012 02:11:07 -0800 (PST)
Received-SPF: pass (google.com: domain of dengcheng.zhu@gmail.com designates 10.182.86.201 as permitted sender) client-ip=10.182.86.201;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of dengcheng.zhu@gmail.com designates 10.182.86.201 as permitted sender) smtp.mail=dengcheng.zhu@gmail.com; dkim=pass header.i=dengcheng.zhu@gmail.com
Received: from mr.google.com ([10.182.86.201])
        by 10.182.86.201 with SMTP id r9mr270473obz.8.1329991867618 (num_hops = 1);
        Thu, 23 Feb 2012 02:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0w8ZJVO532uu07Ef9DAjs4g0gUsg6uxJBsH6nLoTW50=;
        b=AhS9pDST0CAuHUJOxsYCf+5/bayqFPrBe6PyQ4yVZ9CLzXeYVG65/LyeF6pnVP3WRl
         w9hduAOnn8mYUSLSbgXNEzW6fSYmi4Y8yYrQK7dTeHG1dK4houYWx7O+bhs8htv0b0xr
         kd9lNhmwUBeGE+kzh6+Vz/GvMERgRaVn8Ovk0=
MIME-Version: 1.0
Received: by 10.182.86.201 with SMTP id r9mr230712obz.8.1329991867525; Thu, 23
 Feb 2012 02:11:07 -0800 (PST)
Received: by 10.60.23.72 with HTTP; Thu, 23 Feb 2012 02:11:07 -0800 (PST)
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D055C76C25948@xmail3.se.axis.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C76C25948@xmail3.se.axis.com>
Date:   Thu, 23 Feb 2012 18:11:07 +0800
Message-ID: <CAOfQC98QuBp+-9UKXt4kqnrtzmNyHqDWG+6RBzspvhgJwsps4A@mail.gmail.com>
Subject: Re: SMP MIPS and Linux 3.2
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Mikael Starvik <mikael.starvik@axis.com>, raghu@mips.com
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 32499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I should have contacted the author (Raghu Gandham) of a fix for this
issue to get it into the mainline. But it slipped out of my mind...

The patch link is here:
http://git.linux-mips.org/?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020

Hi, Raghu

Do you know why it didn't happen?


Deng-Cheng

On Wed, Feb 22, 2012 at 6:57 PM, Mikael Starvik <mikael.starvik@axis.com> wrote:
>
> Found it! There are no calls to scheduler_ipi() from the MIPS parts in vanilla 3.2.
>
> /Mikael
>
> -----Original Message-----
> From: Mikael Starvik
> Sent: den 20 februari 2012 10:34
> To: 'linux-mips@linux-mips.org'
> Subject: SMP MIPS and Linux 3.2
>
> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP configuration). It works fine in UP but with SMP it deadlocks during bootup (both CPUs gets idle). Typically like this:
>
> [    0.090000] CPU revision is: 01019550 (MIPS 34Kc) [    0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
> [    0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes [    0.170000] Brought up 2 CPUs <No more output>
>
> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't improve anything. Anyone else got this running or have any thoughts about what the problem may be?
>
> Best Regards
> /Mikael
>
