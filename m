Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2016 08:36:41 +0200 (CEST)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33705 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992128AbcJMGge5CT2t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2016 08:36:34 +0200
Received: by mail-lf0-f52.google.com with SMTP id x79so122491160lff.0
        for <linux-mips@linux-mips.org>; Wed, 12 Oct 2016 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=F4tboEndQR/q9H2iopejobn4ctdFs1FJ/mO1vG3YR5Q=;
        b=VNHwM1sLWel3Mz7hq2onXmoA649szSa8R8JqZTTwqp1ZgY6XFENhgTNFxrzxrDpPJB
         jq6lHbe6Y4EtF56x6NZsgkLKvUZRmeU27/Kz4F0zqCTg9UfyBVeHY8u3A/QyoW6019rM
         sipDlGxKk1Afx8xMYXzKlw2XsRbt9jcbF+afAijSSaKdWhKp5JB2TMnS/oFCadGaeJrt
         kxwQ5y+4fW9i4Qrf1lqS7RSUCiL6SSfInKFyxJHMz56n+ZltjvK9qCfExIW14wz9nyQD
         OGc3sUMPmW+MhnGxTfKYzIDh35ZohbBbxLC4mnqTUahVp7bsUXfGkhQROVjYzWUt9wy1
         Zn3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=F4tboEndQR/q9H2iopejobn4ctdFs1FJ/mO1vG3YR5Q=;
        b=SGP4zRSdDnMpAoeI3PSwC/IboNIzjy5ZRxePOiAK9DQ8I35E2HkthsrrRylOEHYH2W
         y1+WY+vj9DqQ+79as825VpAvxp84+AcKT0v9svPVegzlQKN3TkLPhdcxHBD+YFf6jqz4
         OZGrdyoEENQfg1OcVUZDazsux7aADals3zxgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=F4tboEndQR/q9H2iopejobn4ctdFs1FJ/mO1vG3YR5Q=;
        b=aVuCRURKJH2A2Jpo324HzxfolFHdt14kpf6c1LKxt7hoe1Ux/oDDKrsAtG2QnBfYCi
         z867shtW+U/hfGYov8yxUPTo2Mu8oxaiu8+qvY23Cf+7FF9eyoXJm8NKED5rn7TXujZI
         86WooWR4MJ05Sh4WeEUNKEzWjmYwA2wMx55r/S+tNrFR2fLfB5zNY6hErffWBCpHZCEr
         NTT+amefCypN9h9wPSUSgf3qPNv8+t2CvVCd3vGFqbyZDvUCw+woHZtZZN3s0natyD+V
         WwRTngCOOIJTYH9kGxejBZw6XtrYHNRET9pTlDLsBqHqHVeJhAv6rbd4UAfVFDgKG1e2
         ezzw==
X-Gm-Message-State: AA6/9RmpZpgwUTRbfGLBWTuLhOtxeeI9ZX/MiDFdZHnZRWZNdK0iT22+BIovHQYTRnVYsPt/G1eY03BGopHr2ChF
X-Received: by 10.28.209.142 with SMTP id i136mr903984wmg.1.1476340589285;
 Wed, 12 Oct 2016 23:36:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.104.67 with HTTP; Wed, 12 Oct 2016 23:36:28 -0700 (PDT)
In-Reply-To: <20161010132642.GA8229@linux-mips.org>
References: <20161008214714.5375-1-paul.burton@imgtec.com> <20161010132642.GA8229@linux-mips.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Oct 2016 23:36:28 -0700
X-Google-Sender-Auth: PPKDlpYGw8XLveXRN2XThNW_nFU
Message-ID: <CAGXu5jLZjFu_Mg93bzu0WBPwNVLuqmiNQ7O4Gpo4NaDn=yO_PQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Enable hardened usercopy
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Mon, Oct 10, 2016 at 6:26 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Oct 08, 2016 at 10:47:14PM +0100, Paul Burton wrote:
>
>> Enable CONFIG_HARDENED_USERCOPY checks for MIPS, calling check_object
>> size in all of copy_{to,from}_user(), __copy_{to,from}_user() &
>> __copy_{to,from}_user_inatomic().

Awesome! Thanks for hooking this up. (Were you able to test with
lkdtm's usercopy tests?)

> Patch looks good but I was wondering how about further usermode
> accessors such as csum_partial_copy_from_user, csum_and_copy_from_user,
> csum_and_copy_to_user, csum_partial_copy_nocheck?

Oh, hrm, this seems to be missing for all architectures. I would bet
KASan would be interested in instrumenting these too.

It seems these functions only used by networking code?

-Kees

-- 
Kees Cook
Nexus Security
