Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 22:39:12 +0100 (CET)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:50991 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007158AbbBXVjJXWxBe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 22:39:09 +0100
Received: by mail-qg0-f49.google.com with SMTP id q107so32458960qgd.8
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 13:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7DLe7kw5NYg1iFXEfXTw/weXlusoLnWgAIT0DbeIB5s=;
        b=mD9xlGdy5aJLiE62x5/oU3foKcPS//DsFncHKxFkotmnGH/wMulY4EXR4NpyrX9+pK
         MQUcQ1XireThMsJHqB9iVPt2Oz4FekfA0NzS5ey+a6AGwlT5/1pU+pYiMrLRL4zzidmQ
         6Wgt5P4tix89EkilGOltYkvqAqDy2iVEqpGgXhNRlHjh105Iu7kAI0wyuC2tdkzQBsz2
         dXneNhhd/53zuANPFdbzsxlirx74f9DEoHUcPXLusftkcxTIzpWOdUviy+0jrFqVuaT2
         0jcPnlOA7dYSSV2kF1f8PGKj4dSXBzPUf/cp8o/ly/CTc6uN6RQj5PXKP+8jeMeqVerM
         9KAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7DLe7kw5NYg1iFXEfXTw/weXlusoLnWgAIT0DbeIB5s=;
        b=QH9Arw2YPecjEROBewPeukuH83bt56Pwh3wWHhhxwYa55O9Ufokj7VtLnGTS6BJ0Q6
         vFf7mUiupbdjz+pR8m8h0r5NdHWlGE9HzTI8gLjjM2ZEaVPbt9dTAKWNbcIysjpZ1lAF
         BcB+OYq5e7FmrHo8VVAyGIc1RpxJd4YYzaBqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7DLe7kw5NYg1iFXEfXTw/weXlusoLnWgAIT0DbeIB5s=;
        b=cvDWCOENS3hJUsxQMmwgPZkvnQZKLGO6KYdS8amVwTtu1e1/61luozjbz0TwVrHOX8
         TSmz0GASvCXOuO0TUpTXoW04m/tEiHaZLnWDkbBXVI4nopFCH/Y/1OPzrQHsSVTD2sAk
         2oFZOGH8rWgNPHQ5u+asSzJNcWuD1qYm0IL7wDwF3d0uecqTEEUR25GnuRHcI+XiZUrE
         xAIT0sJPYhQCP71bLAaT9jQJ9yXxgBLhEe8bpF7Gw7TJLYpFC8eyOxjpXyNPKlxTMUhK
         XsdeiZ7A787vbKBNL99KbjUUVOdZkUEuLWFQaUzm7uSqeJto7aELEGulaxxL4K4F0GlC
         RlLg==
X-Gm-Message-State: ALoCoQmXATvjpXMHe9Wjd8s8Nbce2InymfJ/Zu4tEEJTQTONaR0knQzJV7GJskFhjGThDSghtW60
MIME-Version: 1.0
X-Received: by 10.140.31.36 with SMTP id e33mr61569qge.36.1424813943891; Tue,
 24 Feb 2015 13:39:03 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Tue, 24 Feb 2015 13:39:03 -0800 (PST)
In-Reply-To: <7814815.Q6KYv1fjo1@wuerfel>
References: <1424741507-8882-1-git-send-email-abrestic@chromium.org>
        <1424741507-8882-3-git-send-email-abrestic@chromium.org>
        <7814815.Q6KYv1fjo1@wuerfel>
Date:   Tue, 24 Feb 2015 13:39:03 -0800
X-Google-Sender-Auth: cSlJBPLqMtnsnCsZwV6oghJlMdU
Message-ID: <CAL1qeaHSErgc=W4mGhDAm7cu_J4wrOik27joB0Rd-2P7dk=QuA@mail.gmail.com>
Subject: Re: [PATCH 2/5] MIPS: Allow platforms to specify the decompressor
 load address
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Feb 24, 2015 at 12:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 23 February 2015 17:31:44 Andrew Bresticker wrote:
>> Platforms which use raw zboot images may need to link the image at
>> a fixed address if there is no other way to communicate the load
>> address to the bootloader.  Allow the per-platform Kbuild files
>> to specify an optional zboot image load address (zload-y) and fall
>> back to calc_vmlinuz_load_addr if unset.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>
> No objections to the patch, but have you considered doing the
> same thing as ARM's AUTO_ZRELADDR, where we calculate the
> address at runtime from the entry point?
>
> I assume this is the same kind of address you are talking
> about here; if not, nevermind.

It is the same sort of issue, though I think the only way to solve it
on MIPS would be to copy the image to the address it was linked at,
which could be problematic if there's overlap.  There's also the cache
maintenance we'd have to do, which varies from CPU to CPU (and more so
the ARM I believe).
