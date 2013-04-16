Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 23:37:42 +0200 (CEST)
Received: from mail-ob0-f181.google.com ([209.85.214.181]:65150 "EHLO
        mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822830Ab3DPVhlYluQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 23:37:41 +0200
Received: by mail-ob0-f181.google.com with SMTP id wo10so859863obc.40
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3h1zTh1FfVlHN/VAT8DcHnIVixkCdxWG3ayQPqv7/UU=;
        b=hPP+m+UXadBtz8cHKeHCuTeOSadcLeHm1aogonSnww6EM9ZvTcjyI1/1i0l4XkyNgK
         iODCwfhXwHXhfGquOFzfVydXNerReOsqdWW+ar9fNjnsXRJSstLXYVD/NOAKW9e4CXzN
         aom1PrJK5th/L3Bl3CDDHDVYrX/tRxE59O8t0e934qPlfp3kacV+SI05aQqyzr7oMTKc
         HM6G6F8D/DLxh0oym/CZPFUeO/GKHK9oglXu4Ea2ET+2MzDG8yTCKg5bEHnZVgNjMbFR
         IsB+BID+rC6SB1lKySx8AeZciJKkXcH3UP2NHoU4153/61480qvKiAXbYJqSehTqXP4m
         gQiA==
X-Received: by 10.60.131.72 with SMTP id ok8mr1507412oeb.120.1366148254984;
 Tue, 16 Apr 2013 14:37:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.143.231 with HTTP; Tue, 16 Apr 2013 14:37:14 -0700 (PDT)
In-Reply-To: <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk> <20130416182601.27773.46395.stgit@warthog.procyon.org.uk>
From:   KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Date:   Tue, 16 Apr 2013 14:37:14 -0700
Message-ID: <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com>
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into
 linux/kcore.h [RFC]
To:     David Howells <dhowells@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, x86@kernel.org,
        sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <kosaki.motohiro@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kosaki.motohiro@gmail.com
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

On Tue, Apr 16, 2013 at 11:26 AM, David Howells <dhowells@redhat.com> wrote:
> Split kcore bits from linux/procfs.h into linux/kcore.h.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-mips@linux-mips.org
> cc: sparclinux@vger.kernel.org
> cc: x86@kernel.org
> cc: linux-mm@kvack.org

I have no seen any issue in this change. but why? Is there any
motivation rather than cleanup?
