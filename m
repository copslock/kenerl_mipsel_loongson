Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2011 22:43:34 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:18215 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491090Ab1IBUn1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2011 22:43:27 +0200
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p82Kgi9i026887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 2 Sep 2011 16:42:45 -0400
Received: from localhost ([10.3.113.8])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p82KgfVd021649;
        Fri, 2 Sep 2011 16:42:42 -0400
Date:   Fri, 2 Sep 2011 22:42:41 +0200
From:   Jiri Pirko <jpirko@redhat.com>
To:     Ben Hutchings <bhutchings@solarflare.com>
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
Subject: Re: [patch net-next-2.6 v2] net: consolidate and fix
 ethtool_ops->get_settings calling
Message-ID: <20110902204239.GA14802@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
 <20110902122630.GC1991@minipsycho>
 <1314989161.3419.5.camel@bwh-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314989161.3419.5.camel@bwh-desktop>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-archive-position: 31034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jpirko@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1678

Fri, Sep 02, 2011 at 08:46:01PM CEST, bhutchings@solarflare.com wrote:
>On Fri, 2011-09-02 at 14:26 +0200, Jiri Pirko wrote:
>> This patch does several things:
>> - introduces __ethtool_get_settings which is called from ethtool code and
>>   from dev_ethtool_get_settings() as well.
>> - dev_ethtool_get_settings() becomes rtnl wrapper for
>>   __ethtool_get_settings()
>[...]
>
>I don't like this locking change.  Most other dev_*() functions require
>the caller to hold RTNL, and it will break any OOT module calling
>dev_ethtool_get_settings() without producing any warning at compile
>time.  Why not put an ASSERT_RTNL() in it instead?

Hmm. Okay, then I would remove dev_ethtool_get_settings() from
net/core/dev.c and only put __ethtool_get_settings() to
net/core/ethtool.c. Makes more sense to me to have it there...
ASSERT_RTNL woudl be good there as well.

>
>The rest of this looks fine.
>
>Ben. 
>
>-- 
>Ben Hutchings, Staff Engineer, Solarflare
>Not speaking for my employer; that's the marketing department's job.
>They asked us to note that Solarflare product names are trademarked.
>
