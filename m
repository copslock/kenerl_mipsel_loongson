Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 21:52:08 +0100 (CET)
Received: from mail-oi0-f49.google.com ([209.85.218.49]:41873 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007839AbaLAUwHbB69M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 21:52:07 +0100
Received: by mail-oi0-f49.google.com with SMTP id i138so7977629oig.36
        for <multiple recipients>; Mon, 01 Dec 2014 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/juu/UmLjIVnV7w6WjxWVcXG3SUcit2cjwRHvGixCZE=;
        b=QsSOAf4ElNm55jpBRxTjuf5bhiaCMIwmt/CZWGuevy3MbrboFf0v3vRvPiWFbpFYLk
         e/Ob7COT+FhwN1bjvVdPNs84BoHVQgBU/0QEIhjZ0st93is1e64YjIKvEBnamKqzzRfj
         fnjF89NfjdjXlW6JeIAhtJTIVo1XaiOYr6uACIvzXI8i0WYGFNnS4pKkr8OqK42P5eMz
         fr+AYvnaaDPoBhbF3tl7ek5x9MuOdDqZ2Umha+JowKNT/FykTEGwncnuwQJHqPkOju7s
         aRgGXifOWVdFfThXIDrckPKXtcsdzjRPqq0DcnRO84IE3zjYCXcDWJKhbchN/5lhCof/
         B7CA==
MIME-Version: 1.0
X-Received: by 10.202.181.213 with SMTP id e204mr19808687oif.117.1417467121607;
 Mon, 01 Dec 2014 12:52:01 -0800 (PST)
Received: by 10.76.90.100 with HTTP; Mon, 1 Dec 2014 12:52:01 -0800 (PST)
In-Reply-To: <547CD304.20407@gmail.com>
References: <547CD304.20407@gmail.com>
Date:   Mon, 1 Dec 2014 23:52:01 +0300
Message-ID: <CAMo8BfKg=eb7wA2O+cKO+oLDDERh2CKBS7dyAvfqvCESEHWYEg@mail.gmail.com>
Subject: Re: [PATCH] arch: uapi: asm: mman.h: Support MADV_FREE for madvise()
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Chen Gang <gang.chen.5i5j@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "jejb@parisc-linux.org" <jejb@parisc-linux.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "chris@zankel.net" <chris@zankel.net>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jcmvbkbc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44534
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

On Mon, Dec 1, 2014 at 11:43 PM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
> At present, kernel supports madvise(MADV_FREE), so can benefit to all
> related architectures (can grep MADV_WILLNEED or MADV_REMOVE in "arch/"
> to know about all related architectures).

A similar patch has been posted a while ago:

http://www.spinics.net/lists/linux-mm/msg81538.html

-- 
Thanks.
-- Max
