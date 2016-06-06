Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 17:53:39 +0200 (CEST)
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38239 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042675AbcFFPxhIVOVn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 17:53:37 +0200
Received: by mail-wm0-f54.google.com with SMTP id m124so78290146wme.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2016 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OZxCcnbHrxrbVMtewNX2QySxauqhjgR+ytymF7tMT3k=;
        b=T6RbFcQLeq9skoubq1z5ZBpG539B6Rlmf9tHeKk1PZX4wpzhtDFTLiAmLewrYql8ip
         4JsHU66H6DG8W7cGEy31OdCzNap3tSuEU7TxWIWrwG56ODCjzlEGlSYpW/fY1qiTCuE2
         Hy1rvDdnvNhYk8MlTLIU/D5kaYPzHxvniznbjtPHLjvyru/QsTYVtQdxRE1Kd5axCciv
         gYhRf9NRZFignsqplLqWXIls1EK5hmaapLvazwQx9AVOA8lMiVyZ/dZM9MqrRnDtUeSA
         enskeN6Zm65qMrYKjSIYU9ColUJxYZKJv3OAfR5e43dNnpwCN8FKV23RjedzI2OgfkVt
         JJ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OZxCcnbHrxrbVMtewNX2QySxauqhjgR+ytymF7tMT3k=;
        b=fxc4S0QoyFI11cy69zcTmIZwwAj9mPaBJqm4TpzaYr1jR9KK8i5qWyaMZbEoO25HL1
         mJa2D2H963MS3HTIz5wfcgwrVb0vGoO1ZQ+NkF+GPr0EKrA5VXEunpyCPhYM7vurfXJr
         g3x7tCh+TAuHsQYPNXtBvDF/nk8nQbF1kdfns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OZxCcnbHrxrbVMtewNX2QySxauqhjgR+ytymF7tMT3k=;
        b=WRfqwxiUC/0jzDMs7EBxqHU/iTyYyd7hF/9rwDwFOfhiX21TmY7HAdgVcn5W7m3Igj
         TvxOSp295GAEu0BAnSSX8cw7oD8ZfXB1fJU4OgU0yDcEsSAlp/Fa74beRwEF1GfwQR6G
         RXDrwXxxIZrRieLwnkocT59SFBr5X7g6CjrsGQa/s0kRAokIsMLb09CW/h4+PrJ01wJI
         +NsAeP63hiILaSuUhOFpfM3Kws9J0f+P5vfVuNXq49fa9MVTpZcNzPfeq7XVKVD4cw/k
         1FHDWpo4+pLH3TW0it2vUXrsPhKqEWg++G88oiRw+QcpW44MbRKf201BcpUzBh7xJMot
         TfcQ==
X-Gm-Message-State: ALyK8tKbVxW9siBQSobse8rBL+iblsvXMQaxCc7pfn1h07U8murvYsJXYW10MFt8KQxmBCoylrKu0ci+hYU67XrM
X-Received: by 10.194.10.69 with SMTP id g5mr16362195wjb.7.1465228411296; Mon,
 06 Jun 2016 08:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.157.83 with HTTP; Mon, 6 Jun 2016 08:53:29 -0700 (PDT)
In-Reply-To: <1465215656-20569-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465215656-20569-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 Jun 2016 08:53:29 -0700
X-Google-Sender-Auth: 52wQYIrY9RjpAr7jBLqXEMupGeI
Message-ID: <CAGXu5j+z-QOG+x6ie+BYVTmopCSZrLzzH3A2zLE1nQi+Q+WyKg@mail.gmail.com>
Subject: Re: [PATCH] tree-wide: replace config_enabled() with IS_ENABLED()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stas Sergeev <stsp@list.ru>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>, Jiri Slaby <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Brian Gerst <brgerst@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Drewry <wad@chromium.org>,
        Nikolay Martynov <mar.kolya@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Cowgill <James.Cowgill@imgtec.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        linux-media@vger.kernel.org,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mikko Rapeli <mikko.rapeli@iki.fi>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linaro-mm-sig@lists.linaro.org,
        Brian Norris <computersforpeace@gmail.com>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        ath10k@lists.infradead.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roland McGrath <roland@hack.frob.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tony Wu <tung7970@gmail.com>,
        Huaitong Han <huaitong.han@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "David S. Miller" <davem@davemloft.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        ath9k-devel@lists.ath9k.org, David Woodhouse <dwmw2@infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rabin Vincent <rabin@rab.in>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53889
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

On Mon, Jun 6, 2016 at 5:20 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The use of config_enabled() against config options is ambiguous.
> In practical terms, config_enabled() is equivalent to IS_BUILTIN(),
> but the author might have used it for the meaning of IS_ENABLED().
> Using IS_ENABLED(), IS_BUILTIN(), IS_MODULE() etc. makes the
> intention clearer.
>
> This commit replaces config_enabled() with IS_ENABLED() where
> possible.  This commit is only touching bool config options.
>
> I noticed two cases where config_enabled() is used against a tristate
> option:
>
>  - config_enabled(CONFIG_HWMON)
>   [ drivers/net/wireless/ath/ath10k/thermal.c ]
>
>  - config_enabled(CONFIG_BACKLIGHT_CLASS_DEVICE)
>   [ drivers/gpu/drm/gma500/opregion.c ]
>
> I did not touch them because they should be converted to IS_BUILTIN()
> in order to keep the logic, but I was not sure it was the authors'
> intention.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Sounds good to me! :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
Chrome OS & Brillo Security
