Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2011 11:19:15 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54600 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491132Ab1F0JTJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jun 2011 11:19:09 +0200
Received: by wyf23 with SMTP id 23so3800257wyf.36
        for <multiple recipients>; Mon, 27 Jun 2011 02:19:03 -0700 (PDT)
Received: by 10.227.54.6 with SMTP id o6mr5237222wbg.61.1309166343262;
        Mon, 27 Jun 2011 02:19:03 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.94.45])
        by mx.google.com with ESMTPS id fl19sm3932899wbb.49.2011.06.27.02.18.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 27 Jun 2011 02:19:01 -0700 (PDT)
Message-ID: <4E084AC2.5060908@mvista.com>
Date:   Mon, 27 Jun 2011 13:17:54 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Miao <eric.y.miao@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ben Dooks <ben-linux@fluff.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jeff Garzik <jeff@garzik.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] NET: AX88796: Tighten up Kconfig dependencies
References: <20110625180050.GA9620@linux-mips.org>
In-Reply-To: <20110625180050.GA9620@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21604

Hello.

On 25-06-2011 22:00, Ralf Baechle wrote:

> In def47c5095d53814512bb0c62ec02dfdec769db1 the AX88796 driver got

    Please also specify the summary of that commit.

> restricted to just be build for ARM and MIPS on the sole merrit that it

    Merit?

> was written for some ARM sytems and the driver had the missfortune to

    Misfortune?

> just build on MIPS, so MIPS was throw into the dependency for a good
> measure.  Later 8687991a734a67f1638782c968f46fff0f94bb1f added SH but

    Summary here too, please.

> only one in-tree SH system actually has an AX88796.

> Tighten up dependencies by using an auxilliary config sysmbol
> HAS_NET_AX88796 which is selected only by the platforms that actually
> have or may have an AX88796.  This also means the driver won't be built
> anymore for any MIPS platform.

> Signed-off-by: Ralf Baechle<ralf@linux-mips.org>

WBR, Sergei
