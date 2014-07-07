Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2014 09:32:22 +0200 (CEST)
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36867 "EHLO
        mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861121AbaGGHcSlcULW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Jul 2014 09:32:18 +0200
Received: by mail-oa0-f50.google.com with SMTP id n16so4149219oag.23
        for <linux-mips@linux-mips.org>; Mon, 07 Jul 2014 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pfWz2iVCLcSMFnV0RmSuH6lPoD1pgSB0QZpPjk5sy3A=;
        b=uBmP+VY6bfeLWigRQXCImoRizyHVd41UnSNHLP1EoF+bTeiXTySwQS+3DnrS9cbrOe
         UDP0otP8XNqhupYWnaxwuyjx81Su0cskMmcAY7ORGhBFB9hFhye8zb5gCiLzQumNoOZB
         3kpn+EP/Ckbgv/cMjyRcioAPF7qgZyLy5UpT6rMo9sUT7ZS+TqNRMNJYSuj/P+cCIsve
         O5SD5lU2P/joVVLNvpnbFD1neTG0r9ghB2j40NLX31sO9wHZX/SM0ziyzNd2aZuek3A3
         N+9vLpssBG7pzLXN2WTEmTySCLyhCRxLG0QqNDOiFxP92L1gplW7NtPr6divaEERMd0H
         ak0A==
MIME-Version: 1.0
X-Received: by 10.182.236.193 with SMTP id uw1mr29403512obc.12.1404718332322;
 Mon, 07 Jul 2014 00:32:12 -0700 (PDT)
Received: by 10.76.102.77 with HTTP; Mon, 7 Jul 2014 00:32:12 -0700 (PDT)
In-Reply-To: <52823C54.9050208@imgtec.com>
References: <52823C54.9050208@imgtec.com>
Date:   Mon, 7 Jul 2014 11:32:12 +0400
Message-ID: <CAMo8Bf+jU3oGn4=6HF=MXMqvVEDDSdtD_pa0u3=4fOXeF5pNUA@mail.gmail.com>
Subject: Re: Release of Linux MTI-3.10-LTS kernel.
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jcmvbkbc@gmail.com
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

Hi,

On Tue, Nov 12, 2013 at 6:33 PM, Steven J. Hill <Steven.Hill@imgtec.com> wrote:
> Imagination Technologies is pleased to announce the release of its 3.10 LTS
> (Long-Term Support) MIPS kernel. The changelog below is based off the stable
> Linux 3.10.14 release done by Greg Kroah-Hartman in commit
> 8c15abc94c737f9120d3d4a550abbcbb9be121f6 back on October 1st. The code
> repository is hosted at the Linux/MIPS project GIT:
>
> http://git.linux-mips.org/?p=linux-mti.git;a=summary
>
> We look forward to any comments or feedback.
>
>         The Imagination MIPS Kernel Team
[...]
> Fixes:
> * MIPS HIGHMEM fixes for cache aliasing and non-DMA I/O.

I'm adding HIGHMEM support to xtensa cores with aliasing cache, and found
that the above patch makes generic kmap cache-color aware. Is there a plan
on upstreaming that patch? I can help with upstreaming of the generic part of
it if there's no such plan.

-- 
Thanks.
-- Max
