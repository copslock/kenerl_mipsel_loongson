Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 13:37:21 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.13]:64419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029292AbcELLhUGsbQn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 13:37:20 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue102) with ESMTPSA (Nemesis) id 0M6UrD-1bqJkA473b-00yRCp; Thu, 12 May
 2016 13:36:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Felipe Balbi <balbi@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Thu, 12 May 2016 13:36:40 +0200
Message-ID: <2809110.sWekaCNVxS@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <8760ujecw2.fsf@linux.intel.com>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de> <8760ujecw2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:eKp/mMv1tHT7UONgrtYMWvtz0QRiZdajb3/mcUxpTo+6r+mEHJG
 TtHXvl4mSn1AL8o8ZyWM1artZtE9LPSEc9dMQ4i1aWYN5AC+1gJ72rIZZOLDGj2xGeILEes
 lTi4sgc2GPU4Rr2d0ITFgtDygOzMfZxAU++sbPSe9ged1F7DZ5s/UvBb422wzDSw4hXadEz
 N+sLzN/Ti4LxCy6iMq9IQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3O3KozLD1yg=:axGnFUxLIHPNX4FswgLgkH
 UHI3ixBWI4kyJWskXsxyB6fkYqM7SXY4GI+69rZbftktib76d5GUlPzHTeRpg9/AfuSx8fyeB
 D35X5YU1ict1ns8IOLyAYdjGQwNuzbmU4tNT2y+YfKywFrTbmfzVJ5s7bjrNWKB0/U1TkVliQ
 SPgXiCM8Bdxun/yA15Rs2e67mTcU+YaEbZeraOi/DOh6FE4YDjAyBBOQrrnCJ/+sfwLlVnKkD
 BRgcFf/cH2t4PenW0/Ywv4smt8Yzl0aA29Kttk/otal4deJJmacG9RqkPi8JThJ3K5ljehUmw
 wWJ0Za9gpcg0znp/spucPCZtfxyAVyCgJzQcgUJ5vOVSv6cOioZQ1vuF050u3/H1Wl+eSaaZK
 hJB/qZQNcO+LGREcNt6Vw3/Zs8DVSQTxuXd8qi8hGyZ3bw3NrGoztNPamWRZsCtw3cJW5Nuuh
 GgDhAKCXPPSOb5woYk6EyyFK10brxljM2p6bBd+F7ft5XT2GxvnodkpCmUZtA6csspnToOft6
 Qki3azZ3GZPm2iD+hYhXC6hSRWGMsmc7ewmGh5fwgGoY371JAoCWsfFTOYKonKxPt8e5eRyp+
 38vND6EPimODUUhPK0me4u80BLXUNMEE3NkLVamXe6dffiRCW2MDYgtmqK7eOeKFfp3tCS9cl
 D4HBJkN1XGIvHqejK7goRNiWrBmMMwzDYs+JdtLASpA1COoOE5wqs2kVnEzhLib0vSu1vvYaT
 RUlPkkicety5i6ie
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Thursday 12 May 2016 14:25:49 Felipe Balbi wrote:
> >  {
> >       u32 value = __raw_readl(addr);
> >  
> > -     /* In order to preserve endianness __raw_* operation is used. Therefore
> > -      * a barrier is needed to ensure IO access is not re-ordered across
> > +     /* in order to preserve endianness __raw_* operation is used. therefore
> > +      * a barrier is needed to ensure io access is not re-ordered across
> >        * reads or writes
> >        */
> >       mb();
> > @@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
> >       __raw_writel(value, addr);
> >  
> >       /*
> > -      * In order to preserve endianness __raw_* operation is used. Therefore
> > -      * a barrier is needed to ensure IO access is not re-ordered across
> > +      * in order to preserve endianness __raw_* operation is used. therefore
> > +      * a barrier is needed to ensure io access is not re-ordered across
> >        * reads or writes
> >        */
> >       mb();
> > -#ifdef DWC2_LOG_WRITES
> > -     pr_info("INFO:: wrote %08x to %p\n", value, addr);
> > +#ifdef dwc2_log_writes
> > +     pr_info("info:: wrote %08x to %p\n", value, addr);
> >  #endif
> >  }
> > +#else

Oops, the accidental lowercase conversion is still in here, I'll fix it
up once we agree on the approach.

> I still think this is something that should be handled at MIPS side, no ?

As I explained, there isn't really anything we can do in MIPS code
because of the way they have to handle PCI.

> How many more drivers will we have to 'fix' like this ?

Endianess problems will keep coming up, and we have hundreds or thousands
of drivers that are written with a particular design in mind that could
be wrong as soon as someone chooses to build an SoC that does things
differently. Once that happens, we'll fix them.

Also, Christian has already posted a better version of the patch
that fixes this driver in an architecture independent way, but we still
need a workaround for the stable backports.

	Arnd
