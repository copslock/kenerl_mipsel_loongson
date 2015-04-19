Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 13:20:18 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:5679 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007043AbbDSLUQ5ndA1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 13:20:16 +0200
Received: from tock (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8CF6B9400AA;
        Sun, 19 Apr 2015 13:17:55 +0200 (CEST)
Date:   Sun, 19 Apr 2015 13:20:07 +0200
From:   Alban <albeu@free.fr>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Aban Bedel <albeu@free.fr>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] MIPS: ath79: Fix the PCI memory size and offset of
 window 7
Message-ID: <20150419132007.06e22199@tock>
In-Reply-To: <CAOiHx=kJD4s4FZ61iKqReE1BkqeoHuo4pET1CFygE1izQZAW4w@mail.gmail.com>
References: <1429274178-4337-1-git-send-email-albeu@free.fr>
        <1429274178-4337-5-git-send-email-albeu@free.fr>
        <CAOiHx=kJD4s4FZ61iKqReE1BkqeoHuo4pET1CFygE1izQZAW4w@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sun, 19 Apr 2015 00:28:39 +0200
Jonas Gorski <jogo@openwrt.org> wrote:

> Hi,
> 
> On Fri, Apr 17, 2015 at 2:36 PM, Alban Bedel <albeu@free.fr> wrote:
> > The define AR71XX_PCI_MEM_SIZE miss one window, there is 7 windows,
> > not 6. To make things clearer, and allow simpler code, derive
> > AR71XX_PCI_MEM_SIZE from the newly introduced AR71XX_PCI_WIN_COUNT
> > and AR71XX_PCI_WIN_SIZE.
> >
> > The define AR71XX_PCI_WIN7_OFFS also add a typo, fix it.
> 
> I think this will break PCI on ar71xx.
> 
> >
> > Signed-off-by: Alban Bedel <albeu@free.fr>
> > ---
> >  arch/mips/include/asm/mach-ath79/ar71xx_regs.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
> > b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h index
> > aa3800c..e2669a8 100644 ---
> > a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h +++
> > b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h @@ -41,7 +41,9 @@
> >  #define AR71XX_RESET_SIZE      0x100
> >
> >  #define AR71XX_PCI_MEM_BASE    0x10000000
> > -#define AR71XX_PCI_MEM_SIZE    0x07000000
> > +#define AR71XX_PCI_WIN_COUNT   8
> > +#define AR71XX_PCI_WIN_SIZE    0x01000000
> > +#define AR71XX_PCI_MEM_SIZE    (AR71XX_PCI_WIN_COUNT *
> > AR71XX_PCI_WIN_SIZE)
> >
> >  #define AR71XX_PCI_WIN0_OFFS   0x10000000
> >  #define AR71XX_PCI_WIN1_OFFS   0x11000000
> > @@ -50,7 +52,7 @@
> >  #define AR71XX_PCI_WIN4_OFFS   0x14000000
> >  #define AR71XX_PCI_WIN5_OFFS   0x15000000
> >  #define AR71XX_PCI_WIN6_OFFS   0x16000000
> > -#define AR71XX_PCI_WIN7_OFFS   0x07000000
> > +#define AR71XX_PCI_WIN7_OFFS   0x17000000
> 
> These values are used in exactly one place, for writing into the PCI
> address space offset registers.
> The 7th PCI window is a special one for accessing the configuration
> space registers, which requires to be set to 0x07000000 for that
> purpose. So by changing this value you likely break access to these
> values.

Sorry, I foolishly assumed it was a typo.

> >
> >  #define AR71XX_PCI_CFG_BASE    \
> >         (AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)
> 
> Also this macro would now be wrong, and calculate a wrong address.

I see, I'll drop this patch and rework the following one to match the
old code.

Alban
