Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 02:38:11 +0200 (CEST)
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35562 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842528AbaGXAiISkdCd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Jul 2014 02:38:08 +0200
Received: by mail-oi0-f54.google.com with SMTP id i138so1471521oig.41
        for <linux-mips@linux-mips.org>; Wed, 23 Jul 2014 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4G1dsMhUUX4F4MCzVLJv9fJASIb4K8oHtudMcGdwR6c=;
        b=OYybuU+G0+9BadVBL06/sSzU3hE+EqDfRrsdQzgqPJiGOUECxfQokRwuP8DjVZ5Vg/
         QAtbO/imvoq4ivJwj60cZjoVYrCx5OSDndoAbbw24Y90iTS8kUSLDfmQxcRQhOOrnGdn
         Hkdk1PqzGepbARC7lJmd/SKy2jJ2bQDhBjst0O1Apt88BEnzNmJUr6SnN2XLyp9VVG9/
         LX/0mC9C/Jop9hRbtq4+VmI5MY44yCL7nWQijCd6Txoa6qIpF3/AEiYrwRsVQugPiOfo
         XP457of1lAO7EuQi0pYNGddeqFfk6A4Wm5RzakkJWQKxua+LtsQJqRE6bkYV96w+HmlN
         BYcQ==
MIME-Version: 1.0
X-Received: by 10.60.134.76 with SMTP id pi12mr7645269oeb.0.1406162281559;
 Wed, 23 Jul 2014 17:38:01 -0700 (PDT)
Received: by 10.76.130.47 with HTTP; Wed, 23 Jul 2014 17:38:01 -0700 (PDT)
In-Reply-To: <20140723141721.d6a58555f124a7024d010067@linux-foundation.org>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
        <20140723141721.d6a58555f124a7024d010067@linux-foundation.org>
Date:   Thu, 24 Jul 2014 04:38:01 +0400
Message-ID: <CAMo8BfJ0zC16ssBDGUxsLNwmVOpgnyk1PjikunB9u-C7x9uaOA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41554
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

Hi Andrew,

thanks for your feedback, I'll address your points in the next version of this
series.

On Thu, Jul 24, 2014 at 1:17 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> Fifthly, it would be very useful to publish the performance testing
> results for at least one architecture so that we can determine the
> patchset's desirability.  And perhaps to motivate other architectures
> to implement this.

What sort of performance numbers would be relevant?
For xtensa this patch enables highmem use for cores with aliasing cache,
that is access to a gigabyte of memory (typical on KC705 FPGA board) vs.
only 128MBytes of low memory, which is highly desirable. But performance
comparison of these two configurations seems to make little sense.
OTOH performance comparison of highmem variants with and without
cache aliasing would show the quality of our cache flushing code.

-- 
Thanks.
-- Max
