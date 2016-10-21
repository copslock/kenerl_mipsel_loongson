Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2016 02:52:21 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34632 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcJUAwOlZXvN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Oct 2016 02:52:14 +0200
Received: by mail-pf0-f193.google.com with SMTP id 128so6941618pfz.1;
        Thu, 20 Oct 2016 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=z0EJRF9J/Y8vd3z4dPjDpMMsQc3ki9h+uAW5QCy9790=;
        b=06CVNvskF2vBb0j5DwA18jHVRAzwynwBTgeE64W8tR8wXajqXPVw36p8g3GSwHEHBi
         bNBEioxDYsPwflPGFONmleyLEdryWJNqWGRU/UbthZGpS5ZYK6qKNuDkB6MCWer80RmW
         d8crkQWadeGxVG8fspy3JhRYpJj+1RPHY+mdWbFnbhxP88k3P5wXDZTDx51ZNqtjAkT4
         8A+oI2fLjpP1Hdom+AYs+Q7TfTjvzfbA+4DVEnVJwOMNnvSHypi8VOcqDspOr71EV/ve
         ocEbf3Uoa8a11c4gxVXFkJK3SncHkKN327q/tdNmavzpRGSayNxpzcpBldcReZAGmeUX
         CRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=z0EJRF9J/Y8vd3z4dPjDpMMsQc3ki9h+uAW5QCy9790=;
        b=i7NjyURccFqRUCsPHPJEsgsn+NbkQ3MtKI6ubvTBOxBHufnTplK9FnQ/oNfZQH7Ha0
         GoUTXz3P6lEweS+tkq89/juSAfyAd3EnILiviMOqzv7fJinVCB/nkQTOEDz1n5Vq1DTH
         FYDrf49t76zsH8WQoXAT8DE3DqvYVUZXUeasZSNsr2XIHLqlvOTczwqDSHHAhIK+h34O
         p/iVAKYRtQo5x9CGxBni8nivctVr/MQet6+5f6a7idKpOhCm6noJIYPDNqJkXFICFLxl
         y4AjL0O3ThE8XKWvr5e7H8ZOoxwI24dIWaVANXP5spmScEB9ZbzKukzT3OsjiD4N5B53
         3Y3A==
X-Gm-Message-State: AA6/9RmciudDhSphPOYbI0J4+7GRaZrlFvHGw2mwglTi/Ab74CLdQarU1Xc1vLYDjpDnFw==
X-Received: by 10.98.131.7 with SMTP id h7mr6274036pfe.86.1477011128227;
        Thu, 20 Oct 2016 17:52:08 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id a141sm33941pfa.38.2016.10.20.17.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Oct 2016 17:52:07 -0700 (PDT)
Date:   Fri, 21 Oct 2016 11:51:47 +1100
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/6] MIPS: Use thin archives & dead code elimination
Message-ID: <20161021115147.0f6eea51@roar.ozlabs.ibm.com>
In-Reply-To: <20161020202705.3783-1-paul.burton@imgtec.com>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
Organization: IBM
X-Mailer: Claws Mail 3.14.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <npiggin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: npiggin@gmail.com
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

Hey Paul,

On Thu, 20 Oct 2016 21:26:59 +0100
Paul Burton <paul.burton@imgtec.com> wrote:

> This series fixes a few issues with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> and then enables it, along with CONFIG_THIN_ARCHIVES, for MIPS. This
> leads to a typical generic kernel build becoming ~5% smaller:
> 
>   add/remove: 0/3028 grow/shrink: 1/14 up/down: 18/-457362 (-457344)
>   ...
>   Total: Before=9001030, After=8543686, chg -5.08%
> 
> Applies atop v4.9-rc1.


Very nice, and thanks for the kbuild fixes, I think they all look sane.

Let's try to get those kbuild fixes in through the kbuild tree first
(which has some other fixes required for 4.9). I can take them and send
them to kbuild maintainer if you like.

On powerpc we'll likely provide an option to select these manually for
4.9 because there has been the odd toolchain issue come up, so that's
something to consider.

For your linker script, you may consider putting the function sections
into the same input as other text. TEXT_TEXT does not include .text.*,
so mips's .text.* below it will catch those.

You may just open-code your TEXT_TEXT, and have:

*(.text.hot .text .text.fixup .text.unlikely .text.[0-9a-zA-Z_]*)

or similar.

Thanks,
Nick
