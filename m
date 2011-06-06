Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 23:53:55 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.126.171]:63928 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491874Ab1FFVxw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 23:53:52 +0200
Received: from wuerfel.localnet (port-92-200-26-47.dynamic.qsc.de [92.200.26.47])
        by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
        id 0MV56z-1Q46NG1kNx-00YPGb; Mon, 06 Jun 2011 23:53:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
Date:   Mon, 6 Jun 2011 23:53:40 +0200
User-Agent: KMail/1.13.6 (Linux/3.0.0-rc1nosema+; KDE/4.6.3; x86_64; ; )
Cc:     George Kashperko <george@znau.edu.ua>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Greg KH <greg@kroah.com>, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, mb@bu3sch.de, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de> <201106061503.14852.arnd@arndb.de> <4DED48EA.7070001@hauke-m.de>
In-Reply-To: <4DED48EA.7070001@hauke-m.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106062353.40470.arnd@arndb.de>
X-Provags-ID: V02:K0:tHivx7LtVs8emXQL2MUS+9bsoAzuQZbAI8CDWR8uUKw
 HlfjVsd1UWQcpJ6PxJksfx3r4mZIPQD0uFdEZl+mWksoyx1RHs
 J8adhLV/c1Wg2U47ZCTekQIDvXdgi4i7xN2yEJEOkRXcvwAVXp
 GVZKZJvtIRiXeeUXEKUdzguIzN9ZttaaebPcleFD16l/jjpvfb
 nevVRY0Crjv6QFdxzy7+Q==
X-archive-position: 30270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4943

On Monday 06 June 2011 23:38:50 Hauke Mehrtens wrote:
> Accessing chip common should be possible without scanning the hole bus
> as it is at the first position and initializing most things just needs
> chip common. For initializing the interrupts scanning is needed as we do
> not know where the mips core is located.
> 
> As we can not use kalloc on early boot we could use a function which
> uses kalloc under normal conditions and when on early boot the
> architecture code which starts the bcma code should also provide a
> function which returns a pointer to some memory in its text segment to
> use. We need space for 16 cores in the architecture code.
>
> In addition bcma_bus_register(struct bcma_bus *bus) has to be divided
> into two parts. The first part will scan the bus and initialize chip
> common and mips core. The second part will initialize pci core and
> register the devices in the system. When using this under normal
> conditions they will be called directly after each other.

Just split out the minimal low-level function from the bcma_bus_scan
then, to locate a single device based on some identifier. The
bcma_bus_scan() function can then repeatedly allocate one device
and pass it to the low-level function when doing the proper scan,
while the arch code calls the low-level function directly with static
data.

	Arnd
