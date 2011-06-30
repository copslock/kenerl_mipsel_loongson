Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2011 14:54:44 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.9]:56583 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab1F3Myl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jun 2011 14:54:41 +0200
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
        id 0M0KvV-1RQ7YO0bXx-00uw06; Thu, 30 Jun 2011 14:54:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: SB16 build error.
Date:   Thu, 30 Jun 2011 14:54:16 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.31-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, florian@linux-mips.org,
        Florian Fainelli <florian@openwrt.org>,
        linux-arch@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20110630091754.GA12119@linux-mips.org> <s5hy60jwocc.wl%tiwai@suse.de> <20110630123212.GA6690@linux-mips.org>
In-Reply-To: <20110630123212.GA6690@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106301454.16530.arnd@arndb.de>
X-Provags-ID: V02:K0:ipnQQbgI2nL1V72pn4sQ2+HB7Yl3zcv6bH8CXOn4aGZ
 ekvvO+TYBqFFhvMrCtVjXqvASmubmcmkPj05J7stHqQU7rBE97
 0a5u24Q633WwhfwVwDTVDV8DdZN3KzlmJkS8iVFrqtbmK5O0WC
 hL8wo/vxCEZeOPPoHuVPEySUoPJDZ3LxCuxeN34f3EKn307feq
 28orNv/BxY2SxeXpAyMYw==
X-archive-position: 30569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 24909

On Thursday 30 June 2011, Ralf Baechle wrote:
> #define SNDRV_SB_CSP_IOCTL_LOAD_CODE                            \
>         _IOC(_IOC_WRITE,'H', 0x11, sizeof(struct snd_sb_csp_microcode))
> 
> error checking can be bypassed and all will be fine as long as the
> resulting value doesn't result in in a a duplicate case value - which it
> doesn't, at least not in my testing.
> 
> Should work but isn't nice.

Right. It's probably the best we can do. I think we added a few similar
definitions when we originally introduce _IOC_TYPECHECK. The idea was
never to break existing code, but rather to avoid merging new drivers that
use inconsistent ioctl command numbers.

	Arnd
