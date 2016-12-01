Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2016 07:26:38 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:59322 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991061AbcLAG0arnXUc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Dec 2016 07:26:30 +0100
Subject: Re: [PATCH 1/2] lantiq: refresh default configuration
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <20161130225808.11620-1-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <77bb4180-4362-c138-7f1c-5bbe9625e8b8@phrozen.org>
Date:   Thu, 1 Dec 2016 07:26:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161130225808.11620-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 30/11/2016 23:58, Hauke Mehrtens wrote:
> Just generate a configuration based on this default configuration and
> store it again. This removed some old configuration options.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: John Crispin <john@phrozen.org>

> ---
>  arch/mips/configs/xway_defconfig | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
> index 8987846..0ccb642 100644
> --- a/arch/mips/configs/xway_defconfig
> +++ b/arch/mips/configs/xway_defconfig
> @@ -2,11 +2,11 @@ CONFIG_LANTIQ=y
>  CONFIG_XRX200_PHY_FW=y
>  CONFIG_CPU_MIPS32_R2=y
>  # CONFIG_COMPACTION is not set
> -# CONFIG_CROSS_MEMORY_ATTACH is not set
>  CONFIG_HZ_100=y
>  # CONFIG_SECCOMP is not set
>  # CONFIG_LOCALVERSION_AUTO is not set
>  CONFIG_SYSVIPC=y
> +# CONFIG_CROSS_MEMORY_ATTACH is not set
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_BLK_DEV_INITRD=y
>  # CONFIG_RD_GZIP is not set
> @@ -35,12 +35,10 @@ CONFIG_IP_ROUTE_MULTIPATH=y
>  CONFIG_IP_ROUTE_VERBOSE=y
>  CONFIG_IP_MROUTE=y
>  CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
> -CONFIG_ARPD=y
>  CONFIG_SYN_COOKIES=y
>  # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
>  # CONFIG_INET_XFRM_MODE_TUNNEL is not set
>  # CONFIG_INET_XFRM_MODE_BEET is not set
> -# CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  CONFIG_TCP_CONG_ADVANCED=y
>  # CONFIG_TCP_CONG_BIC is not set
> @@ -62,7 +60,6 @@ CONFIG_NETFILTER_XT_MATCH_MAC=m
>  CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
>  CONFIG_NETFILTER_XT_MATCH_STATE=m
>  CONFIG_NF_CONNTRACK_IPV4=m
> -# CONFIG_NF_CONNTRACK_PROC_COMPAT is not set
>  CONFIG_IP_NF_IPTABLES=m
>  CONFIG_IP_NF_FILTER=m
>  CONFIG_IP_NF_TARGET_REJECT=m
> @@ -151,9 +148,6 @@ CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_SCHED_DEBUG is not set
>  # CONFIG_FTRACE is not set
>  CONFIG_CMDLINE_BOOL=y
> -CONFIG_CRYPTO_MANAGER=m
>  CONFIG_CRYPTO_ARC4=m
> -# CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_CRC_ITU_T=m
>  CONFIG_CRC32_SARWATE=y
> -CONFIG_AVERAGE=y
> 
