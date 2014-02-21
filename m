Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Feb 2014 00:47:29 +0100 (CET)
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64042 "EHLO
        mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816887AbaBUXr1LKfrf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 22 Feb 2014 00:47:27 +0100
Received: by mail-ob0-f174.google.com with SMTP id uy5so5160758obc.33
        for <multiple recipients>; Fri, 21 Feb 2014 15:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2Wo0wTsoaL3LgAKG4dl93p3sGDXyU47ZHqMbWbLh2wE=;
        b=Gvmf5BuKc+jxeioI2BszJO6G6kNqQ573mEHIEgTTMBkGrhKxsb6FzT/AHVScffd5QW
         ySAHtIxX6wgNnltpo2Y6OiR53aLK+cEVT7hw28fHzVVLjNvqD6QX1fgOaJ6+gBR3XiZL
         cvTD88+/8Xkk9o/TB0uMR2MfSXovbhg2nndmqyvdaqBzPR+ux066+N2YE4F5FMkN8QKD
         vjNc0CBA1yMBmJzlqg4FQJIumeLW+yGANa+Ce60EJNBaIPAcqUKrDtxYucWS30sljak1
         ijBd4dVwbKI3JIfJyywb2AlT3b+vjOzuSwjWodH9Mpv8LDOIVRXTi3QIEi4UK59VYy2/
         MwSg==
MIME-Version: 1.0
X-Received: by 10.182.40.201 with SMTP id z9mr8389275obk.45.1393026440708;
 Fri, 21 Feb 2014 15:47:20 -0800 (PST)
Received: by 10.76.172.65 with HTTP; Fri, 21 Feb 2014 15:47:20 -0800 (PST)
Date:   Fri, 21 Feb 2014 20:47:20 -0300
Message-ID: <CAEZm4MLr-Eic7uaiDd+KdbJsFsqrSd5AkKX7HHoSQUQ0AyRxyw@mail.gmail.com>
Subject: [BUG] Build error due -fstack-protector-strong not supported by compiler
From:   Juan Emilio Ledesma Torres <jueleto@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        "Cc: Arjan van de Ven" <arjan@linux.intel.com>,
        "Cc: Michal Marek" <mmarek@suse.cz>,
        "Cc: Russell King" <linux@arm.linux.org.uk>,
        "Cc: Ralf Baechle" <ralf@linux-mips.org>,
        "Cc: Paul Mundt" <lethal@linux-sh.org>,
        "Cc: James Hogan" <james.hogan@imgtec.com>,
        "Cc: Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Cc: Shawn Guo" <shawn.guo@linaro.org>,
        "Cc: Linus Torvalds" <torvalds@linux-foundation.org>,
        "Cc: Andrew Morton" <akpm@linux-foundation.org>,
        "Cc: Peter Zijlstra" <peterz@infradead.org>,
        "Cc: Thomas Gleixner" <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <jueleto@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jueleto@gmail.com
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

Hello,

When building latest Torvalds tree (HEAD d158fc7f) on a x86_64 machine
using the attached defconfig I got the following build error:

/home/pc12/linux/arch/x86/Makefile:118: stack-protector enabled but
compiler support broken
Makefile:614: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG:
-fstack-protector-strong not supported by compiler

Makefile:614: Cannot use CONFIG_CC_STACKPROTECTOR_STRONG:
-fstack-protector-strong not supported by compiler
make[1]: No se hace nada para <<all>>.
make[1]: No se hace nada para <<relocs>>.
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CC      kernel/bounds.s
cc1: error: the command line option is not recognized '-fstack-protector-strong'
make[1]: *** [kernel/bounds.s] Error 1
make: *** [prepare0] Error 2

I had already reported the bug on bugzilla [0] but I'm also reporting
here for completeness.

Bisecting this break was introduced on commit 19952a92
("stackprotector: Unify the HAVE_CC_STACKPROTECTOR logic between
architectures")

I don't know if this problem is with the above commit or with my
compiler (gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3)

[0]: https://bugzilla.kernel.org/show_bug.cgi?id=70951

-- 

Best regards,
Juan Ledesma
