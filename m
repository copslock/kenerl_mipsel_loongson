Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2009 10:02:26 +0100 (CET)
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:1207 "EHLO
        mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492291AbZLCJCX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2009 10:02:23 +0100
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEABsNF0tR9cXB/2dsb2JhbADXIAqEJwQ
Received: from 193.197-245-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.245.197.193])
  by relay.skynet.be with ESMTP; 03 Dec 2009 10:02:17 +0100
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1NG7Zp-0004fZ-B3; Thu, 03 Dec 2009 10:02:17 +0100
Date:   Thu, 3 Dec 2009 10:02:17 +0100
From:   Wim Van Sebroeck <wim@iguana.be>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Koeller <thomas.koeller@baslerweb.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] eXcite: Remove platform support and drivers.
Message-ID: <20091203090217.GT3772@infomag.iguana.be>
References: <20091202153016.GA9892@linux-mips.org> <20091202153534.GA10692@linux-mips.org> <alpine.LFD.2.00.0912030709230.10116@macbook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912030709230.10116@macbook.infradead.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Ralf,

>> The platform has never been fully merged.  Remove it including MTD and
>> watchdog drivers.
>>
>> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>> ---
>> I'd like acks from the watchdog and MTD maintainers please.
>
> Acked-by: David Woodhouse <David.Woodhouse@intel.com>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
