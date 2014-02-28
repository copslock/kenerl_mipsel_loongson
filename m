Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2014 14:15:50 +0100 (CET)
Received: from mail-ee0-f43.google.com ([74.125.83.43]:61741 "EHLO
        mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816199AbaB1NPrndF2z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Feb 2014 14:15:47 +0100
Received: by mail-ee0-f43.google.com with SMTP id e53so2039132eek.2
        for <multiple recipients>; Fri, 28 Feb 2014 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mhd3n9nwtA+CTWJ0AkGYhmZvPkwKWm480T7zt2ufsQ8=;
        b=0U4MgWhLHRLSTDEHp//v1A93G0TjHiUHJPF0/iULQOlqyFwPSXXQmF9KS7gZn08XQy
         EWTsx2eGQN7fDye4wx/5zx5d2iMrEx44HMZ21pICWjFQ00r0Pddpj7lOxGNYDi9L169V
         4VTd4+9NKjnRsvsFyQYnutokzDXAD8CeAiIWZypGiOwwSVfzPWH2hEEauQwNdCC7UTuZ
         sGCJrLCswR8j4KxalUx7RsC1ZAs1cg3mYHrDZnt8c/sbgAAmc/8nGwdAGhcmqDLSwaIe
         nWMtbXDg2PZ5/O6ccygdmt6bg4avewUBUzL/Tku60Digs8YveCs63ce1QimLum0DCx3x
         8JEQ==
MIME-Version: 1.0
X-Received: by 10.204.94.199 with SMTP id a7mr10721bkn.25.1393593341953; Fri,
 28 Feb 2014 05:15:41 -0800 (PST)
Received: by 10.204.169.76 with HTTP; Fri, 28 Feb 2014 05:15:41 -0800 (PST)
In-Reply-To: <530C186D.3050602@roeck-us.net>
References: <52F5A6EE.7020000@roeck-us.net>
        <CAAhV-H7GbarXPb2uye1jiH+caAL4vWTVBeGY77Yf0tvdpGJtiA@mail.gmail.com>
        <52F5B8CE.1000808@roeck-us.net>
        <530C186D.3050602@roeck-us.net>
Date:   Fri, 28 Feb 2014 21:15:41 +0800
Message-ID: <CAAhV-H5+6BFr4Or8LP4T=td4eqsBvTsenaX0UgR6kqcUnxe6hA@mail.gmail.com>
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
X-archive-position: 39387
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

Hi, Ralf,

Could these two patches be merged in 3.14 (there is an updated
version: http://patchwork.linux-mips.org/patch/6550/ and
http://patchwork.linux-mips.org/patch/6551/)?

And by the way, is the V19 of Loongson-3's patchset good enough to be
merged in 3.15?

Huacai

On Tue, Feb 25, 2014 at 12:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/07/2014 08:55 PM, Guenter Roeck wrote:
>>
>> On 02/07/2014 07:57 PM, Huacai Chen wrote:
>>>
>>> Hi,
>>>
>>> Maybe you can try this:
>>> http://patchwork.linux-mips.org/patch/6506/
>>> http://patchwork.linux-mips.org/patch/6507/
>>>
>> With those two patches applied the problem is gone.
>>
>
> Any idea if and when those patches may find their way upstream ?
> 3.14-rc4 still has the problem.
>
> Thanks,
> Guenter
>
>
>> Thanks a lot!
>>
>> Guenter
>>
>>> On Sat, Feb 8, 2014 at 11:39 AM, Guenter Roeck <linux@roeck-us.net>
>>> wrote:
>>>>
>>>>
>>>> Hi all,
>>>>
>>>> in 3.14-rc1, my mips64 qemu test fails. The image boots and then hangs.
>>>> Bisect points to commit 597ce1723 (MIPS: Support for 64-bit FP with O32
>>>> binaries).
>>>> Reverting this commit fixes the problem. Disabling MIPS_O32_FP64_SUPPORT
>>>> in my test image does _not_ solve the problem. The qemu version does not
>>>> seem
>>>> to make a difference; I tested with qemu 1.6.0 and 1.7.0.
>>>>
>>>> Console log output is available in
>>>>
>>>> http://server.roeck-us.net:8010/builders/qemu-mips64-master/builds/34/steps/buildcommand/logs/stdio
>>>>
>>>> When the problem is seen, the emulation hangs as can be seen in the log,
>>>> and the qemu process consumes 100% CPU until it is killed.
>>>>
>>>> qemu command line is
>>>>
>>>> qemu-system-mips64 -kernel vmlinux -M malta -hda
>>>> core-image-minimal-qemumips64.ext3 \
>>>> -vga cirrus -usb -usbdevice wacom-tablet -no-reboot -m 128 --append
>>>> "root=/dev/hda \
>>>> rw mem=128M console=ttyS0 console=tty" -nographic
>>>>
>>>> The same configuration works fine with earlier kernels. I'll be happy to
>>>> provide
>>>> the detailed configuration as well as the root file system for testing
>>>> if
>>>> needed.
>>>>
>>>> Obviously I have no idea if this is a problem with the patch or with
>>>> qemu.
>>>> If there is anything I can do to help tracking down the problem further,
>>>> please let me know.
>>>>
>>>> Thanks,
>>>> Guenter
>>>>
>>>
>>>
>>
>
