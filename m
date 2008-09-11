Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2008 17:06:28 +0100 (BST)
Received: from gw.goop.org ([64.81.55.164]:6287 "EHLO mail.goop.org")
	by ftp.linux-mips.org with ESMTP id S20302919AbYIKQGX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2008 17:06:23 +0100
Received: by lurch.goop.org (Postfix, from userid 525)
	id ACE2C2C804D; Thu, 11 Sep 2008 09:06:18 -0700 (PDT)
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id 87EEA2C803F;
	Thu, 11 Sep 2008 09:06:18 -0700 (PDT)
Received: from [192.168.0.228] (dhcp-228.goop.org [192.168.0.228])
	by lurch.goop.org (Postfix) with ESMTP;
	Thu, 11 Sep 2008 09:06:18 -0700 (PDT)
Message-ID: <48C941FA.50500@goop.org>
Date:	Thu, 11 Sep 2008 09:06:18 -0700
From:	Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	Ingo Molnar <mingo@elte.hu>, Alex Nixon <alex.nixon@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/3] Globally defining phys_addr_t
References: <48C8D76B.10901@goop.org> <Pine.LNX.4.64.0809111202560.1545@anakin>
In-Reply-To: <Pine.LNX.4.64.0809111202560.1545@anakin>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org
Return-Path: <jeremy@goop.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeremy@goop.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:
>> PowerPC also defines a phys_addr_t with the same meaning as x86; the
>> powerpc arch maintainers are happy with these patches.
>>     
>
> If I'm not mistaking, this is also true for some MIPS machines.
>   

Nothing turns up in a grep over arch/mips and include/asm-mips.

    J
