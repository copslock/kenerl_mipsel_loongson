Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 16:52:28 +0200 (CEST)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38457 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013392AbbFAOw0uo1T4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 16:52:26 +0200
Received: by wizo1 with SMTP id o1so108508838wiz.1;
        Mon, 01 Jun 2015 07:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=0AiLAmp2cvBliMu2eL2aggGBDMrLqLeEhM98sEazggE=;
        b=aY+i8J3rpJRzNaSrqhlv7dleJSSlRGNxXkks0xEBHQkcZns4iblXDkai5J3DmoPYFm
         64cXBK7lIjX3ffq4Bzn3cf8E6xPCvAdvhNeeP9x0Ymy7oAjNvKvePFCPRWLoI/X9WPPW
         jGsMIQ6mi9Ny3RdhZrVaMRgDnbQ26gr4CRerG66c6nPqCwxDZrV10epwZPs78zjdJwMA
         WTOusN1RtK1lStktf8CkOPHJ3VxgTJpg0N73FXFBVd9rHw96rptAsZFhTgySKGKTfd+F
         TTiYR4ft0F8m/RVZveMgkmGa97AP3ua+2S/gMjo7zbtK6k4RZHiBR4FyjSIN5/rglHuw
         /94Q==
X-Received: by 10.180.97.129 with SMTP id ea1mr22195124wib.24.1433170338852;
 Mon, 01 Jun 2015 07:52:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.170.7 with HTTP; Mon, 1 Jun 2015 07:51:48 -0700 (PDT)
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Mon, 1 Jun 2015 16:51:48 +0200
Message-ID: <CAD3Xx4K_qq-FZPymp4Ss7rG2FC4iK3TF1sJnBMO+7haMFN_wFg@mail.gmail.com>
Subject: MIPS/IRQCHIP: some remainders of IRQ_CPU
To:     ralf@linux-mips.org, Paul Bolle <pebolle@tiscali.nl>,
        Andreas Ruprecht <andreas.ruprecht@fau.de>,
        hengelein Stefan <stefan.hengelein@fau.de>, tglx@linutronix.de,
        jason@lakedaemon.net, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47764
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

your commit 1f1786e60b53 ("MIPS/IRQCHIP: Move irq_chip from arch/mips
to drivers/irqchip.") is in today's linux-next tree (i.e.,
next-20150601).  It renames the Kconfig option IRQ_CPU to
IRQ_MIPS_CPU, but misses to rename a few Kconfig selects (see git
grep) in arch/mips.

If you agree, I can send a trivial patch that renames those remainders?

I detected the issue with ./scripts/checkkconfigsymbols.py by diffing
the last and today's linux tree.

Some advertisement for a small tool I started a few month a go, which
is made for such cases.  With vgrep [1] you can grep for symbols in
the current directory tree and afterwards open specific lines in your
editor.  It's more or less a comfortable wrapper around (git) grep.  I
use it a lot to study source code as well as to manage code changes.
The most prominent user I know is Greg KH who uses it as a replacement
for cgvg.

Kind regards,
 Valentin

[1] https://github.com/vrothberg/vgrep
