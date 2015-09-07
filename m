Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 15:21:04 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.17.10]:55968 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007826AbbIGNVCeEAF2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 15:21:02 +0200
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue101) with ESMTPSA (Nemesis) id 0M9oN6-1ZNxyw0F7w-00B2qO; Mon, 07 Sep
 2015 15:20:46 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] MIPS: ath79: Add USB support on the TL-WR1043ND
Date:   Mon, 07 Sep 2015 15:20:42 +0200
Message-ID: <3589971.cbF7muh57v@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1441120994-31476-1-git-send-email-albeu@free.fr>
References: <1441120994-31476-1-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:zDPkBRkcuFDI69CjIzrIcfxEd2RdVd3tgvaJlRYxrkZQsMB2Pml
 g2CM3bFx7mWuvaMWVxr8bYM6HfFDDRmQimKlz8cv/8lVKux82uodj5Fj4RnThDJ8SSeKtQh
 6YleBRB2WeEB4YvnQLhHJW2/kjPFMZp37m9NzhV/wcZWZZnioEIAq1YRPDhn/lzC1UAEgQU
 keVV0v11wAM5ljQRrsZqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LBCWcSiZBoU=:ZKQ+p9bgLDuG4GJPAdPAqd
 P2qtuZK8n/XlAQkURpFdIqUK7QtTNbg87hOcOiH8fFzoIZl34B+9tGVJd3vp9JwkMXLNsINd9
 28d91U1fZzzS/nZZIQjam0He4cdjwWMa0HkUlQFilbHYaSVM+HFYHW49T/0vWZbtUUKycPhYv
 SzH5NqymNvMtEY3dgkHbXYUEa1wAJhwam9j39bED8CTAUX+8GEe8yBO52lj/8JHiQv9XiOP0l
 9xvQoXo6ddXAQcmi9i8BxFD/WV9FD3O61NoX4rvxubLcFyqIQ5eGuVRHIHS349uFtelppzVlQ
 ZPq1clC740yh5RAw0HtntUxKmRAbtXQ1RR3A0lh0SA+h9gsHhxM1pzItJ54chPwGxA9bRXpdb
 lRNSmYVDF8tuNY+6mS4+tRaKvL4scOn5+Pin+rP9Fcnihz8vXtLQrYExxG6ks3+/yFxHx2mca
 lZPNcBuoaIMro8jbwMDetYOS5FEiikEn7HglDx8kZwzGUjyAwBUgIplQvuTEFFheNMccq9t+Y
 1ft1JwxLlSIfpeJglKN0tnPhs3DvjWkOMOl+R2K6bEEWOhc+wTTTQcaM93bVikYYUFbZWGwd4
 7VO0FPnc+xxGYSBDoHDpY7/GPemcpK7BzHbJUVLh6w8r0Hst69kqAoLXoHx1oRnQr1whYrMji
 aShGEDMIDQP3DV/cd737fDvfZPxVV59c++MaWOvAlGjW8H5bkk777vss2M33TosETDAFBxvG8
 FSlho+fuK4lTNlGZ
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49127
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

On Tuesday 01 September 2015 17:23:10 Alban Bedel wrote:
> 
> this serie add a driver for the USB phy on the ATH79 SoCs and enable the
> USB port on the TL-WR1043ND. The phy controller is really trivial as it
> only use reset lines.
> 

Is this a common thing to have? If other PHY devices are like this, we
could instead add a simple generic PHY driver that just asserts all
its reset lines in the order as provided, rather than making this a
hardware specific driver that ends up getting copied several times.

	Arnd
