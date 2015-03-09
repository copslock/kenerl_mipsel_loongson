Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 18:53:05 +0100 (CET)
Received: from ns.iliad.fr ([212.27.33.1]:43219 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007908AbbCIRxEQWJM3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Mar 2015 18:53:04 +0100
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 540F8208CE;
        Mon,  9 Mar 2015 18:53:04 +0100 (CET)
Received: from [192.168.108.32] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 3F4F52085F;
        Mon,  9 Mar 2015 18:53:04 +0100 (CET)
Message-ID: <54FDDE00.7030100@freebox.fr>
Date:   Mon, 09 Mar 2015 18:53:04 +0100
From:   Nicolas Schichan <nschichan@freebox.fr>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alexandre Courbot <acourbot@nvidia.com>, linux-mips@linux-mips.org
CC:     Maxime Bizon <mbizon@freebox.fr>
Subject: bcm63xx gpio issue on 3.19
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Mar  9 18:53:04 2015 +0100 (CET)
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
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


Hello Alexandre,

Using the latest 3.19 kernel, the bcm63xx GPIO code under
arch/mips/bcm63xx/gpio.c is unable to register the gpio chip via
gpiochip_add(), as it returns -ENOMEM. The kcalloc call for the gpio_desc
array fails, as during prom code, it is too early for the kmalloc to work.

It looks like the issue is caused by your patch: "gpio: remove gpio_descs
global array"

Could you please advise on how to fix/workaround that ? (ideally while keeping
the possibility to invoke the gpiolib code from the setup/prom code).

Regards,

-- 
Nicolas Schichan
Freebox SAS
