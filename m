Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:43:50 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.24]:60021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013481AbaKLJntAttBK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:43:49 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue105) with ESMTP (Nemesis)
        id 0MEWCH-1XlzMr2YeH-00Fk5e; Wed, 12 Nov 2014 10:43:40 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
Date:   Wed, 12 Nov 2014 10:43:39 +0100
Message-ID: <15071020.3LPpWWN4p1@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
References: <1415735146-31552-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-Provags-ID: V02:K0:8JVw60zb57K9uIdkVA4G80j/OLSTkvytO5bSyBDtKWN
 X6MJJoE8S3CiEfC9VTm04KJuWfGssN4KalIkOcLdjLigZwzFFX
 FunLS1as8NRBhPE/u1DzlKGIdx9sDiGNMe1BKeGaUPM1l8ffoy
 Rs+ZXKNPa1P0T4byDQwbvVzBlC8HUdsfGRxpxvBE91QfwtTHh0
 eWVtwyBISMxxq1MdbJCT87wWaP4Dfp4imXI6Mx+/FhzqDEAdRm
 v/lTuYY8/rYGpMet+8/flAt7x5tdojQnafA6yW5StTvciFg1UP
 6DyFzGNK8+QaOu3lgn2XSFj7WV3bwB39eMagWyQ7jtjaOZphGT
 dIAd9jjCo/kBQYB2eHd4=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44049
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

On Tuesday 11 November 2014 20:45:46 Rafał Miłecki wrote:
> After Broadcom switched from MIPS to ARM for their home routers we need
> to have NVRAM driver in some common place (not arch/mips/).
> We were thinking about putting it in bus directory, however there are
> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
> won't fit there neither.
> This is why I would like to move this driver to the drivers/misc/
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> 

I think drivers/soc would be more appropriate, as this is a purely
in-kernel interface, and it interacts with other drivers, while
drivers/misc is generally for oddball devices that don't fit in
elsewhere and have their own user interface.

I don't remember if what we had concluded on the previous discussion.
I think I suggested converting the nvram variables into DT properties
on ARM. The API certainly feels obscure, so it would be nice to
keep it out of the modern port if we can come up with a better alternative
to pass the same information.

	Arnd
