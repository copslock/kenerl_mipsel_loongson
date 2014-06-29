Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 16:10:28 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:51685 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6861125AbaF2N6mu8j6F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 15:58:42 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4890256FA39;
        Sun, 29 Jun 2014 16:58:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id Wk70cTaS9hhZ; Sun, 29 Jun 2014 16:58:34 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id ADFC15BC007;
        Sun, 29 Jun 2014 16:58:34 +0300 (EEST)
Date:   Sun, 29 Jun 2014 16:58:34 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
Message-ID: <20140629135834.GA557@drone.musicnaut.iki.fi>
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
 <53AFD542.1010005@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53AFD542.1010005@phrozen.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Sun, Jun 29, 2014 at 10:58:42AM +0200, John Crispin wrote:
> On 28/06/2014 22:34, Aaro Koskinen wrote:
> > The following patches add minimal support for D-Link DSR-1000N
> > router. USB and ethernet ports should now work with these patches. 
> > (I guess WLAN (PCI/ath9k) should work too; I was able to scan
> > networks, but for some reason it did not connect to my AP.)
> 
> can you tell me what wifi is inside the unit ? and is it soldered onto
> the pcb or is there pci/e slot ?

The chipset is AR9160-BC1A. It's removable, on a mini-PCI slot.

00:03.0 Class 0280: 168c:0027

[    4.760516] ieee80211 phy0: Atheros AR9160 MAC/BB Rev:1 AR5133 RF Rev:b0 mem
=0x80011b00f0000000, irq=110

A.
