Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2010 20:23:55 +0200 (CEST)
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:25826 "EHLO
        mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab0JJSXw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Oct 2010 20:23:52 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHKgsUxXQb7Z/2dsb2JhbACiDXK8QQ2FOwQ
Received: from 217.190-65-87.adsl-dyn.isp.belgacom.be (HELO infomag) ([87.65.190.217])
  by relay.skynet.be with ESMTP; 10 Oct 2010 20:23:42 +0200
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1P50Yg-0006YW-O3; Sun, 10 Oct 2010 20:23:42 +0200
Date:   Sun, 10 Oct 2010 20:23:42 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 13/14] watchdog: octeon-wdt: Use I/O clock rate for
        timing calculations.
Message-ID: <20101010182342.GC24194@infomag.iguana.be>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com> <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi David,

> The creation of the I/O clock domain requires some adjustments.  Since
> the watchdog counters are clocked by the I/O clock, use its rate for
> timing calculations.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org

Signed-off-by: Wim Van Sebroeck <wim@iguana.be> .

I prefer this one to go through the mips tree.

Kind regards,
Wim.
