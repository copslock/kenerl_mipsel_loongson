Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 10:59:12 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.130]:60331 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007411AbaLOJ7KJb48d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 10:59:10 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue004) with ESMTPSA (Nemesis) id 0LlJ5u-1XPTiW1mNy-00b2EK; Mon, 15 Dec
 2014 10:58:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, jogo@openwrt.org,
        computersforpeace@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 00/23] Generic BMIPS kernel
Date:   Mon, 15 Dec 2014 10:58:57 +0100
Message-ID: <3160456.oe6LURFJHs@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:8yLCd7pcVWC1jdffW4Y5ri8o42Ope7ujtVR/RNdm+YUOwoW0m0Z
 Rl9nPAm55X+dKpApsl8KS6hQjtU+ovrzklQ02yoqsRlUaSSSmKXWz9tj6/28Jbzl/3ostYN
 SkYlrAFNl8nBJhkYeUYo7EyLb4bInkphhHf2SnbEvxLY2eZ9Nn/+nWiqNyMFOpYRxQAmzmz
 paPtcEsexj6xY1oPMWICQ==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44667
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

On Friday 12 December 2014 14:06:51 Kevin Cernekee wrote:
> V4->V5:
> 
>  - Rebase on top of Linus' head of tree, converting BCM3384 platform code
>    to Generic BMIPS platform code.
> 
>  - Fix a couple of #include's
> 
>  - Remove a couple of bogus entries from bmips_be_defconfig
> 
> Compile-tested only.  Some BMIPS platforms may require acked-but-unmerged
> changes in other subsystems (like the native-endian serial8250/DT patches).
> 
> For 3.19 you'll want the first patch at the minimum (because the build is
> currently broken).
> 

Since I commented on some of these patches before, I now took another
(not very thorough) look at all of them. Looks very nice overall, I
have no further comments.

Acked-by: Arnd Bergmann <arnd@arndb.de>
