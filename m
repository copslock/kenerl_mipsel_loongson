Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jul 2013 17:35:14 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62288 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816743Ab3GSPe567zio (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jul 2013 17:34:57 +0200
Received: by mail-pa0-f54.google.com with SMTP id kx10so4567010pab.13
        for <multiple recipients>; Fri, 19 Jul 2013 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JuxQFi2bP7k/R3RMc9PpqHE5Iw7moWKzq44OIYoTp0k=;
        b=tZb65nvJT/EHXWh1IvTocKH0gVZN3fhKBPCyfDZ/fAMw6vt+SGsKuEMjRogU4XnafH
         OALBYNz5SucBG/ztzQ7LbQUOwOHlO1/A8zFofb1nxG4fTYhC9FfZzwFaCHCZ4Vt/1RHD
         YFXbKz409vYH2ZwB9XtZfMroDDvpHb6MxDmQTfp8I64CvrfqcGRreY4bhOKHXUT68qIi
         4cIYRS/3JWonPPKm8Mf4ZPgWkD6tFKrf8xTZL1yVp6HdPbaFg649rbphtaw25mikIxzC
         hktruqWxPcT8y+BJsIPi1L4xjN3V8zrXLafAvs+vX69fewUHrYYnPTtCINVKmBJdE+uK
         +WFA==
MIME-Version: 1.0
X-Received: by 10.66.163.130 with SMTP id yi2mr18870055pab.7.1374248091050;
 Fri, 19 Jul 2013 08:34:51 -0700 (PDT)
Received: by 10.68.223.194 with HTTP; Fri, 19 Jul 2013 08:34:50 -0700 (PDT)
In-Reply-To: <20130618164744.GA21210@linux-mips.org>
References: <1371233403-30153-1-git-send-email-kdasu.kdev@gmail.com>
        <20130618164744.GA21210@linux-mips.org>
Date:   Fri, 19 Jul 2013 08:34:50 -0700
Message-ID: <CAJiQ=7AFwKJA2TdCpreO_=2zHVoVn61pwRUrS9D6u67NnCd1pA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix get_user_page_fast() for mips with cache alias
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Tue, Jun 18, 2013 at 9:47 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 14, 2013 at 02:10:03PM -0400, Kamal Dasu wrote:
>
>> get_user_pages_fast() is missing cache flushes for MIPS platforms
>> with cache alias. Filesystem failures observed with DirectIO
>> operations due to missing flush_anon_page() that use page coloring
>> logic to work with cache aliases. This fix falls through to take
>> slow_irqon path that calls get_user_pages() that has required
>> logic for platforms where cpu_has_dc_aliases is true.
>
> A bit unsatisfying to always fall back to the slow variant yet I like
> the patch because of it's simplicity but I wonder if there's not a
> better solution.

Hi Ralf,

What are your thoughts on pushing this fix to the stable tree for
3.4+?  Without Kamal's patch, ntfs-3g is completely broken on MIPS
platforms that have cache aliases.

Thanks.
