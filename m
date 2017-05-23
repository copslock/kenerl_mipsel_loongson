Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 00:06:54 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:34072
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994941AbdEWWGpdZ8Hc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 00:06:45 +0200
Received: by mail-pf0-x241.google.com with SMTP id w69so30199027pfk.1
        for <linux-mips@linux-mips.org>; Tue, 23 May 2017 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:subject:date:message-id;
        bh=ZlFBZj+dJjykWimNWNTEnjzEwG06Sgapvoo5SCMdmQQ=;
        b=vZOBq6oDFlUZS/FGnw6TLmBcA2N9Cbas6EdRyEBjxbFgoVn9OT5UQ51k3pKIhE2rGv
         3xsb/K8oB4GgGHMdrAuOJz2oqDYRBrlSS75fwdi9o5NVI61anN0XbAr7egMxPc62z2ta
         cIIrhoFdTnCeTLnDbRwe23zl2WdCM733iYZ6HG7Bw6R8b8k7xLUalcaoNyOaqVyrdhMw
         bKBxPJabKEYV61sGzwwsYU+ARgznKnOSrXJFLDO8Zii+rcwlUe+m/SxoToGK8RwoXAW1
         gmNJ+dozHKhUlt8a1e3sMZTaVWVgfis7Gn2Z6s6h1TR77NeWVqUsybAhumqibVOvIv7a
         CWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to
         :subject:date:message-id;
        bh=ZlFBZj+dJjykWimNWNTEnjzEwG06Sgapvoo5SCMdmQQ=;
        b=sam3IdKrxRmKSEXMqdbdPr2NAqkD9pAiIslnItmhvjxAqLPIiVz96dBuz8dDBWPAmb
         EXjzdzPK/y6jebAfBACdbJffnBuPnorRzFphtjL35DAA/Rcg6SWgWeXX+n/8vxc8a3Ud
         /+5p5q3DPvtw7xSyushcFo8+aLYsdrkvQgawwbTJ7Mqp8i8r7ttXTDUPt3UXADM3cnU2
         bveC52opUdUFpclA48U8i8bdIbZblzozPwAZHPwu5wseLMnD1adHxuSxr7nnhZd/hJXD
         eRCRsVCctBMXMGdEKrNChAQzoffeCboz5lWeNVftVdOWFhREgMjVuIlSq4ftp+GDb3Sv
         MuNQ==
X-Gm-Message-State: AODbwcAneGGlT1XLlQz33hdWn+iJ06uo7Ln71xdyIWtP9DRjlS83WPaG
        BQTqee8ccDQvBLsg
X-Received: by 10.98.139.21 with SMTP id j21mr34490340pfe.5.1495577199558;
        Tue, 23 May 2017 15:06:39 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id g75sm3571995pfd.83.2017.05.23.15.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 15:06:38 -0700 (PDT)
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     monstr@monstr.eu
To:     ralf@linux-mips.org
To:     liqin.linux@gmail.com
To:     lennox.wu@gmail.com
To:     ysato@users.sourceforge.jp
To:     dalias@libc.org
To:     davem@davemloft.net
To:     linux-mips@linux-mips.org
To:     linux-sh@vger.kernel.org
To:     sparclinux@vger.kernel.org
To:     geert@linux-m68k.org
To:     linux-kernel@vger.kernel.org
To:     linux-arch@vger.kernel.org
Subject: Unify the various copies of libgcc into lib
Date:   Tue, 23 May 2017 15:05:39 -0700
Message-Id: <20170523220546.16758-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@dabbelt.com
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

I'm in the process of submitting the RISC-V Linux port, and someone noticed
that we were adding copies of some libgcc emulation routines that were the same
as some of the other ports.  This prompted me to go through and check all the
ports for libgcc.h and to merge the versions that were functionally identical.

The only difference in libgcc.h was that there was a #define for little vs big
endian.  The differences in the emulation routines were all just whitespace.

This patch set comes in two parts:

 * Patch 1 adds new copies of all the C files copied from libgcc, as well as
   moving libgcc.h to include/lib (that's a new folder, which probably means
   it's the wrong place to put it, but I couldn't find anything better).  There
   are Kconfig entries for each of these library functions so architectures can
   select them one at a time.

 * The rest of the patches convert each architecture over to the new system.

Unless I screwed something up, this patch set shouldn't actually change any
functionality.  Unfortunately I don't actually have all these cross compilers
setup so I can't actually test any of this, but I did convert the RISC-V port
over to using this system and it appears to be OK there so at least this isn't
completely broken.
