Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 21:10:40 +0200 (CEST)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:33943
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993870AbdFFTKdv3YmB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 21:10:33 +0200
Received: by mail-pg0-x244.google.com with SMTP id v14so10146935pgn.1
        for <linux-mips@linux-mips.org>; Tue, 06 Jun 2017 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:to:to:to:to:to:to:to:to:to:to:to:to:subject:date:message-id
         :in-reply-to:references;
        bh=ctAfdg+bGaMgn0lL5xoMqwVJY/9pfQq5VPnl+8WVldc=;
        b=neTpalQgGA8e4uyKecpIyUAK/r42RsvDMrCGWlIOLej+mpBV/ipO2umTU01bpg3WNr
         9PLeVlPJHqvEbPPWTwhrXtGKPpeIzbP6PV3Bb/Z5/uHJi7C7jLMZ3eoV9v+Jt3WjjHTH
         xXxz9r77KXVHDqHzc9BYoXt0aE9YUJS1xIDU8fQeBY9ZxctaBoY5MSByDvS1gDj73DTf
         hd1OhlnOtsXdREAWpA9nyrjAiKrCaX3iW7dNytiPHXp/2GnKTkAVjlFoAP0mj5hCWrcm
         qUarHKnu8L8p+LAeT5b5Jny2NBlk3T2puYSjRg3Y9EYCHD7lQL41lnjiLwNplFNOuSet
         Vrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:to:to:to:to:to:to:to:to:to:to:to:to
         :subject:date:message-id:in-reply-to:references;
        bh=ctAfdg+bGaMgn0lL5xoMqwVJY/9pfQq5VPnl+8WVldc=;
        b=bQRkjedG/IGtEpYeHJ97/NuRC9eXBK79MvhshriLWLlLXDR4yYsrUdapsKny7bXgRC
         q7hiEwKsPooY5HuQrki7LrsVVeF7HHTl5at2RUMkw6dnmfDiUS8HwrxJ7sPKTiz9T2rY
         Ncm7hIbVGTr1zvySpec79N3GNicMMWEnnUFxgpT86YQYvzW8Bj9boODdNKy/8f121fJi
         GwgEffmPxlScUwxZGrQPCfp2Phn4aFELSo7bGxz1KoDe9grayBlpSOYSoyVWLVznT/zo
         CzKjzH73vC8Zbax1T5ooF/MsU8Nj+7LjVVXPb5v5HC+/RjwiD7zSOOKtKEZu+41sHKGs
         TSSg==
X-Gm-Message-State: AODbwcBT6ueDjrE/K6UT1makAuuqPYwXStCYfJ/joA7nwuALjqf5qhzr
        wypPHiWkFPxat6G2
X-Received: by 10.84.132.2 with SMTP id 2mr22847980ple.46.1496776227812;
        Tue, 06 Jun 2017 12:10:27 -0700 (PDT)
Received: from localhost ([216.38.154.21])
        by smtp.gmail.com with ESMTPSA id i190sm9413269pfc.69.2017.06.06.12.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 12:10:27 -0700 (PDT)
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
Subject: Unify the various copies of libgcc into lib v2
Date:   Tue,  6 Jun 2017 12:10:16 -0700
Message-Id: <20170606191023.24581-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523220546.16758-1-palmer@dabbelt.com>
References: <20170523220546.16758-1-palmer@dabbelt.com>
Return-Path: <palmer@dabbelt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58261
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

Thanks to everyone who responded to my original patch set.  I believe I've
responded to everyone's comments.  There have been a handful of changes since
the original patch set:

 * The Kconfig names for the routines are now GENERIC_* instead of LIB_*.  This
   matches the existing generic implementation Kconfig names.
 * Tracing is disabled, which matches the MIPS behavior and seems correct
   globally.
 * I've cross compiled this to make sure it builds, and fixed all the build
   errors I found.
 * The MIPS patches actually do what they say in the commit message.

I don't know of any remaining problems with this patch set, so hopefully it's
ready to get merged.  I'll be including patch 1 in our RISC-V submissions, but
as I'm somewhat new to this I don't have a tree that anyone pulls from yet.

If everyone is happy with this patch set then I'd be willing to use this as a
first attempt to get patches upstream myself.

[PATCH 1/7] lib: Add shared copies of some GCC library routines
[PATCH 2/7] m32r: Use lib/ucmpdi2.c
[PATCH 3/7] microblaze: Use libgcc files from lib/
[PATCH 4/7] score: Use lib/{ashldi3,ashrdi3,cmpdi2,lshrdi3,ucmpdi2}.c
[PATCH 5/7] sh: Use lib/ashldi3,ashrdi3,lshrdi3}.c
[PATCH 6/7] sparc: Use lib/{cmpdi2,ucmpdi2}.c
[PATCH 7/7] MIPS: Use generic libgcc intrinsics
