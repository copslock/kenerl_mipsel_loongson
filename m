Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2012 12:12:20 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:37593 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823645Ab2J2LMTGD6g6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2012 12:12:19 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1645204bkw.36
        for <multiple recipients>; Mon, 29 Oct 2012 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=6p5g2lE88LttlyRrHddxmCPm8xrf4NInDWwpXDau2bw=;
        b=ujxyr8CypMpVEnoLkVs2aW6vauqf7T+U2vG2n0Z55eJFq0jAYFTPW6SnqSpv3tfZD3
         v9LgIixuws6wNoKP5YUr2YCXb3/zGhSRWCb/Tfx2F7yHkkAlEnhVZ+9YJNay0vSxPRxL
         AImtvKZM4XqDILXMKyVhdTdIIeXIW2zan66g1V1cCmPyTt8/ea5lk1e9MMQfPlUAK/vS
         IbGTF2mnsgV2OXt1IbF/iup/cQzdXVm8NY+cUx/+4+Pv78o60TpNXOzoEKWZoOyrbTyi
         A4Baw7GyHAJjnD+0seEzPtcrdJxOdhYLe2fRHvZ5lyFRgCe1IYNInAmd0PTFiEp3/XLO
         UVPg==
Received: by 10.205.127.146 with SMTP id ha18mr9306257bkc.130.1351509133655;
        Mon, 29 Oct 2012 04:12:13 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id fm5sm3626961bkc.5.2012.10.29.04.12.12
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 04:12:13 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM63XX: add softreset register description for BCM6358
Date:   Mon, 29 Oct 2012 12:10:49 +0100
Message-ID: <90103311.eQkKdLBACa@flexo>
Organization: OpenWrt
User-Agent: KMail/4.9.2 (Linux/3.5.0-17-generic; KDE/4.9.2; x86_64; ; )
In-Reply-To: <508E60DB.6050005@mvista.com>
References: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com> <1351430275-14509-2-git-send-email-jonas.gorski@gmail.com> <508E60DB.6050005@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On Monday 29 October 2012 14:56:27 Sergei Shtylyov wrote:
> Hello.
> 
> On 28-10-2012 17:17, Jonas Gorski wrote:
> 
> > The softreset register description for BCM6358 was missing, so add it.
> 
> > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> > ---
> >   arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   10 ++++++++++
> >   1 files changed, 10 insertions(+), 0 deletions(-)
> 
> > diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> > index 12963d0..e84e602 100644
> > --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> > +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> [...]
> > @@ -244,6 +245,15 @@
> >   				  SOFTRESET_6348_ACLC_MASK |		\
> >   				  SOFTRESET_6348_ADSLMIPSPLL_MASK)
> >
> > +#define SOFTRESET_6358_SPI_MASK		(1 << 0)
> > +#define SOFTRESET_6358_ENET_MASK	(1 << 2)
> > +#define SOFTRESET_6358_MPI_MASK		(1 << 3)
> > +#define SOFTRESET_6358_EPHY_MASK	(1 << 6)
> > +#define SOFTRESET_6358_SAR_MASK		(1 << 7)
> > +#define SOFTRESET_6358_USBH_MASK	(1 << 12)
> > +#define SOFTRESET_6358_PCM_MASK		(1 << 13)
> > +#define SOFTRESET_6358_ADSL_MASK	(1 << 14)
> > +
> 
>     Why not use BIT(n) instead of (1 << n)?

All other bcm63xx headers consistently use (1 << n), I would rather we keep
this convention.
--
Florian
