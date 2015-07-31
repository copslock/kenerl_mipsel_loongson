Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2015 20:43:10 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35125 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010750AbbGaSnIqYVOJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2015 20:43:08 +0200
Received: by wibxm9 with SMTP id xm9so45304610wib.0;
        Fri, 31 Jul 2015 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=o591DI9iP1aBtc3gdJjI/G5dorWlfE4IUxwM5z/sz3E=;
        b=I1ymGrkoe747MzqBBTl8gy5xNutWrKjacEeVvgxNH1qZQ6sbOUd31ORL/gfkjBtYye
         LskmBjmGWxzhqcwfsrSxUHn9nUA6aTsu0PfhomEI0a7PFHp3tbgX4HDuWyvx9RPg8zLN
         6eHOcERtJVnwwv2Nm7LLnuDWLrFuCtFe+OIJejih+yM3qUUWn3xH2IbffiDLGD1C6AH/
         ojIpBx+Zcm8BiS2BHbt/ZBbxunE9f+CxLSAiykbbL51DHXSu/NNzflK1bJL/TlTznmkT
         UpsDKoB/t8jFsOvX1Yv5kY3pSwc/HXaAj0PthPpTzTLWDVuhKIBL1o592KSqy4kBcJkA
         g9Ng==
X-Received: by 10.180.83.137 with SMTP id q9mr10115079wiy.68.1438368183605;
 Fri, 31 Jul 2015 11:43:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.13.67 with HTTP; Fri, 31 Jul 2015 11:42:34 -0700 (PDT)
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Fri, 31 Jul 2015 20:42:34 +0200
Message-ID: <CAD3Xx4+C1H+8AaLXbBLOKuKNysdjge0W0pxVkuLti8zE=gNdTA@mail.gmail.com>
Subject: mips: MT: ptrace.c: undefined MIPS_MT_SMTC
To:     ralf@linux-mips.org, Paul Bolle <pebolle@tiscali.nl>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

Hi Ralf,

your commit 23c59ee7e541 ("MIPS: Add uprobes support.") is in today's
linux-next tree (i.e., next-20150731) and it adds the following lines
of code to arch/mips/kernel/ptrace.c:

+#ifdef CONFIG_MIPS_MT_SMTC
+       REG_OFFSET_NAME(c0_tcstatus, cp0_tcstatus),
+#endif

The Kconfig option MIPS_MT_SMTC has been removed by commit
b633648c5ad3 ("MIPS: MT: Remove SMTC support") so that the upper
#ifdef block cannot be compiled.  Is this intentional or can the block
be removed or should the option be substituted to something else?

I detected the issue with scripts/checkkconfigsymbols.py.

Kind regards,
 Valentin
