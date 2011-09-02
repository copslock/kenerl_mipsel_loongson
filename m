Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2011 20:46:20 +0200 (CEST)
Received: from exchange.solarflare.com ([216.237.3.220]:16994 "EHLO
        exchange.solarflare.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491088Ab1IBSqP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2011 20:46:15 +0200
Received: from [10.17.20.137] ([10.17.20.137]) by exchange.solarflare.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 2 Sep 2011 11:46:07 -0700
Subject: Re: [patch net-next-2.6 v2] net: consolidate and fix
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
In-Reply-To: <20110902122630.GC1991@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
         <20110902122630.GC1991@minipsycho>
Content-Type: text/plain; charset="UTF-8"
Organization: Solarflare Communications
Date:   Fri, 02 Sep 2011 19:46:01 +0100
Message-ID: <1314989161.3419.5.camel@bwh-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Sep 2011 18:46:07.0494 (UTC) FILETIME=[935D2260:01CC69A0]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.500.1024-18360.005
X-TM-AS-Result: No--7.381000-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-archive-position: 31033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhutchings@solarflare.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1592

On Fri, 2011-09-02 at 14:26 +0200, Jiri Pirko wrote:
> This patch does several things:
> - introduces __ethtool_get_settings which is called from ethtool code and
>   from dev_ethtool_get_settings() as well.
> - dev_ethtool_get_settings() becomes rtnl wrapper for
>   __ethtool_get_settings()
[...]

I don't like this locking change.  Most other dev_*() functions require
the caller to hold RTNL, and it will break any OOT module calling
dev_ethtool_get_settings() without producing any warning at compile
time.  Why not put an ASSERT_RTNL() in it instead?

The rest of this looks fine.

Ben. 

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
