Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 10:58:45 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:58401
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6816676AbaF2I6oLGK0p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 10:58:44 +0200
Message-ID: <53AFD542.1010005@phrozen.org>
Date:   Sun, 29 Jun 2014 10:58:42 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 28/06/2014 22:34, Aaro Koskinen wrote:
> Hi,
> 
> The following patches add minimal support for D-Link DSR-1000N
> router. USB and ethernet ports should now work with these patches. 
> (I guess WLAN (PCI/ath9k) should work too; I was able to scan
> networks, but for some reason it did not connect to my AP.)
> 
> Aaro Koskinen (3): MIPS: OCTEON: cvmx-bootinfo: add D-Link
> DSR-1000N MIPS: OCTEON: add USB clock type for D-Link DSR-1000N 
> MIPS: OCTEON: add interface & port definitions for D-Link
> DSR-1000N
> 
> .../cavium-octeon/executive/cvmx-helper-board.c    | 22
> ++++++++++++++++++++++ arch/mips/include/asm/octeon/cvmx-bootinfo.h
> |  2 ++ 2 files changed, 24 insertions(+)
> 


Hi Aaro,

can you tell me what wifi is inside the unit ? and is it soldered onto
the pcb or is there pci/e slot ?

	John
