Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 08:56:01 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:62504 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011870AbaJ2Hz7dFMvD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 08:55:59 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue001) with ESMTP (Nemesis)
        id 0M4vkM-1Y0L9g4AFq-00zJSE; Wed, 29 Oct 2014 08:55:31 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 11/11] irqchip: Decouple bcm7120-l2 from brcmstb-l2
Date:   Wed, 29 Oct 2014 08:55:30 +0100
Message-ID: <2809323.IhySeFJxgA@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414555138-6500-11-git-send-email-cernekee@gmail.com>
References: <1414555138-6500-1-git-send-email-cernekee@gmail.com> <1414555138-6500-11-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:mdTJYWHAZ87ZGg5BUPxwo4II2CSVyITfC7eFhioGQxm
 M3WWmx6/sWOCo4v1eMVNR+/uy2722fg6IuV+n9G6m7DkAGYZ0/
 zf6hZNybg2US4zhaFHsRVPk0r4DZ/hKzNHHY2hQlavaUK+vd2U
 jtDOwZdJKg8vfc1338TLIg5pJ5XB+0sLulLEXx7m9hIIk89NId
 DUcXFNgfXBcW9u6IgFpccZYC5vct8hMDz8Wmqn5e0ctfv7OuoO
 YkWuuRVKXVgTBkXVFNAvl5SMo0ZGpxahDrBs2MFspVfExDMPzX
 rmgaXo7YO8mOx8v7fM+inGIQHZXGkLnu9yQExCnyAby1OLJsuW
 /zjrSfj7K3vA/f4GOSFY=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43691
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

On Tuesday 28 October 2014 20:58:58 Kevin Cernekee wrote:
> Some chips, such as BCM6328, only require the former driver.  Some
> BCM7xxx STB configurations only require the latter driver.  Treat them
> as two separate entities, and update the mach-bcm dependencies to
> reflect the change.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
