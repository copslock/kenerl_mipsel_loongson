Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 11:55:04 +0200 (CEST)
Received: from zabrina.hetzner-de.towertech.it ([178.63.16.19]:38512 "EHLO
        zabrina.hetzner-de.towertech.it" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816879AbaEFJzAQOE7L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 May 2014 11:55:00 +0200
Received: from linux.lan.towertech.it (93-50-192-40.ip153.fastwebnet.it [93.50.192.40])
        by smtp.towertech.it (Postfix) with ESMTPSA id 3gNGWR4ygPz2mfM;
        Tue,  6 May 2014 11:54:59 +0200 (CEST)
Date:   Tue, 6 May 2014 11:54:58 +0200
From:   Alessandro Zummo <a.zummo@towertech.it>
To:     rtc-linux@googlegroups.com
Cc:     macro@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH 1/2] RTC: rtc-cmos: drivers/char/rtc.c
 features for DECstation support
Message-ID: <20140506115458.4010da2e@linux.lan.towertech.it>
In-Reply-To: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1404192224250.11598@eddie.linux-mips.org>
Organization: Tower Technologies
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <a.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.zummo@towertech.it
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

On Sat, 19 Apr 2014 23:58:20 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> This brings in drivers/char/rtc.c functionality required for DECstation 
> and, should the maintainers decide to switch, Alpha systems to use 
> rtc-cmos.

 Seems sane. We need to be sure it doesn't break anything
 on non-Alpha machines. Did you test it on x86? It would be fine if
 we can get a couple of Tested-by:
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
