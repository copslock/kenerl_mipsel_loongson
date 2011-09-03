Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2011 15:47:14 +0200 (CEST)
Received: from exchange.solarflare.com ([216.237.3.220]:15333 "EHLO
        exchange.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab1ICNrH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Sep 2011 15:47:07 +0200
Received: from [192.168.4.185] ([88.96.1.126]) by exchange.solarflare.com with Microsoft SMTPSVC(6.0.3790.4675);
         Sat, 3 Sep 2011 06:46:55 -0700
Subject: Re: [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
From:   Ben Hutchings <bhutchings@solarflare.com>
To:     Jiri Pirko <jpirko@redhat.com>
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org, fubar@us.ibm.com,
        andy@greyhouse.net, kaber@trash.net, bprakash@broadcom.com,
        JBottomley@parallels.com, robert.w.love@intel.com,
        davem@davemloft.net, shemminger@linux-foundation.org,
        decot@google.com, mirq-linux@rere.qmqm.pl,
        alexander.h.duyck@intel.com, amit.salecha@qlogic.com,
        eric.dumazet@gmail.com, therbert@google.com,
        paulmck@linux.vnet.ibm.com, laijs@cn.fujitsu.com,
        xiaosuo@gmail.com, greearb@candelatech.com, loke.chetan@gmail.com,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        devel@open-fcoe.org, bridge@lists.linux-foundation.org
Date:   Sat, 03 Sep 2011 14:46:47 +0100
In-Reply-To: <20110903133428.GA2821@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
         <20110902122630.GC1991@minipsycho> <1314989161.3419.5.camel@bwh-desktop>
         <20110903133428.GA2821@minipsycho>
Organization: Solarflare Communications
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.2- 
Content-Transfer-Encoding: 7bit
Message-ID: <1315057614.3092.160.camel@deadeye>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Sep 2011 13:46:55.0806 (UTC) FILETIME=[F1BCADE0:01CC6A3F]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.500.1024-18362.005
X-TM-AS-Result: No--5.126500-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-archive-position: 31037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhutchings@solarflare.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1891

On Sat, 2011-09-03 at 15:34 +0200, Jiri Pirko wrote:
> This patch does several things:
> - introduces __ethtool_get_settings which is called from ethtool code and
>   from drivers as well. Put ASSERT_RTNL there.
> - dev_ethtool_get_settings() is replaced by __ethtool_get_settings()
> - changes calling in drivers so rtnl locking is respected. In
>   iboe_get_rate was previously ->get_settings() called unlocked. This
>   fixes it. Also prb_calc_retire_blk_tmo() in af_packet.c had the same
>   problem. Also fixed by calling __dev_get_by_index() instead of
>   dev_get_by_index() and holding rtnl_lock for both calls.
> - introduces rtnl_lock in bnx2fc_vport_create() and fcoe_vport_create()
>   so bnx2fc_if_create() and fcoe_if_create() are called locked as they
>   are from other places.
> - use __ethtool_get_settings() in bonding code
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
Reviewed-by: Ben Hutchings <bhutchings@solarflare.com> [except FCoE bits]

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
