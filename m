Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 23:32:17 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:51413 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992675AbdJSVcKs775L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Oct 2017 23:32:10 +0200
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 52fd2693
        for <linux-mips@linux-mips.org>;
        Thu, 19 Oct 2017 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:content-type; s=mail; bh=hHdLMa
        qMRrYapwPKradcX2o+PXQ=; b=MoAtC2ZvB3ApbEAF7KFG9VkqwPZ+W/u8ZbZhN9
        bCbzSpZzuSe4snR4FxvRCs3Elfcyh5hwbKyn3hiZMfo/A/mvycw1mB8STY7LQJ11
        ii49BNwPlefTIaQzVhQsZSvijdwPKbQS6UxLBhuGDpEW9k1mnDeFNg379dz8SfvG
        YLDAev1MBy560Df3Ecw8O3h2Z7U1BIuooS1ABwrY19cUg10PDrNwsd+WZZHXWkJ5
        BX0xYHfyyjGDAd9qvN629nVu2rUR6Z79+0OFttmgxQKTAuZ63UFlwYGtEXtWmcJN
        lw/7Tk1Prun9VJNSy28+Dwnhq7HsetYUlXfOtOXlxecVBEmg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 919406cd (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 19 Oct 2017 21:24:04 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id m198so17148577oig.5
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2017 14:24:58 -0700 (PDT)
X-Gm-Message-State: AMCzsaUbXt+R0S8f/vLUzxnbE2d0Oq89rg5qORLBqcyj0wIaKPlEhi46
        6dvAM1tWKZkxA8fIHGia2w9xr981vUgBcgVa84c=
X-Google-Smtp-Source: ABhQp+RE+CZo8Hnp4yrSzQKSPciUKywPBEAtEM/7HPpRS3xhgqXP7EPNP848LDL9kqkgmtavDAZZhhg4qbll6nXnZNE=
X-Received: by 10.157.3.102 with SMTP id 93mr1871086otv.165.1508448297936;
 Thu, 19 Oct 2017 14:24:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.41.205 with HTTP; Thu, 19 Oct 2017 14:24:57 -0700 (PDT)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 19 Oct 2017 23:24:57 +0200
X-Gmail-Original-Message-ID: <CAHmME9oCnYJV=1cvKsdWTuZeqLD5najE7j3dKS6sR9uj7+uZtA@mail.gmail.com>
Message-ID: <CAHmME9oCnYJV=1cvKsdWTuZeqLD5najE7j3dKS6sR9uj7+uZtA@mail.gmail.com>
Subject: minimal kernel config for qemu/malta
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hey folks,

I've got some CI infrastructure for WireGuard sitting on
build.wireguard.com , where I build new kernels for different
architectures. This works well for x86{_64) and arm(64), but I'm
having trouble getting it rolling on qemu/malta, and none of my usual
tricks seem to be working. (By tricks of course I mean enabling a
bunch of random stuff until it works, and then bisecting options until
I find the missing one...)

The magic lives here:
https://git.zx2c4.com/WireGuard/tree/src/tests/qemu

Essentially what's happening is that this config file:
https://git.zx2c4.com/WireGuard/tree/src/tests/qemu/kernel.config
is prepended with this set of MIPS-specific directives:
CONFIG_CPU_MIPS32_R2=y
CONFIG_MIPS_MALTA=y

And then is combined into the final .config using:
$ make allnoconfig
$ scripts/kconfig/merge_config.sh -n .config kernel.config.from.above

Finally, qemu is launched with:

        qemu-system-mips \
               -nodefaults \
               -nographic \
              -cpu 24Kf -machine malta \
               -smp 2 \
               -m 192M \
               -object rng-random,id=rng0,filename=/dev/urandom \
               -device virtio-rng-pci,rng=rng0 \
               -device virtio-serial,max_ports=2 \
               -chardev stdio,id=stdio \
               -device virtconsole,chardev=stdio \
               -chardev file,id=status,path=./result \
               -device virtserialport,chardev=status \
               -no-reboot \
               -monitor none \
               -kernel ./kernel-src/vmlinux

While this general procedure works flawlessly for intel and arm, with
mips, it just seems to hang, with no output, and I can't seem to find
which option I'm missing.

As you might have seen above, I'm mostly concerned with finding the
minimal set of options required to _generate_ a minimal full config.
However, if it's easier for you to view the whole config at once after
the merge steps above, it lives here: http://ix.io/Bud

If anybody knows what I'm missing to launch a simple malta/virtio
kernel on qemu, please do let me know.

Thanks,
Jason
