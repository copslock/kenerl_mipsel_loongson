Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Apr 2017 16:21:28 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:52702 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991948AbdD3OVUXHApj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 30 Apr 2017 16:21:20 +0200
Received: from [192.168.1.2] ([78.49.149.53]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEqOg-1dKjk72iuA-00G0IX; Sun, 30
 Apr 2017 16:20:37 +0200
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: MIPS: Lantiq: Completion of error handling around clkdev_add_clkout()
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Felix Fietkau <nbd@nbd.name>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Message-ID: <b27c5b95-747b-e83a-84e8-01fd7a1ae04e@users.sourceforge.net>
Date:   Sun, 30 Apr 2017 16:20:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:coauluGJ0mXN8VZ1Iez2SeTV/jLCfXNV/HjR9BzrDc8NEQReKq4
 LwwJkOT2HzVYkYPCPzYHeXF4tUqesuPLJvCCNn2E9Awx9GaZJXh79qcrUWrwxI2tHyfbqxn
 8qeveLfeSXVfWmh2ogBcu5uoTAHu00yxD6PcKnTeMxogv7+rL48AYnQ42xZrYs8VJu1vz5O
 7m53surKJnb9Ko87vJJqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sx6S7ypNQl0=:s491AXe6pIKVfNRewRM3I3
 vleCFjFIMqdffnv69k+6dDledCuxYvxNVPz7hqAXinF0lPFLeUHiIydEKk/Dp/oyLk3k4soCd
 op9K+0nhZZDXIOPphCfK8+scUThSEPZFhrlQRPeqv/EUiIMYbDL1ACm5etYApza1hficuyZZu
 W/CEJD9MhazaNOsGsNXAQ2punvdCzYuEFQfIZ6R34LPPve4cVek9Kg42+5rEbHjMuPqhIU3ux
 KuEqhhr+LyuVj054B693Pc4H3ZneOpSNqvcVkENfj+ipKXcJMK6M740aEFUrVY8iAcyFwNQuH
 8DRJ57UUw0opZu18FQNXdl/MRw211rjXpgGDNkEL06Vu01a57LK3JWqvWVPkpFcHvK8xLK5S9
 Rxm1A7cja7coZ1VmeTxIMXHGdY/J14Pd+ztXR9uycpV0sJudRPhBVmx6V+NaPo7s+FmIe9VMv
 oERGtbOF6LB83CMQLJ9HUHrmCsxK4FEvGuveFvCcSxpnjlWitPBCMjvRBJH5jU5Kmx3mTqHG/
 pNqqaESdUtd8OSt0/ta/vJ9Zh2WYUiWGdcRaZrfBh10VjGg/s4VgyCl4h9Vy7MYzqwTYVPXqe
 pXM2ZF2/EuvNRS10+Nhp8ym7DIptW7AN0VtNB5RRAjQFIGE0fh3zNWHnqc8xKBHw6LwtHN8y6
 r0Z/9k4VO5rt60tMLxS8/D+L4uIabl7tRUz8bjLnwVQiHp03S2tCTSs/aB2idUlYeOZ2TM0q4
 mMF/P5IlbzCnyEHU8E07zWszy61uw49QeWm9OK86Ig1UwyKHG/GMIQKdtXr6yYJDyhHu6cpFe
 Z8Wce78
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

Hello,

I have noticed by execution of another script for the semantic patch language
(Coccinelle software) that the function “clkdev_add_clkout” does not contain
null pointer checks after calls of the function “kzalloc”.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/mips/lantiq/xway/sysctrl.c?h=v4.10#n403

How do you think about to add corresponding checks and adjust the function
return type there?

Regards,
Markus
