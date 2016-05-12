Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 13:52:49 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:56991 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029302AbcELLwrqNwWn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 May 2016 13:52:47 +0200
Received: from wuerfel.localnet ([78.42.132.4]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0Mf1KL-1bGRGo2ZzN-00OYPb; Thu, 12 May
 2016 13:52:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        John Youn <johnyoun@synopsys.com>,
        Gregory Herrero <gregory.herrero@intel.com>,
        linux-mips@linux-mips.org, a.seppala@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        gregkh@linuxfoundation.org,
        Christian Lamparter <chunkeey@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
Date:   Thu, 12 May 2016 13:52:17 +0200
Message-ID: <2597884.52Dcpckj86@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <87y47fcxhs.fsf@linux.intel.com>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de> <2809110.sWekaCNVxS@wuerfel> <87y47fcxhs.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K0:EByMiQ2doDLsTCCsAIDfPlFB9FgNklzNblPbywFYVO5wY2Ld2o9
 pKxI0m396Kb8idCqJFBO4z+TjRWEWFVqSzFgMQWOgJ8ZGndWJ+GdcxjeUKap8KvmUZtVfvn
 BV7YScR249jvlaNV8+jFQjityISfe7gUmeYPDXhP9jJQr4vzxe0ygA5ubasOtXruNpa3V9p
 +gTXIQLEd2J4HOYem7WHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ouGn/HU3OWo=:YVOVnJgzjWjauRBprVpSOx
 YJiOFz/l3DmexHmV/vCrR1N7c9qCzFqOkX36JHO7e3HoxjLq8CgUZ8yxqxgEYfddqHmTa6i6r
 IDUIp0fYOa/63v89edewBGWZdgZbOSWF91Iqx/ytqyIzBAGU6ZD0SbkqRIatgGLV88p08umj5
 znIcfC4N0ZB48WgGjttdj58dDX7IHbPnmFgMuLKKOwCXOlZnzPxXswAKv3y7cVIVI553MZHdW
 gj5AGkhfyniXWegIMkG+Nw49GEKSaZhEf4SDQObPPuzczRHk8bcV6YfYbIhYxwtTBi1nUJT3Y
 il5MdPeozIc/I0BUQNC9vuCbN3IXK2uhP5dTgPQ0jfgSdxaBhyN1D1rDXs+mvTLw/12FcrvWp
 7r79YnNidrP6SXhVgS29vvr2vy/SG5JmpwMjxexGYX1tXq9mkbVk7ciFdrnvV1SoP8sFa9NJB
 ztIS41Ia8iUg/1L9Wb78F/ycwdvBOXGyv4hG1lnFsEzXhOzLS5zrWeUubm6cQa7fNoPbqrqiF
 Tmf4gseJcTUGxkkeFTruSTITWQdaB5DanSXWzRmh2FvHVJxuf6TNLhC+aZEZm0iYE/pgh5lEx
 DqUhxXxlmHini0ysqkZruF0L2Ke8qBAxxSl8SyMhUA0OaAUcZgIJWnMf749NY6rNxQdFmyn23
 NmCEw3cixKEtfuFp3Ky22qq68tg6dGlp5tGm540B15ELKcY0yYCALsG2aG3KGs7yp7cpjG0tk
 Hf2RQpKzA1HGVnYZ
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53405
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

On Thursday 12 May 2016 14:43:43 Felipe Balbi wrote:
> >> How many more drivers will we have to 'fix' like this ?
> >
> > Endianess problems will keep coming up, and we have hundreds or thousands
> > of drivers that are written with a particular design in mind that could
> > be wrong as soon as someone chooses to build an SoC that does things
> > differently. Once that happens, we'll fix them.
> >
> > Also, Christian has already posted a better version of the patch
> > that fixes this driver in an architecture independent way, but we still
> > need a workaround for the stable backports.
> 
> hmmm, at least dwc3 (also from SNPS) has a couple bits where we can
> choose endianess for registers and DMA descriptors. John, do we have the
> same for dwc2 ? Wouldn't that be a better way to solve the problem ?

Yes, I think that would be the best solution (provided it works correctly).

My understanding is that the descriptors don't need to change
for the particular MIPS machine, only the registers do. If we have
another machine that requires the descriptor endianess to be flipped
from the default, we probably need a DT property or platform_data
flag to encode that.

We can do the register endianess detection from Christian's patch to
flip it around if necessary, and then revert back to the previous
state of always using readl/writel.

	Arnd
