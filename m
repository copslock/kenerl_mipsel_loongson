Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Sep 2016 07:50:35 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34723 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992123AbcIEFu2j0owM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Sep 2016 07:50:28 +0200
Received: by mail-wm0-f66.google.com with SMTP id w12so2074152wmf.1;
        Sun, 04 Sep 2016 22:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FKQHvNirjZhIPbe/qWqgYzraS6XAmL9IcjGN8WoeGMI=;
        b=OorXs0hb6aORhwhlhQHb7LSXMA3TyzZqBpfliQ+pCExmpdHEhT6hFv2p7dGiryBXDw
         di9q0QV8tXadPHAyS7sJJ+ZMdKTZgEdo2B4o+XKF1VpmzjmMgzYedKLSwuXopOOrgib1
         FKDUWTZzOMplKwhPS2b4PykobgV4Q5/UyKjGsEMOP/IU9hGnThsky9Si17Ibuam+e+CM
         +iIoaN/SlSOfFZvry0VM8R/QPKDpHhwhJYfYh4ttFgg1B1Qth7pdsAD4abRJJjBn0VG9
         rf1ApzOReOAYZ0auIbD6g/7DDc0LEmCLgf91X2c+LZjtRirPih0WkR7DXOSh0iBxo8WK
         RLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FKQHvNirjZhIPbe/qWqgYzraS6XAmL9IcjGN8WoeGMI=;
        b=mjYo9eZPlYZMiK+x4UWD3uoCW1a/+iJ8Ww9FgMuDtJFl0FeG4hVgfY4JVzkEv0J9l2
         JUepwXuPv2M9/UG8/LR+pvQRig1JXqdZpLpGsv9eJKl3SRwpm8OJFDaPStu2nK3XwV7q
         JwSXtShn3C8u6QqDTccgee2HHG7SQF0too9WypEASVZaDl8WDGl3D6/9lGdf/rinCU7n
         UJ9pqokO7Ctds2mS1oDwpp6uk1usmP5A5lbtRNSeIEhndxty8nqN9+kZzwf2WLZgzYUR
         SXL0O7M/fwXIx/+F3FwAplkDk0FPVBo3gHm9Q+ajNropGCfh0H8n4iipFgEEnB1sCesQ
         jqew==
X-Gm-Message-State: AE9vXwNiU9cQkgAh762CZ9ZThxeu09znOyGCFWg9SbH4A1dgAj/pkeeI8mjJT+3Pcj6aRpNVzUqUloJgLBba1w==
X-Received: by 10.28.230.3 with SMTP id d3mr14230428wmh.114.1473054623132;
 Sun, 04 Sep 2016 22:50:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.154.207 with HTTP; Sun, 4 Sep 2016 22:49:42 -0700 (PDT)
In-Reply-To: <1473036483-1876-1-git-send-email-chenhc@lemote.com>
References: <1473036483-1876-1-git-send-email-chenhc@lemote.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Mon, 5 Sep 2016 07:49:42 +0200
Message-ID: <CAOLZvyEqNwruky+KMAtoN+RTvzxe0MwaraByBtBLemcQAEoWNg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add a missing ".set pop" in an early commit
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Sep 5, 2016 at 2:48 AM, Huacai Chen <chenhc@lemote.com> wrote:
> Commit 842dfc11ea9a21 ("MIPS: Fix build with binutils 2.24.51+") missing
> a ".set pop" in macro fpu_restore_16even, so add it.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/asmmacro.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> index 56584a6..83054f7 100644
> --- a/arch/mips/include/asm/asmmacro.h
> +++ b/arch/mips/include/asm/asmmacro.h
> @@ -157,6 +157,7 @@
>         ldc1    $f28, THREAD_FPR28(\thread)
>         ldc1    $f30, THREAD_FPR30(\thread)
>         ctc1    \tmp, fcr31
> +       .set    pop
>         .endm
>
>         .macro  fpu_restore_16odd thread
> --


Acked-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks for catching that one!

Manuel
