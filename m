Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 16:30:57 +0200 (CEST)
Received: from static.88-198-24-112.clients.your-server.de ([88.198.24.112]:34043
        "EHLO nbd.name" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6861351AbaF2OEOyTG6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 16:04:14 +0200
Message-ID: <53B01CDC.3020009@phrozen.org>
Date:   Sun, 29 Jun 2014 16:04:12 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi> <53AFD542.1010005@phrozen.org> <20140629135834.GA557@drone.musicnaut.iki.fi>
In-Reply-To: <20140629135834.GA557@drone.musicnaut.iki.fi>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40935
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



On 29/06/2014 15:58, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Jun 29, 2014 at 10:58:42AM +0200, John Crispin wrote:
>> On 28/06/2014 22:34, Aaro Koskinen wrote:
>>> The following patches add minimal support for D-Link DSR-1000N 
>>> router. USB and ethernet ports should now work with these
>>> patches. (I guess WLAN (PCI/ath9k) should work too; I was able
>>> to scan networks, but for some reason it did not connect to my
>>> AP.)
>> 
>> can you tell me what wifi is inside the unit ? and is it soldered
>> onto the pcb or is there pci/e slot ?
> 
> The chipset is AR9160-BC1A. It's removable, on a mini-PCI slot.
> 
> 00:03.0 Class 0280: 168c:0027
> 
> [    4.760516] ieee80211 phy0: Atheros AR9160 MAC/BB Rev:1 AR5133
> RF Rev:b0 mem =0x80011b00f0000000, irq=110
> 
> A.
> 

Thanks for the info,

	John
