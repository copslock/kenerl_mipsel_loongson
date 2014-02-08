Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Feb 2014 04:58:00 +0100 (CET)
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53910 "EHLO
        mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822188AbaBHD55ySI5u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Feb 2014 04:57:57 +0100
Received: by mail-bk0-f52.google.com with SMTP id e11so1266297bkh.25
        for <multiple recipients>; Fri, 07 Feb 2014 19:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZHfZ3PsJRGYjAPpHC63+nKgp4veWRpS5IVQ+COBVSuQ=;
        b=o77nqH+DNGdXQEMM8GlfWxkdJk87q721rBzI/OUmDjU7jMOQrY+KD+igco6/KTf/RV
         MZKU2R23SCzrdbpeAsUi4eq8INipitxvDkQRaaYGOqr7wlaEyMG9jCWKiDBmXezFBrnn
         ITNtX8VI+tX7FVlsedDV803zeXeAwdmvgiiyae1WCAaluNBqrBEr+YhUIURHW+0CmTmB
         MVIm62jolUqWGWRMhHepRju1a8kB/58j0akXUUP+//94u5EsnaEt4c8KhlSiknOgCETs
         GCq8Zb35vxBUNf8VR7h6SzkUuD8efJ7H/B3JfclFQPHAtLqxs8KDQiad5LIfJQ804mOQ
         MSzg==
MIME-Version: 1.0
X-Received: by 10.204.26.69 with SMTP id d5mr50721bkc.47.1391831872346; Fri,
 07 Feb 2014 19:57:52 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Fri, 7 Feb 2014 19:57:52 -0800 (PST)
In-Reply-To: <52F5A6EE.7020000@roeck-us.net>
References: <52F5A6EE.7020000@roeck-us.net>
Date:   Sat, 8 Feb 2014 11:57:52 +0800
Message-ID: <CAAhV-H7GbarXPb2uye1jiH+caAL4vWTVBeGY77Yf0tvdpGJtiA@mail.gmail.com>
Subject: Re: Commit 597ce1723 (MIPS: Support for 64-bit FP with O32 binaries)
 causing qemu hang with mips64 kernels
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi,

Maybe you can try this:
http://patchwork.linux-mips.org/patch/6506/
http://patchwork.linux-mips.org/patch/6507/

On Sat, Feb 8, 2014 at 11:39 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi all,
>
> in 3.14-rc1, my mips64 qemu test fails. The image boots and then hangs.
> Bisect points to commit 597ce1723 (MIPS: Support for 64-bit FP with O32
> binaries).
> Reverting this commit fixes the problem. Disabling MIPS_O32_FP64_SUPPORT
> in my test image does _not_ solve the problem. The qemu version does not
> seem
> to make a difference; I tested with qemu 1.6.0 and 1.7.0.
>
> Console log output is available in
> http://server.roeck-us.net:8010/builders/qemu-mips64-master/builds/34/steps/buildcommand/logs/stdio
>
> When the problem is seen, the emulation hangs as can be seen in the log,
> and the qemu process consumes 100% CPU until it is killed.
>
> qemu command line is
>
> qemu-system-mips64 -kernel vmlinux -M malta -hda
> core-image-minimal-qemumips64.ext3 \
> -vga cirrus -usb -usbdevice wacom-tablet -no-reboot -m 128 --append
> "root=/dev/hda \
> rw mem=128M console=ttyS0 console=tty" -nographic
>
> The same configuration works fine with earlier kernels. I'll be happy to
> provide
> the detailed configuration as well as the root file system for testing if
> needed.
>
> Obviously I have no idea if this is a problem with the patch or with qemu.
> If there is anything I can do to help tracking down the problem further,
> please let me know.
>
> Thanks,
> Guenter
>
