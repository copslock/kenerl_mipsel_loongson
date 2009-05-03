Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 May 2009 09:20:04 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.146]:19235 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023941AbZECIT5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 3 May 2009 09:19:57 +0100
Received: by ey-out-1920.google.com with SMTP id 13so703524eye.54
        for <linux-mips@linux-mips.org>; Sun, 03 May 2009 01:19:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=VEHYLE1/JNSkUoibEt/tDpFHXIP1sBdkJ6L/OYF1g4g=;
        b=rBLtnxJvev6MuUuBM8VV8/2DLozlhruxPQWZ7c1qYYif+pnj9paIEUPlx3ElhDFDE9
         6w2nK9qka4WzGAUAvOwBCI0I/yiQlNJjRIMkFJg+c8jxia759loH3uCpbt98olSwn6TX
         +KBeVueXzk3/oy2G6C7Bm3aDou0fOhBd2UsG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=IU79kxy8AuXZpNbiCn15k5V3NtC+pgUcjkClaPGl6dXhg9A/2N6LJk9KGzA9wq6l0k
         w/97Ba/zxjZsQmKdg+l9ezdMab6r3fnIrHAk9qBrqwRF24k1AnnQdrzss7/G9cHmaPLi
         gQpciHBCriqJYOhv+fhKH6TynGUKJ+cv9VvhM=
MIME-Version: 1.0
Received: by 10.210.17.2 with SMTP id 2mr4719938ebq.85.1241338796043; Sun, 03 
	May 2009 01:19:56 -0700 (PDT)
In-Reply-To: <200904302141.53025.florian@openwrt.org>
References: <200904302141.53025.florian@openwrt.org>
Date:	Sun, 3 May 2009 10:19:56 +0200
X-Google-Sender-Auth: 3d1e795dfca5b56d
Message-ID: <10f740e80905030119u6f196b6bqe63003d502f9f731@mail.gmail.com>
Subject: Re: initramfs breakage with 64-bits kernels?
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 30, 2009 at 21:41, Florian Fainelli <florian@openwrt.org> wrote:
> I have been trying to get a 2.6.29 64-bits kernel for Cavium Octeon to work
> with a 32-bits userland in an initramfs. While booting, the kernel does not
> find the initramfs due to the check against initrd_start in populate_rootfs
> (init/initramfs.c) failing.

You mean the test for initrd_start being non-zero? Is your initramfs really at
address zero?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
