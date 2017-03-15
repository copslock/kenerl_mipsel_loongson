Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 13:42:34 +0100 (CET)
Received: from mail-ot0-x241.google.com ([IPv6:2607:f8b0:4003:c0f::241]:34729
        "EHLO mail-ot0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991232AbdCOMm2JXJpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 13:42:28 +0100
Received: by mail-ot0-x241.google.com with SMTP id x37so2456226ota.1;
        Wed, 15 Mar 2017 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uxqNIL9zHoNsED2pjNODzkYqIZnfaN5giboD9PdMCIc=;
        b=No5b4MNEl4KJsg+GQ+pW8Lxn29fgU488hCFTAPD8woMXhRr1+aa5A3acdWc8Gp38T8
         qx5s9l9hH65ShwGh/yijW63QMyJ75gZ9HIePzqXtXxLLpkRcr9hhoccC2PsRbzf0Qu0Y
         teffa4ECdW+M9CAvlNn3JN13g8bHpnMmIDC3QoBaLJpZTEYU4WlML3eg/vLHEJfI9Z1P
         jt3wwMI5Pt6aM0UmQjENX/5nRP8k1cPHPA48bckZ70P1abRlkJzpUciHhWP9lvo6eGWC
         ww1EQEKlDN73IT9k4WgrD8aZ8H55+Boj9IIwEy2AtpeboHcABoPNmeCI+6bDIXEAh4FY
         kpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uxqNIL9zHoNsED2pjNODzkYqIZnfaN5giboD9PdMCIc=;
        b=qpJ5YfEH5qeI5Qv2B6jVHflfgZq6RARcuF2opkjUeZECRB8DE7TW423fsgT92Mozye
         /0QmoSSohlgy9USAM+Qcw56iAhq9EuVfzVmpZV1SzXyK2qCYGCSglPWxstt6IiTc0WOh
         CbKryReTZWmZtFwRyYnMtY/bHdQyTV2z2vgs2W7ADZ39fnbB2v+w1X+UqNI8APqIL0iM
         zpFSg74pnfUXbBJ1RtKMz24AwPGIGZV/UQqUc4toc3cdWBxcZk/giYYTg0LwBk0yFDix
         u1fHFvJLF1XL9JTpbLSUI4HDEHjccGRbGCCnplJglI1CfXwKPqEpATxS13ojGWJmYExf
         o9FA==
X-Gm-Message-State: AFeK/H0AYVUwOMzCO8U8RtrXAGN0WjS6VBdK6Uz4z7obtmEpQJiwaIFeThRLBcXHfplaJrjHjEc4s6nFWpllWg==
X-Received: by 10.157.56.6 with SMTP id i6mr1649769otc.253.1489581741571; Wed,
 15 Mar 2017 05:42:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Wed, 15 Mar 2017 05:42:21 -0700 (PDT)
In-Reply-To: <20170315072223.GD26837@kroah.com>
References: <58b2e1b1.16502e0a.696c.aa4e@mx.google.com> <CAK8P3a2YDcM3t2aJHNEv8C6EFN2P4hN1hKsqJ8K--_XEC12b5A@mail.gmail.com>
 <20170315072223.GD26837@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Mar 2017 13:42:21 +0100
X-Google-Sender-Auth: AvE9_qsQfOboC9niZzs2H8MEVX0
Message-ID: <CAK8P3a19darucxTU4rm6ApFB4CjPXqAkuVBx7M3btkaT5=f2YA@mail.gmail.com>
Subject: Re: stable build: 199 builds: 1 failed, 198 passed, 1 error, 31
 warnings (v4.4.52)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Mar 15, 2017 at 8:22 AM, gregkh <gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 28, 2017 at 02:55:42PM +0100, Arnd Bergmann wrote:
>> On Sun, Feb 26, 2017 at 3:09 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> > stable build: 199 builds: 1 failed, 198 passed, 1 error, 31 warnings
>>

>> d43e6fb4ac4a ("cpmac: remove hopeless #warning")

>> 358c07fcc3b6 ("mm: memcontrol: avoid unused function warning")
>>

>> 3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")

>> 32eb6e8bee14 ("MIPS: Netlogic: Fix CP0_EBASE redefinition warnings")
>
> And I've added these as well, thanks.

Thanks! Here are the latest results from

https://kernelci.org/build/stable-rc/kernel/v4.4.54-31-gfe326ea3fc88/

| Errors Summary
|
| 1 arch/mips/ralink/timer.c:146:2: error: implicit declaration of
function 'rt_timer_free' [-Werror=implicit-function-declaration]
| 1 arch/mips/ralink/timer.c:145:2: error: implicit declaration of
function 'rt_timer_disable' [-Werror=implicit-function-declaration]

d92240d12a got backported to 4.4.55-rc1 but should have only been
in v4.9 or higher (which contains 62ee73d284e7). Please revert that
one.

| Warnings Summary
| 1 net/wireless/nl80211.c:5109:1: warning: the frame size of 2064
bytes is larger than 2048 bytes [-Wframe-larger-than=]
| 1 net/wireless/nl80211.c:3875:1: warning: the frame size of 2168
bytes is larger than 2048 bytes [-Wframe-larger-than=]
| 1 net/wireless/nl80211.c:1744:1: warning: the frame size of 5640
bytes is larger than 2048 bytes [-Wframe-larger-than=]
| 1 drivers/tty/vt/keyboard.c:1470:1: warning: the frame size of 2344
bytes is larger than 2048 bytes [-Wframe-larger-than=]

Still broken on mainline, will get back to this in a few days.

| 1 drivers/scsi/mvsas/mv_sas.c:736:3: warning: this 'else' clause
does not guard... [-Wmisleading-indentation]

Harmless warning that was fixed by
7789cd39274c ("mvsas: fix misleading indentation")

which got merged into v4.5. Caused by 0b15fb1fdfd4 ("[SCSI] mvsas:
add support for Task collector mode and fixed relative bugs") in v3.0.

     Arnd
