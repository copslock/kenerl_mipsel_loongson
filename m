Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 13:19:03 +0200 (CEST)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47408 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007009AbaH0LTCq7FL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 13:19:02 +0200
Received: by mail-ie0-f179.google.com with SMTP id rl12so54064iec.24
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 04:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=vDsfUaiE3cgV8o6gI1y5KW2sLfmEYD1Z6mnYDHe0Pso=;
        b=Wvi5GVPA0mjxLQvZ5vZEZatYW+lvJfg5cNrsQd+CKcFdwUclLeUSbOqfg/RPTuHJO/
         vHujfZeCbjGJlm2ar1sCEgjlEQsJybJfsvPQGRhCRsR+N1AgH5iY0Jt/K9c304MZ3nKv
         YIW/csdtfrdXQdjfkDdsMBTelDEa8RN+UvKjYWOmNSNBA1aZpsoXL/OoMSUb6nwReOHr
         cJDhEBJiK7VxJkEXb7P/VlvMsuZ9x/cwew6Zjy19Wbb/5VAoDAtF7ejsR8WBOd7nPSsU
         EH+Tn/0uzBCYImHdbsV3mVFy3eldcRpeWGyR3KVjZl2+YH+nwSJq3TLK4yakj/Ecq5bi
         UhZg==
MIME-Version: 1.0
X-Received: by 10.42.26.74 with SMTP id e10mr34300106icc.25.1409138336582;
 Wed, 27 Aug 2014 04:18:56 -0700 (PDT)
Received: by 10.50.135.73 with HTTP; Wed, 27 Aug 2014 04:18:56 -0700 (PDT)
Date:   Wed, 27 Aug 2014 12:18:56 +0100
Message-ID: <CAPweEDznk3iecHkQcaGMd_EZfzZmbAbtXuO9dnePctDxFSWS7Q@mail.gmail.com>
Subject: rhombus tech eoma68 ingenic jz4775 cpu card
From:   "lkcl ." <luke.leighton@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 42278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luke.leighton@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

hi all,

i'm a long-standing software libre advocate and developer and i tend
to tackle the areas where free software doesn't have someone already
working on it.  that has taken me into hardware design, so i'd like to
let people here know that i have designed a hardware standard (eoma68)
and have been working with ingenic to create a CPU card using the
ingenic JZ4775. info on the standard is here:
http://elinux.org/Embedded_Open_Modular_Architecture/EOMA-68#Table_of_EOMA-68_pinouts

the PCB designs are done and will be sent off to be prototyped (qty 5
are planned at the moment) at the beginning of next month (september).
it will be the very first CPU card that could go into FSF-Endorseable
products and be reasonably popular, as Ingenic have, bless 'em, even
released the full source code of the VPU drivers.  no, not "a .a or
.so with some header files", *actual* full source.  also as people
familiar with Ingenic X-Burst will know, although it is a bit
challenging the 3D libraries are also fully software libre.

very very early Ingenic SoCs (JZ4740) only used X-Burst: ingenic then
unfortunately licensed proprietary 2D/3D/VPU hard macros for a while
but the JZ4775 is the first 1ghz (i.e. modern-ish) SoC that can
address 3Gb (i.e. modern-ish) DDR3 RAM and *doesn't* include
proprietary drivers.

so! :)

if anyone would like to get involved, just let me know, i will be
happy to answer.  just so you know, i am subscribed (digest) to
linux-mips.

l.
