Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2016 22:03:55 +0100 (CET)
Received: from mout.gmx.net ([212.227.15.19]:62953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013492AbcCIVDxblBXV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Mar 2016 22:03:53 +0100
Received: from [192.168.20.60] ([92.203.10.96]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MOwbP-1ak5zq2mIB-006KQm; Wed, 09 Mar 2016 22:03:37
 +0100
Subject: Re: [PATCH 2/2] PA-RISC: panic immediately when panic_on_oops
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
 <1457554123-18491-3-git-send-email-aaro.koskinen@iki.fi>
From:   Helge Deller <deller@gmx.de>
Message-ID: <56E08FA8.8050500@gmx.de>
Date:   Wed, 9 Mar 2016 22:03:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1457554123-18491-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:S1Hy/iGgboVZPdbvtZVMgjw12T/lIDpegZsDLbXwoSbZRJj54/F
 MLJjvTBnIU5L513Yk+vysRKTajgwH+sDLwFXxo3YRn1jNcnjb3ZkLm6uykufq8iLyF0wSjT
 0+J6RQQYINCti/k4Xj31nfvPifo3c7hmwt6eVQV1X7lQ6DmVPOcghRKerP/6QH5xB8K0RL+
 4f8l3zw9jNidzenT8W8QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQeGpgf06vM=:rC941a7Q6jMQaQvPPJA7Ps
 jN6OGsbs1Hn2+t/8oxJR0PtKnrS6g6ua8or+13dJG1hJvv4FP1le7cn1ybZfhmBFFdTRL/yXd
 mWYi6+gwgVZSd5gwpoRCTRwQoygrhOtgcCxl9R29ygCn1gWSuEd0r5AGW+55qnxR4agaTug6+
 lwXZHbQs+3gF3s1OKZ4g4+nnoPAPvbbFBuVIVL3I7sQ0dcKriSna1mD43l39nSJS2hRJKxVaj
 uJ2PpLGTvVPJPizVRFaNA/m4ea/kb4b+2eb2ypMGOYCAcOBSOo/zogDW9mAFETgsGnn8LSm7m
 L4A4l6RwXwbgy5KAAJtoar19QlZ4mZawC0EFVytSii06YXGW76DoHcL/36OTh8r2JasOHiTF5
 FilUxFCkSxldl6rG92gy6TR0VPYBeaXu5Eg5mCvLUIdMrkWSr7nrlpBOj6jGNl79+pvSRoWAD
 /BEnJA2cjssINDBV1WfhQcP25KMo3U1/fig0Ki4JdI0aOP4O23kr2/MnQs+0q8F1u15GkIQ8I
 nZ6IUaTa2sEcl6ThueECx4o59RKejZ7W9CXaIvE4IlTZKec+3aKoso8c74vpO8wHWaInMBLWZ
 LK4PswihX0LWlmZvKJN6qb9Ikml323KEoVqtmtiOBTJr5A8e5s1GLc2tRjPlSZ6zOGEdvkIYl
 hdrI1jIR8JdO02IyGSbkmrL7jTe2bw8PrJNBXaqoDBIG5A80PU2YC/Xo1qd396uJoHq55m+r/
 eu27+ee8ZOW8qMWIHd7tiZayAjExEAgKrHwKXgIOkCYzsYWrTzjZjEE9EZoLGtxOl6+kVUVr9
 0xRbMqd
Return-Path: <deller@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deller@gmx.de
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

On 09.03.2016 21:08, Aaro Koskinen wrote:
> PA-RISC wants to sleep 5 seconds before panicking when panic_on_oops
> is set, with no apparent reason. 

That's not completely true.
A few years back, when we had lots of crashes, it was very useful to at least
have some time to see the crash before the oops was cleaned from the screen.
Today the parisc port is really stable.

> Remove this feature, since some users
> may want their systems to fail as quickly as possible.
> 
> Users who want to delay reboot after panic can use PANIC_TIMEOUT.

That's OK.

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Helge Deller <deller@gmx.de>


> ---
>  arch/parisc/kernel/traps.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index 553b098..16e0735 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -284,11 +284,8 @@ void die_if_kernel(char *str, struct pt_regs *regs, long err)
>  	if (in_interrupt())
>  		panic("Fatal exception in interrupt");
>  
> -	if (panic_on_oops) {
> -		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
> -		ssleep(5);
> +	if (panic_on_oops)
>  		panic("Fatal exception");
> -	}
>  
>  	oops_exit();
>  	do_exit(SIGSEGV);
> 
