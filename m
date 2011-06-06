Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:33:13 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:61487 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFLdK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 13:33:10 +0200
Received: from klappe2.localnet (deibp9eh1--blueice3n2.emea.ibm.com [195.212.29.180])
        by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
        id 0MbsGc-1QBTCS2lEs-00IqeW; Mon, 06 Jun 2011 13:32:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
Date:   Mon, 6 Jun 2011 13:32:51 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.35-22-generic; KDE/4.3.2; x86_64; ; )
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Greg KH <greg@kroah.com>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <1307311658-15853-2-git-send-email-hauke@hauke-m.de> <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
In-Reply-To: <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <201106061332.51661.arnd@arndb.de>
X-Provags-ID: V02:K0:bnwv1BZEKIFB2gmg8JqCvA67ZBu9WJzMVJziHrMGIAv
 2aQkgJ9Kj50xJ1Eho6JQI3yhibnLsUkbsdQPb8ttYSIxg4Rg+s
 hu2wrFHfcA1DIPVKuhOrFXpSQT4QZE9xcOJTfgyPsX6QmqcqK+
 kipcM2NgWE44JC8nE2Q1SipnCaIhOQPVos7LqpMhPn5idohyW0
 64sYXGrnEdgVgWk/AIGqQ==
X-archive-position: 30254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4143

On Monday 06 June 2011, Rafał Miłecki wrote:
> Greg, Arnd: could you take a look at this patch, please?
> 
> With proposed patch we are going back to this ugly array and wrappers hacks.
> 
> I was really happy with our final solution, but it seems it's not
> doable for embedded systems...? Is there something better we can do
> about this?
> 
> 2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> > When using bcma on a embedded device it is initialized very early at
> > boot. We have to do so as the cpu and interrupt management and all
> > other devices are attached to this bus and it has to be initialized so
> > early. In that stage we can not allocate memory or sleep, just use the
> > memory on the stack and in the text segment as the kernel is not
> > initialized far enough. This patch removed the kzallocs from the scan
> > code. Some earlier version of the bcma implementation and the normal
> > ssb implementation are doing it like this.
> > The __bcma_dev_wrapper struct is used as the container for the device
> > struct as bcma_device will be too big if it includes struct device.
> >
> > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

If you rely on device scan to find your CPUs and interrupt controllers,
you are screwed already, this won't work.

In that case, it's better to have a few "early" drivers, as few as
possible, that don't go through the bus scan at all but have their
own ways of bootstrapping themselves. I don't know what you mean by
"CPU management", but I can only assume that it's not doing that much,
and you can just put the register values into the device tree.

For an interrupt controller, it should be ok to have it initialized
late, as long as it's only responsible for the devices on the same
bus and not for instance for IPI interrupts. Just make sure that you
do the bus scan and the initialization of the IRQ driver before you
initialize any drivers that rely in on the interrupts to be working.

	Arnd
