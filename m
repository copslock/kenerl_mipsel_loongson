Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2014 18:39:54 +0100 (CET)
Received: from mail-qc0-f182.google.com ([209.85.216.182]:52231 "EHLO
        mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007824AbaLARjwcQBL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Dec 2014 18:39:52 +0100
Received: by mail-qc0-f182.google.com with SMTP id r5so8162538qcx.27
        for <multiple recipients>; Mon, 01 Dec 2014 09:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NgJwydUS4hzyUYBP9YR+wz74oPsr1J7O1qdWyOgYr4A=;
        b=olNL7bLH88p/qruNxrJ2rzwsKuifHKcU3zgrZcJdtj7MZFqp9uudA0hzBU4trcWpAH
         CXqT6JZAXcCdaP8+KYA+DxQw30brwTgGVQYtjGdgL1ncF0ZDvTsa0V38iAvXLBPYpdCh
         1CS+gLdXxywIm69mTZBcJzV7as/ixP+iLcCbMqizrjFSzSNadE+fwOh4D3/FMsfU+5Ke
         SVti4YpD7YJ86YlcQfMbmAx7+V1nAig9RDZeN8qkbRWLjqnYdQ3n7p4gK8R5NBeRlq3t
         Sh/AFGqyVraAhqE6PwPenisKI/0ojbxltVtljtMnflYwPVbSkW1yVP2P4rj7nFa+qTeW
         pW9A==
X-Received: by 10.224.36.14 with SMTP id r14mr29722929qad.39.1417455586956;
 Mon, 01 Dec 2014 09:39:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.82.48 with HTTP; Mon, 1 Dec 2014 09:39:26 -0800 (PST)
In-Reply-To: <CAOiHx=nb4Ub_bseHUrz+HrnJxDEKMijQ=r+ASZ-p5MtTi81Big@mail.gmail.com>
References: <1417149142-3756-1-git-send-email-cernekee@gmail.com>
 <1417149142-3756-9-git-send-email-cernekee@gmail.com> <CAOiHx=nb4Ub_bseHUrz+HrnJxDEKMijQ=r+ASZ-p5MtTi81Big@mail.gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 1 Dec 2014 09:39:26 -0800
Message-ID: <CAJiQ=7D631F1wkegeKup7yeB-wgjKLjvD3V1-n8fu3aW=fOm0g@mail.gmail.com>
Subject: Re: [PATCH V4 08/16] irqchip: Add new driver for BCM7038-style level
 1 interrupt controllers
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Norris <computersforpeace@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Dec 1, 2014 at 8:09 AM, Jonas Gorski <jogo@openwrt.org> wrote:
> I'm not that firm in interrupt controller terminology, but can this be
> a level 1 interrupt controller if it has a parent interrupt
> controller? Isn't the parent the level 1 interrupt controller? Or
> would the parent then be a level 0 interrupt controller? ;-)

According to the register manual, this is an L1 controller and the
"IRQ0" controller handled by irq-bcm7120-l2.c is an L2 controller.

This terminology is used consistently across the MIPS and ARM STB
chips, but it is worth noting that MIPS has a builtin "L0 controller"
(not a published term) to demux the 5 HW IRQ lines, while ARM only
uses a single IRQ input for peripherals.  On STB MIPS platforms it is
typical to only use one HW IRQ input per CPU (TP).

Also note that brcm,bcm3384-l2-intc can either be used for an L1
(PERIPH INT block) or an L2/L3 (ZMIPS/CMIPS/IOP).
