Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2015 23:48:59 +0100 (CET)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36641 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009017AbbCXWs6a8iIb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2015 23:48:58 +0100
Received: by pdbcz9 with SMTP id cz9so7519401pdb.3;
        Tue, 24 Mar 2015 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8EBA7q7cU+uZF2n7kWMtXzLocnLsi6DBXGTd+QEcpZk=;
        b=bkXdTZYzMkSM1BPAU/uyVovdc2Ki3Lbv7918UW1PcJjWv6nJNcnRZ3gLnS+1sHMHYi
         ZPdvcXlaXm2yrdPFHWavKY7RZ1YQh1wdBc7xgTYpk9AAEiU5xpMW5T+k9Iu0ym/1RHAF
         ZPWLzakuDIj0B5bgsHVPd5csalN5B6dsFb6syN+weL7iEKE0SEufayqNIlw5vl+Ks4sW
         PvjvY+L/O5n7etTyBPZNmzRFzn2rpkGW3JTgPCqyyb+6RAFHA7tfli6juOMvMnacaB2z
         R4viMZPXJVjGbvOn+ZqIJiVIsrlG1jYva2N4xpJ6O3cfbTV5El1CxP0KDVSOAIg0nkqH
         54sQ==
X-Received: by 10.70.98.139 with SMTP id ei11mr11525112pdb.3.1427237333287;
        Tue, 24 Mar 2015 15:48:53 -0700 (PDT)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id gy3sm342387pbb.42.2015.03.24.15.48.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2015 15:48:52 -0700 (PDT)
Message-ID: <5511E9A8.6090908@gmail.com>
Date:   Tue, 24 Mar 2015 15:48:08 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, ralf@linux-mips.org
CC:     jaedon.shin@gmail.com, abrestic@chromium.org, tglx@linutronix.de,
        jason@lakedaemon.net, jogo@openwrt.org, arnd@arndb.de,
        computersforpeace@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/25] Generic BMIPS kernel
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46509
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 25/12/14 09:48, Kevin Cernekee wrote:
> V5->V6: Incorporate several fixes/enhancements from Jaedon Shin:
> 
>  - Fix register read/modify/write in RAC flush code.
> 
>  - Fix use of "SYS_HAS_CPU_BMIPS32_3300" Kconfig symbol.
> 
>  - Add base platform support for 7358 and 7362.
> 
> The DTS files follow Andrew Bresticker's new per-vendor directory layout.
> 
> This series applies on top of Linus' current head of tree.
> 
> Patch 01 (Fix outdated use of mips_cpu_intc_init()) is REQUIRED for 3.19
> to fix a build failure seen in 3.19-rc.  The other patches can
> be queued for 3.20 or later.

Jason, can you merge the irqchip patches through your tree? They still
apply cleanly to your irqchip/core branch as of today, except the last
one which has a small hunk to be fixed in drivers/irqchip/Makefile.

Thanks!
-- 
Florian
