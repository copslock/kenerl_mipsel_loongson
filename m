Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2012 04:13:28 +0100 (CET)
Received: from mail-qa0-f42.google.com ([209.85.216.42]:50850 "EHLO
        mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823036Ab2KFDN0tYHD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2012 04:13:26 +0100
Received: by mail-qa0-f42.google.com with SMTP id b33so1054291qad.15
        for <linux-mips@linux-mips.org>; Mon, 05 Nov 2012 19:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=b6ZGmbY7E4bhjKbD7Z8i73TS0+PLbwPmh288yLt0ESc=;
        b=Ng0lLBAISCS71s4PWjo0JB8VBNCnArfqi31INKPywnPPsVu0eh1Jef0oWvz6tOjIJj
         o1pJx3aZ8IG96X6VQSSqv4H2n/yk/JlGyrRN9KbkdeTcn/EP8EzL31Gt3Py2mEg9sQG/
         gbEQMe9ZrpqpTX5by/UAe8OqjYfe8Gn+jleN19C8tGJdCVng4YfADg/wZnxNI/cMegj4
         v1+FTDtkX+Ohnn7zwnGvSriOHfb1NQ5rpc3G2PaUw0r/bCWwU5WVImZhwqryVtOc4tlp
         UNukhBfuMFuZ75aDFJOlFsUKVsMlH3NUDYn461BxxngZHZBxBHu2mF3aUcZFlSpPnHq5
         vqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=b6ZGmbY7E4bhjKbD7Z8i73TS0+PLbwPmh288yLt0ESc=;
        b=SxG7BQEKl6m2VVg52R72m9U1Hbw7E5IMvlpkX4HSbCqU4+Pt7cqZ9AMZZrEyfTAzEq
         paFxQLh0iDRh321TfDCjs3FiF/gV5u5QBFdFOkO30OIXUHfVbw7LZixy0cF2XBtgz6Ww
         NKVDf68GoH2X4fEtFOrA6h1JhcURiZs6gLzfkzONiPrtUOt9qrHTNPGs+clNkH+AII6v
         VR+nFjZ2WBcAmGYkCKzzeqvNK0r7HWEkl2F65HyYBozvH8kaRZfJ389zqXTDMB52SqlQ
         5+dxneCH5tgHXRh/XxDw2dUSRQtt6CJNGGNFrK6vqVWBxclLkvsKQnTade9kDCIct/PO
         N4+g==
MIME-Version: 1.0
Received: by 10.224.107.3 with SMTP id z3mr18287009qao.9.1352171599717; Mon,
 05 Nov 2012 19:13:19 -0800 (PST)
Received: by 10.49.35.77 with HTTP; Mon, 5 Nov 2012 19:13:19 -0800 (PST)
In-Reply-To: <20121105.202501.1246122770431623794.davem@davemloft.net>
References: <1352155633-8648-1-git-send-email-walken@google.com>
        <1352155633-8648-16-git-send-email-walken@google.com>
        <20121105.202501.1246122770431623794.davem@davemloft.net>
Date:   Mon, 5 Nov 2012 19:13:19 -0800
Message-ID: <CANN689Gt2mG8xfkVkFtOHDFxkoZZAL-p-8yMSw=qvy5zaGs1ag@mail.gmail.com>
Subject: Re: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
From:   Michel Lespinasse <walken@google.com>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, riel@redhat.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
        ralf@linux-mips.org, lethal@linux-sh.org, cmetcalf@tilera.com,
        x86@kernel.org, wli@holomorphy.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-Gm-Message-State: ALoCoQlCKeLInRX7xPaydJpwW2Y0I/KbWCpzeKqC+YtvqIswbK5W8PyYJ0pbCPokWPf1CkmyuYNb3vkwPsTFK++wwKWFJFGo/dr6hMEpR8m6C+2fQP2rJ2ZyvPMakgyyOeier5X+pC0P3b2m71d9vaMNyYCLpBoZ9XN+EG/q5W1iJHQD9Agbe1ewm3npg73jQ55xYvC8pfsSLUvQqYOYrkgykz/agjIX1A==
X-archive-position: 34898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: walken@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Nov 5, 2012 at 5:25 PM, David Miller <davem@davemloft.net> wrote:
> From: Michel Lespinasse <walken@google.com>
> Date: Mon,  5 Nov 2012 14:47:12 -0800
>
>> Update the sparc32 arch_get_unmapped_area function to make use of
>> vm_unmapped_area() instead of implementing a brute force search.
>>
>> Signed-off-by: Michel Lespinasse <walken@google.com>
>
> Hmmm...
>
>> -     if (flags & MAP_SHARED)
>> -             addr = COLOUR_ALIGN(addr);
>> -     else
>> -             addr = PAGE_ALIGN(addr);
>
> What part of vm_unmapped_area() is going to duplicate this special
> aligning logic we need on sparc?

The idea there is that you can specify the desired alignment mask and
offset using info.align_mask and info.align_offset.

Now, I just noticed that the old code actually always uses an
alignment offset of 0 instead of basing it on pgoff. I'm not sure why
that is, but it looks like this may be an issue ?

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
