Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2014 21:14:22 +0100 (CET)
Received: from mail-qc0-f169.google.com ([209.85.216.169]:48704 "EHLO
        mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014126AbaKTUOVQuM5d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2014 21:14:21 +0100
Received: by mail-qc0-f169.google.com with SMTP id w7so2709473qcr.0
        for <multiple recipients>; Thu, 20 Nov 2014 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NO3MDL9NKgdi+R1Pp1ieZ1UGnNbRg2Gpw/aPUMIa0kE=;
        b=o1eP9g7c9Jnvnc5OJ1FfrmUmrV40foFKNU6wKU3+oundlVT3inKsL1bEyQV0KXHSTI
         MMLvIy+QZNa7BIv5s+liEF+l6ckNMKkrWpWhaALCmGi8rX0HeOgArNbgf7xq4sbjnX4E
         lwF5YC8HCrxeCpTU6iQEJyB64agzGaBBwWVhsBgtMcFlJh/FGkSYsRxlv7Rm9Ds2tIo9
         jJvIQiZ4GcHT6uS2tIE6uSNtMMMGoRhw0C6uKZ6vVbNU2cjukfOGkuxvLDD31LDzRgEv
         WCJWZzqIm01v+jyumOGPB685WSHrNtCem/mn/HcCJdH4ulVetS/dAOtX/WhPygElIhgW
         0t4w==
X-Received: by 10.224.74.135 with SMTP id u7mr197630qaj.67.1416514455379; Thu,
 20 Nov 2014 12:14:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Thu, 20 Nov 2014 12:13:55 -0800 (PST)
In-Reply-To: <546E2E3E.5040305@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
 <20141120030434.GE24364@ld-irv-0074> <CAJiQ=7C8h-MAuRdgzZqx2=bg8bvy7v9pv7e7tGXWmA9ghYJiqQ@mail.gmail.com>
 <546E2E3E.5040305@gmail.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Thu, 20 Nov 2014 12:13:55 -0800
Message-ID: <CAJiQ=7CbOtejxhcoTiJ2VOyM9CJNCdWAw7Cv5HTzwGa1VmO5Xg@mail.gmail.com>
Subject: Re: [PATCH V2 00/22] Multiplatform BMIPS kernel
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jon Fraser <jfraser@broadcom.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44325
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

On Thu, Nov 20, 2014 at 10:09 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Slightly unrelated, did you also try to use drivers/bus/brcmstb_gisb.c
> on these MIPS platforms?
>
> Its usefulness is probably lower on MIPS since we typically get accurate
> bus errors to be decoded by the CPU and printed through the exception
> handler, but I'd be curious if it works just fine as well.

Unfortunately ERR_CAP_CLR (the first register) starts at offset 0x7e4
on 28nm, and offset 0x0c8 on 40nm/65nm.

Just for fun I tried setting the base address to (0x104000c8 - 0x7e4)
= 0x103ff8e4 on 7420, and then noticed that the CAP_HI_ADDR register
only exists on the new chips with 40-bit addressing.  This prevents
the driver from reading the valid bit from the correct location, so
the error handler exits prematurely.  After manually hacking the code
to renumber the registers, it worked again:

# devmem 0x103ffffc
Data bus error, epc == 0040a21c, ra == 0040a1a0
brcmstb_gisb_arb_decode_addr: timeout at 0x103ffffc [R timeout], core: cpu_0
Bus error
# devmem 0x103ffffc 32 0x5678
brcmstb_gisb_arb_decode_addr: timeout at 0x103ffffc [W timeout], core: cpu_0
#

Last night I fixed up the brcmstb reset driver to work with the old
chips.  I'm wondering if it makes sense to just split this work into a
new patch series, since several of the BCM7xxx ARM drivers will need
changes (both code and DT) to run on MIPS.
