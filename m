Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:51:09 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:50379 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835024Ab3FSVujFd05t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 23:50:39 +0200
Message-ID: <51C227AA.6060604@imgtec.com>
Date:   Wed, 19 Jun 2013 16:50:34 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>, Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH 3/3] MIPS: Only set cpu_has_mmips if SYS_SUPPORTS_MICROMIPS
References: <1369432450-13583-1-git-send-email-ddaney.cavm@gmail.com> <1369432450-13583-4-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369432450-13583-4-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.150.195]
X-SEF-Processed: 7_3_0_01192__2013_06_19_22_50_38
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 05/24/2013 04:54 PM, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
>
> As Jonas Gorske said in his patch:
>
>     Disable cpu_has_mmips for everything but SEAD3 and MALTA. Most of
>     these platforms are from before the micromips introduction, so they
>     are very unlikely to implement it.
>
>     Reduces an -Os compiled, uncompressed kernel image by 8KiB for
>     BCM63XX.
>
> This patch taks a different approach than his, we gate the runtime
> test for microMIPS by the config symbol SYS_SUPPORTS_MICROMIPS.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Jonas Gorski <jogo@openwrt.org>
> Cc: Steven J. Hill <Steven.Hill@imgtec.com>
>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
