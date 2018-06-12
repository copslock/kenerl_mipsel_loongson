Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jun 2018 10:13:43 +0200 (CEST)
Received: from mail-vk0-x244.google.com ([IPv6:2607:f8b0:400c:c05::244]:43186
        "EHLO mail-vk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992496AbeFLINga3uyV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jun 2018 10:13:36 +0200
Received: by mail-vk0-x244.google.com with SMTP id d74-v6so13580402vke.10;
        Tue, 12 Jun 2018 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y2BZHJyLODDXSd/OQ6ItWjdg9jgC2rhTrJbUKrkaFd8=;
        b=N1iHl/cWRKzcA/Fla656UgRHfPAHly0kULEhTWrFGbhvmP2dLwdg+i57sCqyxLjQg2
         i58xG2J8TRA6iMqtkKldIWHXymavAPHU73wkgjkf3OJ4HvKHihUZRQ+xdu3PE+GTV6Lp
         9wK9LrGS0jr8DrY5SFBp8ufcIWe6zHbZlik1mxgBYEl6TQw/pqTItOvqTmO7Vy4S2eHP
         TSy1SVQ28EKQoP1+jZdUjoFTm2dWT0UcPN7Ut3hqR4587/4pA/KSZveHUtYAGakeEQ+J
         /3y6tymRqUxNgNmjf9Mg0h6AnKgsCpsteAYtzJX/rjmoifbfPG43VNGruduIxxHB9YkO
         PGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y2BZHJyLODDXSd/OQ6ItWjdg9jgC2rhTrJbUKrkaFd8=;
        b=Cm9LmsvV+TQSl/u31SaZ4UpMqGiv60NMyQH/U8Xjnexrj3Ax6lI9xu9XHAIvAG6XPx
         eYdtVtR4+6NtIbHtqQpnJwjH5SS2NZlKWcYCOM2ksRDzlRNYFHJmLAmaz5Z8a7Cv/MOh
         486qUigGpsHe+F7n08cCmJevxfmeAM3ekkfiG6POVOAJcHLNQbCOZaI4kQYxn/7zwuSO
         3rBzl3O5BHOoMomjreZiW02RsG/ivS4QBSgtBLJ5erH5wsEf4QLa8YuTObwNpavmoTO4
         yfto3nidZKqkf4OBp03P2XdIbFbWVnqWvUqYvcZreOMLwNsSf1FDAuTt3lZCmgIQ7Go4
         ckTg==
X-Gm-Message-State: APt69E04Lz9jgpGuDN7Cow4XYPfUfyYndshMZwlxrT5Lbh7rx7KNGJOn
        cMwrA9w1hf8kiKfphfvUhcVqrzJdWFFl85Zj0ds=
X-Google-Smtp-Source: ADUXVKLdCHm7Ad9A+47ef/zwibGY7xwrNzvUMqmhSH/jthvaSvs5DCqnXsjl203kDF+IQl4OK2lzU/vqOOdO5uAsry0=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr1542764vkd.161.1528791210207;
 Tue, 12 Jun 2018 01:13:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:13:29
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-5-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-5-songjun.wu@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:13:29 +0300
Message-ID: <CAHp75Vc_EVgfj1MpuA_hKHgy6SiQdU7JQDdtVHfOT1sZ_K-nRQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Tue, Jun 12, 2018 at 8:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses platform-dependent functions
> ltq_w32()/ltq_r32() to access registers. Those functions are not
> available for other SoC which uses the same IP.
> Change to OS provided readl()/writel() and readb()/writeb(), so
> that different SoCs can use the same driver.

This patch consists 2 or even 3 ones:
- whitespace shuffling (indentation fixes, blank lines), I dunno if
it's needed at all
- some new registers / bits
- actual switch to readl() / writel()

Please, split.

> +#define asc_w32_mask(clear, set, reg)  \
> +       ({ typeof(reg) reg_ = (reg);    \
> +       writel((readl(reg_) & ~(clear)) | (set), reg_); })

This would be better as a static inline helper, and name is completely
misleading, it doesn't mask the register bits, it _updates_ them.

-- 
With Best Regards,
Andy Shevchenko
