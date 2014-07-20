Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jul 2014 19:50:12 +0200 (CEST)
Received: from mail-la0-f51.google.com ([209.85.215.51]:52043 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860045AbaGTRuKZ1eU0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Jul 2014 19:50:10 +0200
Received: by mail-la0-f51.google.com with SMTP id el20so4078723lab.24
        for <linux-mips@linux-mips.org>; Sun, 20 Jul 2014 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Axot5suLiu1vMhxjqfaSNunGUItZKuXzW0Poxxn1/bA=;
        b=jnyxUFCt+rJW0x+Hnz+SUkCdFNqMMxrmbgntvkTWw94TZThhQHrNcmh6WvzPBhsPQD
         UVwJDOUIItmSrruq7Via+GpPQ77UhrE7nu7A5kpMg50O1CPi25B4QCB5bLoceM+DtW5X
         LvCphrumLOnMJiXWiCKQozkZY2u8UM03nXo/oGHbHxBfzPe0GEo8Yx4N4alzaP+PrAba
         D/qgNtyIP/Y6Z8+bxFaffp94EkVu3w4F8b3eDpCmGutrO4Q62Ee4uYDQg5XocriE2QMR
         MscxkGYQK0rOFjrAeIl5M3dd/kygLEIfYG+9r8DdICeD56jNyevFEalfMvKX5tFYsCOj
         AYuA==
X-Gm-Message-State: ALoCoQmm/6B58KbOjQ0FgOfSYpqJFYq03+067Q+mArGi39UnXWD/ENDw1gi6X9DJ2dIrFflRFK5w
X-Received: by 10.112.144.104 with SMTP id sl8mr19263465lbb.52.1405878604665;
        Sun, 20 Jul 2014 10:50:04 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp31-75.pppoe.mtu-net.ru. [81.195.31.75])
        by mx.google.com with ESMTPSA id jf2sm20807792lbc.34.2014.07.20.10.50.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jul 2014 10:50:03 -0700 (PDT)
Message-ID: <53CC0149.3070902@cogentembedded.com>
Date:   Sun, 20 Jul 2014 21:50:01 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ZBOOT: add missing <linux/string.h> include
References: <1405877939-28649-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1405877939-28649-1-git-send-email-aurelien@aurel32.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 07/20/2014 09:38 PM, Aurelien Jarno wrote:

> Commit dc4d7b37 moves the string related functions into a separate file,

    Please also specify that commit's summary line in parens.

> which might cause the following build error, depending on the
> configuration:

> | CC      arch/mips/boot/compressed/decompress.o
> | In file included from linux/arch/mips/boot/compressed/../../../../lib/decompress_unxz.c:234:0,
> |                  from linux/arch/mips/boot/compressed/decompress.c:67:
> | linux/arch/mips/boot/compressed/../../../../lib/xz/xz_dec_stream.c: In function 'fill_temp':
> | linux/arch/mips/boot/compressed/../../../../lib/xz/xz_dec_stream.c:162:2: error: implicit declaration of function 'memcpy' [-Werror=implicit-function-declaration]
> | cc1: some warnings being treated as errors
> | linux/scripts/Makefile.build:308: recipe for target 'arch/mips/boot/compressed/decompress.o' failed
> | make[6]: *** [arch/mips/boot/compressed/decompress.o] Error 1
> | linux/arch/mips/Makefile:308: recipe for target 'vmlinuz' failed

> It doesn't not fail with the standard configuration, as when
> CONFIG_DYNAMIC_DEBUG is not set <linux/string.h> gets included in
> include/linux/dynamic_debug.h. There might be other way for it to
> get indirectly included.

> We can't add the include should not be added directly in xz_dec_stream.c

    I can't parse that. :-)

> as some architectures might want to use a different version for the
> boot/ directory (see for example arch/x86/boot/string.h).

> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

WBR, Sergei
