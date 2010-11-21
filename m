Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Nov 2010 10:59:10 +0100 (CET)
Received: from lechat.rtp-net.org ([88.191.19.38]:53508 "EHLO
        lechat.rtp-net.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491040Ab0KUJ7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 21 Nov 2010 10:59:07 +0100
Received: by lechat.rtp-net.org (Postfix, from userid 5001)
        id 725DF1009C; Sun, 21 Nov 2010 11:01:26 +0100 (CET)
Received: from lechat.rtp-net.org (ip6-localhost [IPv6:::1])
        by lechat.rtp-net.org (Postfix) with ESMTP id 2D8DB10096;
        Sun, 21 Nov 2010 11:01:21 +0100 (CET)
From:   Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
To:     shmprtd@googlemail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Add support for Realtek Media Player SoCs
Organization: RtpNet
References: <tkrat.a6310f0563cae06d@googlemail.com>
Date:   Sun, 21 Nov 2010 11:01:21 +0100
In-Reply-To: <tkrat.a6310f0563cae06d@googlemail.com> (shmprtd@googlemail.com's
        message of "Sun, 21 Nov 2010 01:15:11 +0100 (CET)")
Message-ID: <87r5efyozy.fsf@lechat.rtp-net.org>
User-Agent: Gnus/5.110009 (No Gnus v0.9) Emacs/22.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@rtp-net.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28437
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.patard@rtp-net.org
Precedence: bulk
X-list: linux-mips

shmprtd@googlemail.com writes:

> Hi,

Hi,

Please read Documentation/SubmittingPatches. One big patch is just
impossible to review (at least for me), please split it in fewer
chunks.


>
> I added support for at least one of the Realtek "Galaxy" SoCs to recent
> 2.6.36 kernel. Most of the patch is based on existing linux-mips code and
> a 2.6.12 kernel source released by some of Realtek customers.
>
> Currently, this allows to start the kernel and setup serial console.
> Further development/porting will have to be done for additional platform
> devices.

Do you have an exact status of the different platform device support ?
How do you deal with the audio/video support (for instance firmware
loading & their rpc stuff) ?

>
> This code is tested on a Realtek Mars SoC. Commercial product name
> is rtd1073dd but cpu/soc id is 0x1283. Other SoCs (Venus,Jupiter,Neptune)
> have not been tested, yet.

Do you know the differences between the different versions and/or have
public specs of the SoCs ?
Also, I'm seeing a lot of rtd128x in the file names... Commercial name
for the Venus is rtd1261 for instance. I find this really
confusing. I would be tempted to use mach-realtek but I don't know
enough the realtek mips SoCs to say if it's a good idea.


Arnaud
