Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 14:38:17 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:37266 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492587AbZJ0NiK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 14:38:10 +0100
Received: by pwi11 with SMTP id 11so76055pwi.24
        for <multiple recipients>; Tue, 27 Oct 2009 06:38:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=pAgcs9wIXFHjDjXIFPKYIjOgnaxIVcnRqqmrKi3o4/s=;
        b=cxYIYCP/wZJt0TDbS7xfanYlP0qCRuMuNf4oz+HfP2zLufeyAlro0xczzgWYIyIBrr
         irAdUr3HXIDeMa8Pccqx/vjG3npydecJqiv20j+77bhkIq3lvN55S1uj5MrXHCPWTOfE
         /dGHO3ofdDI6zScvg8d6aydU2uFjTInkl1Pw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=u2E84pW2+WXPlgF/zecPkHEWkqgow5Qbkf1VgakZcRjsS5uJMP/dr+yelm2tvqY0vS
         jf1vaz+GdS3zz3Ia1in7Fg6uHyXvlEYri2FGu8Jt5MZK+ED6rDxTs/SMCX9NTe0o0gkc
         Gig9nfDhKr0cIgtntfh+jUp5XbGOyIabFtirE=
Received: by 10.115.133.38 with SMTP id k38mr3478589wan.120.1256650682794;
        Tue, 27 Oct 2009 06:38:02 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm165784pzk.1.2009.10.27.06.37.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 06:38:01 -0700 (PDT)
Subject: mipsel-linux-gnu-gcc: -pg and -fomit-frame-pointer are incompatible
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Steven Rostedt <rostedt@goodmis.org>, rdsandiford@googlemail.com
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 27 Oct 2009 21:32:30 +0800
Message-Id: <1256650350.5499.117.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, all

FUNCTION_TRACER have selected FRAME_POINTER by default to avoid the
following "weird" error when using -pg and -fomit-frame-pointer
together:

"-pg and -fomit-frame-pointer are incompatible"

kernel/trace/Kconfig:

config FUNCTION_TRACER
        bool "Kernel Function Tracer"
        depends on HAVE_FUNCTION_TRACER
        select FRAME_POINTER

and here is what FRAME_POINTER does in (linux)/Makefile:

ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS   += -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
KBUILD_CFLAGS   += -fomit-frame-pointer
endif

but in reality, from the manual of gcc:

"Don’t keep the frame pointer in a register for functions that don’t
need one.  This avoids the instructions to save, set up and restore
frame pointers; it also makes an extra register available in many
functions.  It also makes debugging impossible on some machines.

On some machines, such as the VAX, this flag has no effect, because the
standard calling sequence automatically handles the frame pointer and
nothing is saved by pretending it doesn’t exist.  The
machine-description macro "FRAME_POINTER_REQUIRED" controls whether a
target machine supports this flag.

Enabled at levels -O, -O2, -O3, -Os."

-fomit-frame-pointer will be enabled by default for -O2, and If I
disable -fno-omit-frame-pointer, it will really not keep the frame
pointer in a register:

ffffffff80200400 <do_one_initcall>:
ffffffff80200400:       67bdffd0        daddiu  sp,sp,-48
ffffffff80200404:       ffbf0028        sd      ra,40(sp)
ffffffff80200408:       ffb40020        sd      s4,32(sp)
ffffffff8020040c:       ffb30018        sd      s3,24(sp)
ffffffff80200410:       ffb20010        sd      s2,16(sp)
ffffffff80200414:       ffb10008        sd      s1,8(sp)
ffffffff80200418:       ffb00000        sd      s0,0(sp)
ffffffff8020041c:       3c038021        lui     v1,0x8021
ffffffff80200420:       64630fb0        daddiu  v1,v1,4016  <> with -pg
ffffffff80200424:       03e0082d        move    at,ra
ffffffff80200428:       0060f809        jalr    v1
ffffffff8020042c:       00020021        nop
[...]
ffffffff80205b18 <au1k_wait>:
ffffffff80205b18:       3c038021        lui     v1,0x8021
ffffffff80205b1c:       64630fb0        daddiu  v1,v1,4016
ffffffff80205b20:       03e0082d        move    at,ra
ffffffff80205b24:       0060f809        jalr    v1
ffffffff80205b28:       00020021        nop

And without -fno-omit-frame-pointer option, ftrace for MIPS also works
normally and can save some overhead for us!

But perhaps some archs need the frame pointer, so, remove the
-fno-omit-frame-pointer from (linux)/Makefile, and add it into the arch
specific Makefile?

Besides, should we clear the "weird" error in gcc when using -pg and
-fomit-frame-pinter together?

Thanks & Regards,
	Wu Zhangjin
