Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 04:42:16 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:61627 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491090Ab0HECmN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Aug 2010 04:42:13 +0200
Received: by wwa36 with SMTP id 36so295754wwa.0
        for <linux-mips@linux-mips.org>; Wed, 04 Aug 2010 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=VDCL8/GNB3IIqEpFLLb6hwKLRynum78h+mSqVlxBY1c=;
        b=YY7WJMMzCJozi7uhLo2udqld4rTKYwwWETSm6NurXvUZxWcjhy0SfJ5hnLS6nhpMWZ
         snwMjtA4vJhGVgpBVUiC2zXlwaitVpgW5zbEylck9N1k06WhHfXtYxWdo8rBLMYm1Pxo
         sxa15HfJLud+N2mHN6SgfV1Rfu50V1wGFkNtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lCZ53CCLUvdjyM5lG8GMW3Hkvolc6ymyG046IE9nr0DFCzXLSK2LWHlcWIWW6oDRQ7
         fe93paqcc+HwjGEuO4z9YwiyKligfzHa1QkbMawWOkwOUsS+kqcpRO32c6WKQvKPyYFZ
         7Rm42hyvtgYp7xRrAQ7Ee54pAW9YAF7umvKA0=
MIME-Version: 1.0
Received: by 10.216.235.104 with SMTP id t82mr2769949weq.103.1280976127653; 
        Wed, 04 Aug 2010 19:42:07 -0700 (PDT)
Received: by 10.216.159.204 with HTTP; Wed, 4 Aug 2010 19:42:07 -0700 (PDT)
In-Reply-To: <20100805011343.GC28402@linux-mips.org>
References: <7a966ffadcf2a4600c098c3ac47ef1f645790946.1276674390.git.wuzhangjin@gmail.com>
        <20100805011343.GC28402@linux-mips.org>
Date:   Thu, 5 Aug 2010 10:42:07 +0800
Message-ID: <AANLkTimHgBvFejM1Kec8rWX-MPOFsV3nYrNdiWStuVJ0@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Clean up arch/mips/boot/compressed/ld.script
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

On Thu, Aug 5, 2010 at 9:13 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Applied - but there was an entirely avoidable reject in that file *grrr* :-)
>

Thanks, Just took a look at your upstream-linus.git git repo and found
you have applied them in a wrong order and have forgotten applying the
first one of them ;)

1. [v2] MIPS: Unify the suffix of compressed vmlinux.bin
http://patchwork.linux-mips.org/patch/1323/

This one should be applied as the first one, but seems this is still
in the patchwork ;)

2. [v4] MIPS: Clean up the calculation of VMLINUZ_LOAD_ADDRESS
http://patchwork.linux-mips.org/patch/1324/

3. MIPS: Clean up arch/mips/boot/compressed/ld.script
http://patchwork.linux-mips.org/patch/1381/

4. MIPS: Clean up arch/mips/boot/compressed/decompress.c
http://patchwork.linux-mips.org/patch/1382/

5. MIPS: strip the un-needed sections of vmlinuz
http://patchwork.linux-mips.org/patch/1383/

Sould I resend all of them in one patchset? But I can only do it tonight.

Thanks & Regards,
Wu Zhangjin
