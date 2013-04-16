Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Apr 2013 00:14:16 +0200 (CEST)
Received: from mail-oa0-f49.google.com ([209.85.219.49]:55049 "EHLO
        mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822998Ab3DPWOPjzqLk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 00:14:15 +0200
Received: by mail-oa0-f49.google.com with SMTP id j6so993971oag.8
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=I0r1gkpNBlJw0b8JH8LwMoFuqRnk0MpmJF7o0Q0zeb4=;
        b=M4CqekCIKpPUTjjBe4z1jyL8UiPx/OccOSKHHycf85vJ7UiJjeyTqH/h/SmQZhQM8B
         LQbZChngEz1zu2L7rbfmkrxG7pSvwIo9S5h7zkO/kSmb3h9tdaWgSbs80TUgJ+pZ/Q/A
         xmAeNi9F1ETodbojryvKCO5YcKzeUSZQuj62Um7iiuNDKqEmFmCiF4mxVKRSFm3x0wpa
         EK2J+jbbqd1dwag/8XHdst+M0MWRvC8Q3732Azj2JI9NVfwL2K4B49B8L50q5n25Unh9
         cJr4wqUYfW57Enlciaet/N1Nb+szWQ4Fw2Rt4ejkVbbvv7+FX3UtANvUXX9OLCL8bUQT
         iIXA==
X-Received: by 10.182.134.230 with SMTP id pn6mr1551020obb.19.1366150449605;
 Tue, 16 Apr 2013 15:14:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.143.231 with HTTP; Tue, 16 Apr 2013 15:13:49 -0700 (PDT)
In-Reply-To: <30949.1366150057@warthog.procyon.org.uk>
References: <20130416182550.27773.89310.stgit@warthog.procyon.org.uk>
 <20130416182601.27773.46395.stgit@warthog.procyon.org.uk> <CAHGf_=r+qoL8_J+z8Y1uPt_NK1Ef4cLuapAvVd-7qF8+_oSjJw@mail.gmail.com>
 <30949.1366150057@warthog.procyon.org.uk>
From:   KOSAKI Motohiro <kosaki.motohiro@gmail.com>
Date:   Tue, 16 Apr 2013 15:13:49 -0700
Message-ID: <CAHGf_=p7iKG0hqzanTb6u3-RUFsOZ3wJVYfLYhqH9nF6RkxGow@mail.gmail.com>
Subject: Re: [PATCH 03/28] proc: Split kcore bits from linux/procfs.h into
 linux/kcore.h [RFC]
To:     David Howells <dhowells@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, x86@kernel.org,
        sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <kosaki.motohiro@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36248
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

On Tue, Apr 16, 2013 at 3:07 PM, David Howells <dhowells@redhat.com> wrote:
>
> KOSAKI Motohiro <kosaki.motohiro@gmail.com> wrote:
>
>> I have no seen any issue in this change. but why? Is there any
>> motivation rather than cleanup?
>
> Stopping stuff mucking about with the internals of procfs incorrectly
> (sometimes because the internals of procfs have changed, but the drivers
> haven't).

OK, thank you for explanation.

Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
