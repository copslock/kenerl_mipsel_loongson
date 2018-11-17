Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Nov 2018 04:54:04 +0100 (CET)
Received: from mail-wr1-x444.google.com ([IPv6:2a00:1450:4864:20::444]:34473
        "EHLO mail-wr1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990422AbeKQDwH7DaQm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Nov 2018 04:52:07 +0100
Received: by mail-wr1-x444.google.com with SMTP id j26-v6so26764171wre.1;
        Fri, 16 Nov 2018 19:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1V3A8w/Fwi81Vu+7hJ4pVQug84DlliIEPUp7wQQJ788=;
        b=fKeVIeNzgApVf+LUrDkEr2sM1HIC6sLHJiloKrivEx9vjv4PBMdA1UxGZ7jbGlgitl
         AF3t5rITkB+krGN3iRWpCcFxjk6bgcPSh4ofUuhCtHzhs5OJkT1Xte023aYKJXqZCXFZ
         l5e1uUtB7zpL7w23iQexP5nnrGCLTzPFODG9bSnUbY/cUJ2r20M4X2Vrd7FaYnSQD1CY
         s6LiQVX+MhImT3EaYCayDMZdd81LGGc9RccUmTx+tP0EEk+EzIgDbQcV9twQ+Bu5uyWE
         egxnn7KBhrG2dcKtomddJEsJK7A8niY/K2W+dNhNKtBa/vtcKVbDEc9LfR/aoPy85MHg
         t++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1V3A8w/Fwi81Vu+7hJ4pVQug84DlliIEPUp7wQQJ788=;
        b=Gkd/6KRKlv+tUlAu2P4YVMN5NHOJRSJaOrhjanzH0oMvg++Nnqpg0Zrxtxl6HW4GHY
         iMB4WMXMXy/xC6JtFmhiIdidNKACQsFPE0vpyKQhaiyrbSxNaEB6H5c+k+ahrM/+RG04
         Vn/TZTVvnhXA/DiWhVKvpF+JK6MXD9ss29gAoFwxIh5IVe1VbDo+MoBi8vrE7h5+/tMI
         S8u2tRJFNNh8oMAikQobfnkrtBuyaEW4kzqorTVx/41vH9ME98iHgEYnIM438VDY+ogr
         dAHlvUaXfNdEMzuCOaLs/0EG9fLJOhmQPIhJnu2SXD9FQgDfwU6j3CUoEITlrBc5MdIl
         nG1g==
X-Gm-Message-State: AGRZ1gJFypnyaMLzsw+9LQtsYfJ3qjOKVKu/BnbRa7SgdQ/o0rF1eDnF
        q23W1P6Vkl1nKE1SdEFDCbE5KyN0mjQRFTs5AZQ=
X-Google-Smtp-Source: AJdET5eWrUYnjKdnCuoyOuQ0nkQqX95j/lVXyc5NG+X7l0WZi4ZpflyBMWsMgSogpqti50438FIp4njd1lyWcdhZT7U=
X-Received: by 2002:a5d:40cc:: with SMTP id b12-v6mr12090508wrq.133.1542426727398;
 Fri, 16 Nov 2018 19:52:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl> <20181110.134758.693752342395888727.davem@davemloft.net>
In-Reply-To: <20181110.134758.693752342395888727.davem@davemloft.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 16 Nov 2018 19:51:55 -0800
Message-ID: <CAADnVQKzo_85bUPXnaqds0MxzrOu_BJwnZx25CbsNrjV=DHC3w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Borkmann <daniel@iogearbox.net>, jhogan@kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, paul.burton@mips.com,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Sat, Nov 10, 2018 at 1:48 PM David Miller <davem@davemloft.net> wrote:
>
> From: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Date: Sat, 10 Nov 2018 19:58:29 +0100
>
> > Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
> > storage and finally move the flag to separate storage in skbuff.
> >
> > This is final step to make CLAN.CFI transparent to core Linux
> > networking stack.
> >
> > An #ifdef is introduced temporarily to mark fragments masking
> > VLAN_TAG_PRESENT. This is removed altogether in the final patch.
>
> Daniel and Alexei, please review.

It was on my todo list.
All reviews got delayed due to LPC.

I guess too late to comment now.
Anyhow I don't see the value in this patch set.
Seems like code churn.

Michal, could you please explain the reasoning?
