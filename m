Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 10:00:44 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.131]:51587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006657AbaHYIAmPTpOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 10:00:42 +0200
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue001) with ESMTP (Nemesis)
        id 0LqZik-1WhYlX47u6-00eKG5; Mon, 25 Aug 2014 10:00:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        zajec5@gmail.com
Subject: Re: [RFC 5/7] bcma: get IRQ numbers from dt
Date:   Mon, 25 Aug 2014 10:00:01 +0200
Message-ID: <1408960991.IQOFBLWbOW@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.11.0-26-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1408915485-8078-7-git-send-email-hauke@hauke-m.de>
References: <1408915485-8078-1-git-send-email-hauke@hauke-m.de> <1408915485-8078-7-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:/TdsOaMFmn2F4EXmmUi8dvrL0pVDC6qEkJJzZMHt8xB
 L5jgOxn9/3/ZwNsFnf3jK7kjkAddlGdLQrsFIYG5uVEpRrub8q
 hX20UYkeMX0Td3vKbwirncI1dmKpld5j1YWWFCsKcHT+zbWsfI
 ml8/kRCFivuMIw7I0yzPF1M3g5eqfAPCOQrPJkb3JF1geRU8oc
 EXNwDUmEZAwisS5yY+/k/s26jfHp2gKYCRVASrvdICVcGCRejm
 j2LykiS76Il+Oqv+YW0FRxjKuPRAGIcBNuOihUVyqsLR+AJGpe
 WGL0QHDWbCVMmE7uXgx5oK/3ZiHgJXqQU0ryfspUlxeLhcYtEY
 HBB21IUlGOpBjtHHGjQ0=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42211
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

On Sunday 24 August 2014 23:24:43 Hauke Mehrtens wrote:
> It is not possible to auto detect the irq numbers used by the cores on
> an arm SoC. If bcma was registered with device tree it will search for
> some device tree nodes with the irq number and add it to the core
> configuration.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
