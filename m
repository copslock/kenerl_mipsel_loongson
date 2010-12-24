Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2010 10:36:19 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:46376 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491041Ab0LXJgP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 24 Dec 2010 10:36:15 +0100
Received: by qwj9 with SMTP id 9so7081202qwj.36
        for <multiple recipients>; Fri, 24 Dec 2010 01:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RcMBnZ1wOW4V7bVnq1yR7cvS7OBRjXz0VKwe0ON63AU=;
        b=LbEea74JevWN9GZnucdD5cw045e3YnTY20VXYyf4kzo7Lw9xo+yQ8dbtelC17b3uYU
         4N31VD3vy00k+fj2AY0nK4PqHQWKSytCLhV1ZBCPFCM5HYhiBUWoJITWAAICKBabd7Yj
         wgvnPFJBabS11/LCyEJIoz9+cA+6MhMXP6sV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kROBJMAqsa1F4gdmiqJIAQnuVRL08nze/Vjh2J12kAenapwPuT7scLiM24gDXGDat3
         Rho/0EtXXqCs3gkvs2OUhJRmP8pl0h7rd8GHn5JTTBW35Gn2NRQd0HjxqGEvXjkK4xIN
         fV/SVE4MVBsQH4/Jhd00i1smuqNmE1Ya2sV7A=
MIME-Version: 1.0
Received: by 10.229.88.207 with SMTP id b15mr8206585qcm.34.1293183369359; Fri,
 24 Dec 2010 01:36:09 -0800 (PST)
Received: by 10.229.107.10 with HTTP; Fri, 24 Dec 2010 01:36:09 -0800 (PST)
In-Reply-To: <1290076370.31469.1.camel@paanoop1-desktop>
References: <1290076370.31469.1.camel@paanoop1-desktop>
Date:   Fri, 24 Dec 2010 03:36:09 -0600
Message-ID: <AANLkTim-GzNhC=RwR-caqYtCtpZ6Z--G4focxikT9Ext@mail.gmail.com>
Subject: Re: [PATCH] Fix MSP71xx bpci interrupt handler return value
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Anoop P A <anoop.pa@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ben Hutchings <ben@decadent.org.uk>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Anoop:

On Thu, Nov 18, 2010 at 4:32 AM, Anoop P A <anoop.pa@gmail.com> wrote:
>
> Signed-off-by: Anoop P A <anoop.pa@gmail.com>
> ---
>  arch/mips/pci/ops-pmcmsp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I have successfully booted a 2.6.37-rc6 kernel with this patch applied
on an MSP7120 Garibaldi evaluation board.

Tested-by: Shane McDonald <mcdonald.shane@gmail.com>
