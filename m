Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 15:37:06 +0100 (CET)
Received: from mail-oi0-f45.google.com ([209.85.218.45]:37356 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012586AbaKDOhBnoJCp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Nov 2014 15:37:01 +0100
Received: by mail-oi0-f45.google.com with SMTP id v63so6992378oia.4
        for <linux-mips@linux-mips.org>; Tue, 04 Nov 2014 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wcXjQBc/JeWU5ETO2hAn4xKuVYzDSQpzw2t57q04sPQ=;
        b=I4XARU0IVQM015ev98/KcenLVQZO2ACy/Bii4U07Pq8ZUiTLvRuQtkQTCpl2fH/zXs
         nHqi4g3WSLoY7ZabxKxHl5Odg8NlML6tfv2WnTZ3u6zjsm3PA/Q+Ar7273DEYWuhBQnS
         mOWj3BpUYHXbTNckmhXdbQiJw3L37lVwIBBUHtFgKGJlSPkmBtYSU58TOId/T/2Mia8i
         AkTD+935aLMMZm8br/Igl9IPHot0gTl8Hycn+t+IWUie8ExODxxipHex27jwtBSKd2Tb
         sHMnRX+RFWkVpy4AaXwWgqjwlm5UF8FDSeqKLGxYp5asyq5l+EdUZURpP5zhKeh6mvLE
         MbVw==
MIME-Version: 1.0
X-Received: by 10.182.98.168 with SMTP id ej8mr8678771obb.41.1415111815542;
 Tue, 04 Nov 2014 06:36:55 -0800 (PST)
Received: by 10.60.41.193 with HTTP; Tue, 4 Nov 2014 06:36:55 -0800 (PST)
In-Reply-To: <tencent_7A73C86D635497A07A126836@qq.com>
References: <CAKcpw6WiuqJ5Cn4FNoYQEga8KBhZAZ4ohx35MqsdaOZDL6bABA@mail.gmail.com>
        <tencent_7A73C86D635497A07A126836@qq.com>
Date:   Tue, 4 Nov 2014 22:36:55 +0800
Message-ID: <CAKcpw6Wb5+GMMHELghc4b2kss1bSGLqPw1k+MeJUsXzPA1Eb5w@mail.gmail.com>
Subject: Re: Problems of kernel of Loongson 3
From:   YunQiang Su <wzssyqa@gmail.com>
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

On Tue, Nov 4, 2014 at 10:24 PM, 陈华才 <chenhc@lemote.com> wrote:
> Hi,
>
> 1, You can try 3.16 from master branch here:
> http://dev.lemote.com/cgit/linux-official.git/

OK, I will try it. Even though, we still need a patch to make it can
use on Lemote machiens.

>
> 2, Since 3.14, radeon cannot support non-firmware display. This is confirmed by drm maintainers.

How can x86 machines display something when firmwares are missing?
Use something like vesa when firmwares are lost?

>
> Huacai
>
> ------------------ Original ------------------
> From:  "YunQiang Su"<wzssyqa@gmail.com>;
> Date:  Tue, Nov 4, 2014 09:40 PM
> To:  "陈华才"<chenhc@lemote.com>;
> Cc:  "linux-mips"<linux-mips@linux-mips.org>; "Aurelien Jarno"<aurelien@aurel32.net>;
> Subject:  Problems of kernel of Loongson 3
>
>
> I have tested the kernel 3.16, and 3.17 of Debian on loongson 3.
> I met 2 major problems:
>
> 1. On the Lemote 6100 and Yeeloong 8133, load command hangs
>
>  PMON> load (wd0,0)/vmlinux-3.16-3-loongson-3
>  Loading file: (wd0,0)/vmlinux-3.16-3-loongson-3
>  (elf64)
>  0x80200000/9171584 + 0x80abf280/34201152(z)
>
>  It also hangs on the dev board from Lemote.
>  While it can boot on dev boards from Loongson.
>
>  3.15 kernel works fine on both boards.
>
> 2. If without radeon non-free firmware in initrd/vmlinux,
>  the screen can display nothing.
>  It makes us difficult to patch debian-install to support Loongson 3.
>  A automatic fallback may be needed when nonfree firmware is not available.
>
> --
> YunQiang Su



-- 
YunQiang Su
