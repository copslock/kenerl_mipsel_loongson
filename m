Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 16:21:31 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:55822 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007060AbbIIOV3vuk0S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2015 16:21:29 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0MY24K-1Z4rh02kS0-00Uvkm; Wed, 09 Sep
 2015 16:21:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: ath79: Add USB support on the TL-WR1043ND
Date:   Wed, 09 Sep 2015 16:21:13 +0200
Message-ID: <1734684.IINudhV2s6@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <20150909161459.30cf580f@avionic-0020>
References: <1441120994-31476-1-git-send-email-albeu@free.fr> <3589971.cbF7muh57v@wuerfel> <20150909161459.30cf580f@avionic-0020>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:9XRAbjqV3t8Kyhsv+uKN+SKg1WwlVmg1XxYc7ZqcsuTusuI8J2i
 /O1FEzYJCeQMm6o44njClJNjkNFgyQtT6Vi3o39P/ca98DRmQfj3yXtiE0Qmo8hRRnSfpSU
 aTF9czCgPCA6G1UhmGoMtkWjTITW6CH/mz+Fo29szDBC/BFYdgWmbQhV+8n1sYYPpp5S7Mq
 qt+QTeHU2MO+ZWjWB01lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:on8g8qNDcYA=:7Q8eH0h1QQbI3ef7jReaY/
 dplXnW3hj8gBj1RPWTcVXh8/L0nu63Sa/2v/WL6/vtApqGhyrbNUY+49/aU/7iDAUwNvT3vVw
 2QEh1A4osoE5m0qhCFrLdzi8H62pJ+dZNjIpseRK4ayJ1eIeZBLCECT+T3KJ9H6C8KyXhLPf+
 iYfnWdTJq9JBzmxuc+PaRhvTplBo5M4kxrUTb5kDL0mxunLhSaQHvZEMHdXthqXk8RfBZGVoZ
 KvhvA4cMvcXHbSLP60FK3Afm3bo1fEJQae8PjG52MHLuvU+l5qCfZnD0yCG2lU/Yv72Z3Z0Sg
 JP0xYKMBmShSFs9jWz/AwrozEmg1XDm/ISls6ZwpmXwzlhwvcTrItIlYatqVP+MAznjlZEgXW
 hxTp/Ah48j4E1vcquOuxTse1VDBXQhoHUADBZODagnKfV0wYWloMYg6Sa/sSfyWi3grRwPBsx
 EJqN/xbUVi3ao0EXadnaZFYh6+IsdkClRrbUdbSkE512rM35NgEudy91GoBNy8St1NK5HY2SF
 gm+t6RQ+Li4UtTQPNbSbfHc5n1yBAbelQaOEf8JhL85e52AaJeo2tDuMzYVfUxuGxqoNIrxjo
 8RRP/cr3h4a/pxk03FDTRpmqDYjG7+2dFfweZGkysyZetyT/YvuFf/ZznddmbUN5iGuk2DXaF
 r8lrOqTAHjimiqsAxEVwO79EpbSn3IPu7pUvSWOeOQVKhlDbYeJTkmAfxvCteAZ19+AOKX/1w
 HZC8izd4oBZ8XFgY
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49151
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

On Wednesday 09 September 2015 16:14:59 Alban wrote:
> On Mon, 07 Sep 2015 15:20:42 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Tuesday 01 September 2015 17:23:10 Alban Bedel wrote:
> > > 
> > > this serie add a driver for the USB phy on the ATH79 SoCs and enable the
> > > USB port on the TL-WR1043ND. The phy controller is really trivial as it
> > > only use reset lines.
> > > 
> > 
> > Is this a common thing to have? If other PHY devices are like this, we
> > could instead add a simple generic PHY driver that just asserts all
> > its reset lines in the order as provided, rather than making this a
> > hardware specific driver that ends up getting copied several times.
> 
> I don't know how common it is. However I agree that a simple driver that
> can start a clock and toggle a few GPIO and/or reset would make sense.
> 
> However in the case of the ATH79 SoC some models have a reset line that
> is misused to force the PHY in sleep mode. Sadly this extra reset must
> be asserted for the PHY to work, so it wouldn't fit in such a generic
> design.
> 
> Still we could have such a generic driver and let the ATH79 driver
> build on top of it. Honestly that's what I wanted to do, but getting
> generic drivers with DT support accepted is not easy. That's why I went
> with this driver, it is technically inferior but much easier to get
> considered for merging.

Ok, fair enough. If we end up doing a more generic driver for this,
we can still consider adding the compatible string there, potentially
with some workaround for the sleep mode.

	Arnd
