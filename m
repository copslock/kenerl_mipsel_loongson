Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 19:05:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:49062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994619AbeIERE7sMi4u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Sep 2018 19:04:59 +0200
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB9852087B
        for <linux-mips@linux-mips.org>; Wed,  5 Sep 2018 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536167090;
        bh=PXAN4s2C0+ss57I+gCNZA69qCfLKCD/7jnNdkdnvKEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qqwgFis8dA7ueLJ/Vf7ypzJ0zEbd3Siy/cra99ztzzG/x2AJJKa9EHKz2bGDYGz6N
         EE5Z92GiYhc1llwPVbQfzUmQnTu43tRn6fGJb65478mNScNM6epitkDwoC3vM9qYuW
         D8JV93OG3dnRXzaTJabFLTL8WprZHzfYha2Y9WrU=
Received: by mail-wm0-f45.google.com with SMTP id r1-v6so12274906wmh.0
        for <linux-mips@linux-mips.org>; Wed, 05 Sep 2018 10:04:49 -0700 (PDT)
X-Gm-Message-State: APzg51ATCocZZo4pIDi3OWNr3dJ+LLrK+NdcfbFY1+awn/b8jcq8V9pj
        hf0q9s1AcyA9yp/85gigYkQvWRIPWDvPG7KDAX7pPA==
X-Google-Smtp-Source: ANB0Vdazu2bIRLAGvaRFJO3kddzH0TDzQrgTKKF09VbOObPbmJhOVbibCG0hWQ5aKsR9DNFuS8y4XAYhrHAFTsc1XJU=
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr889128wmg.123.1536167088138;
 Wed, 05 Sep 2018 10:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <1536163184-26356-1-git-send-email-rppt@linux.vnet.ibm.com> <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1536163184-26356-8-git-send-email-rppt@linux.vnet.ibm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Sep 2018 12:04:36 -0500
X-Gmail-Original-Message-ID: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Message-ID: <CABGGiswdb1x-=vqrgxZ9i2dnLdsgtXq4+5H9Y1JRd90YVMW69A@mail.gmail.com>
Subject: Re: [RFC PATCH 07/29] memblock: remove _virt from APIs returning
 virtual address
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        davem@davemloft.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mingo@redhat.com, Michael Ellerman <mpe@ellerman.id.au>,
        mhocko@suse.com, paul.burton@mips.com,
        Thomas Gleixner <tglx@linutronix.de>, tony.luck@intel.com,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Sep 5, 2018 at 11:00 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> The conversion is done using
>
> sed -i 's@memblock_virt_alloc@memblock_alloc@g' \
>         $(git grep -l memblock_virt_alloc)

What's the reason to do this? It seems like a lot of churn even if a
mechanical change.

Rob
