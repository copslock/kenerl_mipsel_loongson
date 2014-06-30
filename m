Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2014 19:15:08 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:52460 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859949AbaF3RPCmsHL3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jun 2014 19:15:02 +0200
Received: by mail-ig0-f178.google.com with SMTP id hn18so4514574igb.5
        for <multiple recipients>; Mon, 30 Jun 2014 10:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FQUKCS92Bb+e+ZkHNAKDxpoMiJJftWfvkxRSmwJrJCs=;
        b=OTLGqVpYk0TLBch+VNwWDbOIRu1mQSeElsGvl9MCupbo/P+ej05a4cr+3hdq4pA2mq
         RdxOehKhEoaaEY6HAcfUFya8EECmljzjSsvI7586yhcXPqQt8tn+TRCPuQeaBP2x9hAM
         Q4SkVMHIF1szccpmpuAGmhEuTbkueJwmiIwTi0KoDqLj81fI+CLtrOWsuoZVOJpAIO47
         zYqB7wqUrlyB53e75hkUu4jIv2lgTh30mRv0SCpEhnRIrFAO1qPaO/nXnQIxj8vvwYXW
         alljA3iiD4bKfWpY37FPEh8orGDPRJwxkWesnlOYkUCPvPlHUrcVqDyD3pubAH0VEJ8D
         tahg==
X-Received: by 10.50.114.226 with SMTP id jj2mr34654819igb.27.1404148496546;
        Mon, 30 Jun 2014 10:14:56 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id hv1sm7325413igb.0.2014.06.30.10.14.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 10:14:55 -0700 (PDT)
Message-ID: <53B19B0E.8000702@gmail.com>
Date:   Mon, 30 Jun 2014 10:14:54 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/3] MIPS: OCTEON: Minimal support for D-Link DSR-1000N
References: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1403987650-6194-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/28/2014 01:34 PM, Aaro Koskinen wrote:
> Hi,
>
> The following patches add minimal support for D-Link DSR-1000N router.

Which OCTEON chip does this device contain?

Also what is the bootloader version on the board?

David Daney


> USB and ethernet ports should now work with these patches.
> (I guess WLAN (PCI/ath9k) should work too; I was able to scan networks,
> but for some reason it did not connect to my AP.)
>
> Aaro Koskinen (3):
>    MIPS: OCTEON: cvmx-bootinfo: add D-Link DSR-1000N
>    MIPS: OCTEON: add USB clock type for D-Link DSR-1000N
>    MIPS: OCTEON: add interface & port definitions for D-Link DSR-1000N
>
>   .../cavium-octeon/executive/cvmx-helper-board.c    | 22 ++++++++++++++++++++++
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  2 ++
>   2 files changed, 24 insertions(+)
>
