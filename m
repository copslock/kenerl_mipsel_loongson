Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 16:29:05 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.186]:39553 "EHLO
        gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493360Ab0AZP3B convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 16:29:01 +0100
Received: by gv-out-0910.google.com with SMTP id r4so281929gve.2
        for <multiple recipients>; Tue, 26 Jan 2010 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KkSqBPQ0/cI2DoWWOkKbZ3pI7MZDsbNuLJZxypRg3IQ=;
        b=VEumxtHeJcQe5dBaXB/jmc09LW050iIt3LA/RMxHN75B7U24f5R0METAcgM91rOSYI
         QelDhpQnDcTYCtj47isqMOFwVzOSgeAj6N7JifW3SyfDK26Sdz9FIAC659G5s9D9UGUq
         VR9G8dCmn+qhWcdlbTQMrK0uwr2BECfj7vSPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uenV2T/OJmxmd1RXW0soXe3SiWFjRjzZW4UmsI+ozpMqRVIK326qYd4H3+9iUJVPwF
         d6mb6+laoKzw6JyJufqmxUUM0A/xynHpqSo6KWQFlD9Esh5/UGHkNm2TWV4vq3ct2rx9
         SHFwJHPrD7VMdAGXOqROxSUb3w6SEbF2SMg1E=
MIME-Version: 1.0
Received: by 10.102.174.11 with SMTP id w11mr4169672mue.17.1264519739193; Tue, 
        26 Jan 2010 07:28:59 -0800 (PST)
In-Reply-To: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
References: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
Date:   Tue, 26 Jan 2010 16:28:59 +0100
Message-ID: <f861ec6f1001260728x64c54ec7m65bc6ebc0ee64a80@mail.gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Cleanup the debugging of compressed 
        kernel support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16760

Hi,

On Tue, Jan 26, 2010 at 4:02 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> Changes from v1 (feedbacks from Ralf):
>
>  o make DEBUG_ZBOOT also depend on DEBUG_KERNEL
>
>  o DEBUG_ZBOOT already depends on SYS_SUPPORTS_ZBOOT_UART16550 so simplify the

Not every chip has a standard 16550, unfortunately.  I liked your
first iteration better:
DEBUG_ZBOOT visible at all times (or depend on DEBUG_KERNEL)  another
(invisible)
config symbol selecting the code to build (i.e. SYS_SUPPORTS_ZBOOT_UART16550
for your loongson boxes, MACH_ALCHEMY for alchemy, and nothing for unsupported
chips).


>  obj-$(CONFIG_DEBUG_ZBOOT_UART16550) into just obj-$(CONFIG_DEBUG_ZBOOT) and
>  no ifdef.

The last hunk does something else:

> -obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> +obj-$(CONFIG_SYS_SUPPORTS_ZBOOT) += $(obj)/uart-16550.o

Manuel
