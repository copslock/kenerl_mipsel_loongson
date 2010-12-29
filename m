Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Dec 2010 06:34:01 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:60474 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490981Ab0L2Fd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Dec 2010 06:33:58 +0100
Received: by wwi18 with SMTP id 18so10324487wwi.0
        for <multiple recipients>; Tue, 28 Dec 2010 21:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9K6T/3ljyG41rGtSFem/IB0vinHE/AuaCxt/iPQmXHM=;
        b=Ws8sEVfPOIGl1yH+A7M6pjv2Kbb9pcmkeordr4vOeRylzfoqtrdedaQxOlzioSQowO
         iZTc7xncvTLcg1C+cFkQileTsok3Qj8XLOEsrSWfZmsLLg5qx+da9rxFwN/XQP+wqTl4
         CpD2QjWntzhXsiSmXAs/13IKs5DlzQ8EjcPpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UFVqrLn0U5B5bvCDh/FLG0jKlDRMatXWuLfBXDb5DrJOVj4gMCrArRCi0YAqF7fhh0
         Mq1EBQCeLWBy52WocwhQas02JE1hmN7JookMsPTzcMCP06u8THXaGoZ7hKyEGJFTiNwJ
         dNoy+cNCIhiKGJtJMEGT/bidXh4H8RAHR0EyM=
MIME-Version: 1.0
Received: by 10.216.179.81 with SMTP id g59mr18314967wem.35.1293600833003;
 Tue, 28 Dec 2010 21:33:53 -0800 (PST)
Received: by 10.216.131.88 with HTTP; Tue, 28 Dec 2010 21:33:52 -0800 (PST)
In-Reply-To: <1293298802-12727-1-git-send-email-wuzhangjin@gmail.com>
References: <1293298802-12727-1-git-send-email-wuzhangjin@gmail.com>
Date:   Wed, 29 Dec 2010 13:33:52 +0800
Message-ID: <AANLkTimraQMBydm1xhR6vAvmta0YP4KtekXq3S7qa-7g@mail.gmail.com>
Subject: Re: [v2 PATCH] MIPS: Add current_cpu_prid() to optimize the code generation
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

This patch is too big for review, If the basic idea is okay for you, I
will split it and resend it.

Thanks,
Wu Zhangjin

On Sun, Dec 26, 2010 at 1:40 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> current_cpu_prid(), cpu_prid_comp(), cpu_prid_imp() and cpu_prid_rev()
> are added to simplify/beautify the processord_id related code.
>
> And if current_cpu_prid() is pre-encoded for the specific processor in
> cpu-feature-overrides.h, the code generation will be optimized.
>
> cpu_prid_encode() and cpu_prid_encode_copt() are added to encode the
> current_cpu_prid(), the former one can be used by most of the processors
> whose 'Company Options' part of the prid register is 0 or is not used by
> any of the existing codes. Or current_cpu_prid() can be simply assigned
> as the value of read_c0_prid(), which can be printed by the
> show_cpuinfo() defined in arch/mips/kernel/proc.c.
>
> The size of compressed kernel image(vmlinuz) can be reduced about 0.1M
> if current_cpu_prid() is pre-defined as a fixed value in
> cpu-feature-overrides.h.
