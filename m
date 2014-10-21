Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:05:19 +0200 (CEST)
Received: from mail-vc0-f170.google.com ([209.85.220.170]:57814 "EHLO
        mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011966AbaJUWFR6K-k0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:05:17 +0200
Received: by mail-vc0-f170.google.com with SMTP id hy10so1134857vcb.15
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pefoley.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j79SmYnaY+v+repBLfIirE3d12H/QkcKWH4RpDIzJ1c=;
        b=myXT3NRdys1j32K+r3yp2HDfEwC54cGtXHC6m4QGLbXyo3XHITkNN2L0VuKgtHTEQ8
         JQRbBy4DnI3GanoQIJ1aDUW+YEPTf4+ZSYrQPRoZL1A8fwmEKlTcntfucZZil3r2SaYG
         oZSL8S29UB+jEQLSnkK2k6fM0PIfozVEEanEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=j79SmYnaY+v+repBLfIirE3d12H/QkcKWH4RpDIzJ1c=;
        b=a1g6wbuR5lq0yvhlyL54RMyDWi90CQHiY5dc905Sm10X/vXFyTicUdnYc+M8vlP7Bd
         HOnPxAsfTXh3tEV8TXu7shyNblRy1CW8Z1Qzdq664fluv4LqdfAgHbuASLHe2CHxUoKB
         LxP2lkORLdTBHXXm2I5EC72H1p9GyYKa2s24F1O08WDtol6hMPoeZKhw/5cOrfh8OzF6
         SEQKfxmaDQNrDYgp1eTXtNSn5DX4x4crmQTgbCd5TVvs7tzJRvnMf4iB2yLwrk1urx7C
         1i1WCyCjm6P/jMiTmGmzEKzNtSl00Har64glnF3F6PHz6kxQjsoo5VCt7wIkIvIPac+o
         63yQ==
X-Gm-Message-State: ALoCoQnke2FaOYpWOaY/++QLPDkofCrH1G4/8idM5N1iDtQAQ+otagsT4zJpacL4zKsrWXJihYV5
X-Received: by 10.221.56.201 with SMTP id wd9mr32781878vcb.16.1413929111814;
 Tue, 21 Oct 2014 15:05:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.221.44.8 with HTTP; Tue, 21 Oct 2014 15:04:51 -0700 (PDT)
X-Originating-IP: [2001:470:8:ee7:39bc:72a7:a0a6:e1f0]
In-Reply-To: <20141021182757.GA3960@localhost.localdomain>
References: <1413794538-28465-1-git-send-email-markos.chandras@imgtec.com>
 <20141021110724.GA16479@netboy> <20141021.123544.9516812519754063.davem@davemloft.net>
 <544690CB.4030307@gmail.com> <20141021182757.GA3960@localhost.localdomain>
From:   Peter Foley <pefoley2@pefoley.com>
Date:   Tue, 21 Oct 2014 18:04:51 -0400
Message-ID: <CAOFdcFNYHgupvMChb4NedMsUMAOmE8k0D_F5eRjL-8H8ft=eRw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ptp: Fix build failure on MIPS cross builds
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        David Miller <davem@davemloft.net>, markos.chandras@imgtec.com,
        linux-mips@linux-mips.org, corbet@lwn.net, netdev@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <pefoley2@pefoley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pefoley2@pefoley.com
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

On Tue, Oct 21, 2014 at 2:27 PM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Oct 21, 2014 at 09:58:51AM -0700, David Daney wrote:
>> What I don't understand is why we are using hostprogs in this
>> Makefile.  Isn't this a program that would run on the target, not
>> the build host?
>
> Yes.
>
> Peter, could you please fix it?


The intention of these changes was to generate more compiliation
coverage for code in Documentation/
The underlying issue is that this doesn't work for cross-compiling
because kbuild doesn't have cross-compile support for userspace code.
I submitted a patch to disable building Documentation when
cross-compiling, as the consensus in the thread that resulted in that
patch (https://lkml.org/lkml/2014/10/8/510) was that implementing
targetprogs in kbuild was not currently worth it.
I can try to take a crack at adding targetprogs support, but I'm
rather busy right now, so it may take a little while.

Thanks,

Peter
