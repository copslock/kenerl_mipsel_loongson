Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:04:53 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.131]:62705 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013510AbaKLJEqrVXjV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:04:46 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue004) with ESMTP (Nemesis)
        id 0MCMK5-1XfNBF2kYz-00999d; Wed, 12 Nov 2014 10:04:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH/RFC 5/8] serial: pxa: Make the driver buildable for BCM7xxx set-top platforms
Date:   Wed, 12 Nov 2014 10:04:27 +0100
Message-ID: <3356477.HitZEsNa4H@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1415781993-7755-6-git-send-email-cernekee@gmail.com>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-6-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:ojZ68wdoF/H0fSdm36XZXF76K9vcLGcCU8RT7acyySh
 /wg+q9C6R7wZ+6y55oGMHxuFe7bYc6VnpczWJuJi06dGUtXhHT
 2oHymi0sFRRIG+6JqBOMzrMYmx2/2FkQt/ssCWdLBv1IBqx2uS
 zMx46qksZPfc4LnJvsTr2uehVVih/kmsqJfAwfLd7GksncWaaD
 4aObUBff1rgXPRBhXBzFIQ5OpCJzNMT8w9lJihxzym4L4NbFAT
 4T/W7aNLiS5Fp8gyb/GvbkI58mQ9USZVllRPCM16fRIm36LKQ6
 ZwVxpUMKNzNej5OnTFMp9lp7njUh1wcoftnFUGmAC4oBbU9ZwG
 5mSyKtSppIrIGormTK+Y=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44041
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

On Wednesday 12 November 2014 00:46:30 Kevin Cernekee wrote:
> Remove the platform dependency in Kconfig and add an appropriate
> compatible string.  Note that BCM7401 has one 16550A-compatible UART
> in the UPG uart_clk domain, and two proprietary UARTs in the 27 MHz
> clock domain.  This driver handles the former one.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Can you explain why you are using the PXA serial driver instead of the
8250 driver, if this is 16550A compatible? I don't know the history
why PXA is using a separate driver.

	Arnd
