Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2011 23:34:08 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:45567 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491758Ab1IOVd6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Sep 2011 23:33:58 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FLXkxj014300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 15 Sep 2011 17:33:46 -0400
Received: from localhost (unused-48-117.lga.redhat.com [10.15.48.117] (may be forged))
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p8FLXft4023012;
        Thu, 15 Sep 2011 17:33:41 -0400
Date:   Thu, 15 Sep 2011 17:33:39 -0400 (EDT)
Message-Id: <20110915.173339.254712565622264560.davem@redhat.com>
To:     jpirko@redhat.com
Cc:     netdev@vger.kernel.org, ralf@linux-mips.org, fubar@us.ibm.com,
        andy@greyhouse.net, kaber@trash.net, bprakash@broadcom.com,
        JBottomley@parallels.com, robert.w.love@intel.com,
        shemminger@linux-foundation.org, decot@google.com,
        bhutchings@solarflare.com, mirq-linux@rere.qmqm.pl,
        alexander.h.duyck@intel.com, amit.salecha@qlogic.com,
        eric.dumazet@gmail.com, therbert@google.com,
        paulmck@linux.vnet.ibm.com, laijs@cn.fujitsu.com,
        xiaosuo@gmail.com, greearb@candelatech.com, loke.chetan@gmail.com,
        linux-mips@linux-mips.org, linux-scsi@vger.kernel.org,
        devel@open-fcoe.org, bridge@lists.linux-foundation.org
Subject: Re: [patch net-next-2.6] net: consolidate and fix
 ethtool_ops->get_settings calling
From:   David Miller <davem@redhat.com>
In-Reply-To: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 31096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8143

From: Jiri Pirko <jpirko@redhat.com>
Date: Thu,  1 Sep 2011 21:28:24 +0200

> This patch does several things:
> - introduces __ethtool_get_settings which is called from ethtool code and
>   from dev_ethtool_get_settings() as well.
> - dev_ethtool_get_settings() becomes rtnl wrapper for
>   __ethtool_get_settings()
> - changes calling in drivers so rtnl locking is respected. In
>   iboe_get_rate was previously ->get_settings() called unlocked. This
>   fixes it
> - introduces rtnl_lock in bnx2fc_vport_create() and fcoe_vport_create()
>   so bnx2fc_if_create() and fcoe_if_create() are called locked as they
>   are from other places.
> - prb_calc_retire_blk_tmo() in af_packet.c was not calling get_settings
>   with rtnl_lock. So use dev_ethtool_get_settings here.
> - use __ethtool_get_settings() in bonding code
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>

Applied, thanks.
