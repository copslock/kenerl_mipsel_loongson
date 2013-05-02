Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 May 2013 10:25:38 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43749 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824799Ab3EBIZc0kOnZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 2 May 2013 10:25:32 +0200
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com [209.85.220.179])
        by mail.nanl.de (Postfix) with ESMTPSA id 9E52645F61;
        Thu,  2 May 2013 08:25:16 +0000 (UTC)
Received: by mail-vc0-f179.google.com with SMTP id hz10so254198vcb.38
        for <multiple recipients>; Thu, 02 May 2013 01:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Wr2/2XHKgvzCNS+KcAuJXCZ1WGxISiWFl1A+FzwcPSw=;
        b=QI8uU0zaJJt5JWSVV6Np4xplJnTE+C65+TjCTpiDMRSAelh6kIDXvl2aLBTSNOmDlD
         +Z9rz22XwW/j8Qiio7bipejqmyi5TueBC6r+E0rCFPwcyekzNPLkkvOSQtW0fJTkp8bS
         lqNke5H1fOCQlq3bIOlrk8+iy5GfUjKUATGDIrRSYm9PmTuN9UtDQZ2UBbsj8ILeJi5R
         8/FP44HPc/OlvoqWD94A6cVB5wn25OSyG7wz6xcspU7LGm6JoqKhDfxG5UZ2t2fY6gB+
         IgUcKJ4MadLCoLi1YBH68nJ+FTGreqeq90OSm+Ex8RuCyLh/vSBg44tHcQjE/m4vifdO
         Xdaw==
X-Received: by 10.220.76.129 with SMTP id c1mr1808646vck.48.1367483125924;
 Thu, 02 May 2013 01:25:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Thu, 2 May 2013 01:25:05 -0700 (PDT)
In-Reply-To: <26714880.190151367480353110.JavaMail.weblogic@epv6ml12>
References: <26714880.190151367480353110.JavaMail.weblogic@epv6ml12>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Thu, 2 May 2013 10:25:05 +0200
Message-ID: <CAOiHx=kmrQuNd1dbdce4N1wbuLKhCqpSnruC0bMDxsEhY84izA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: remove USB_EHCI_BIG_ENDIAN_{DESC,MMIO} depends on
 architecture symbol
To:     eunb.song@samsung.com
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        florian@openwrt.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Thu, May 2, 2013 at 9:39 AM, EUNBONG SONG <eunb.song@samsung.com> wrote:
>
> This patch removes the architecture specific symbols which prevent these
> configuration symbols from being selected by platforms/architectures requiring it.
> I reference commit 9296d94d83649e1c2f25c87dc4ead9c2ab073305.

These are selects and don't prevent anyone else from also selecting
them. If you look at your referenced commit, you see it removed the
/depends/, not the selects. It actually added selects to several
platforms. Platforms are supposed to select them if they need them.


Jonas
