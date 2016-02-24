Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 19:58:25 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33517 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013144AbcBXS6XUrLmA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 19:58:23 +0100
Received: by mail-pa0-f66.google.com with SMTP id y7so1392532paa.0
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 10:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tiJBXwmRVf+7TH4FMx5wP0UhuDXFNd6VSRRA3zOOr24=;
        b=G97ny6dOrUwHUbWLZF20HJFLh0mvvA8d7UKO6CwpeiZIZBu9PL7NDrtbYUkfdNE6L/
         owrNjuMN0MH7X1tUV0UIfea1Ebj8akgXVpQRvv+VCurRLczmmOG/qvRJH8f0HRgzyqcO
         Facpv7y7GfRhsiZ45XeagB148yrbpMDx/RVgmikNcs2uSTjF6xZVEHLebnmVG8zd5uAz
         BX2UQAw3m0X9ZInStLpT4D3BN3Brkyor4Z+VP6Z6RDhFdnPiMtEyWTcEeQoha1djwQdW
         MjID5pQj7UkJyOoujfkvUsyCV1jzHMJt5N1JPdD+wbvqKFKBbuj7kPYVT3tutJC2wa8F
         gP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tiJBXwmRVf+7TH4FMx5wP0UhuDXFNd6VSRRA3zOOr24=;
        b=mJq6RSco5roNhxOenCe/cuTL5j2lidJXy88nZOxxcoV0OjGUlvf/RJRcjfpzslBvgH
         OnDaQ6FXEZpLYNycABbUfnyxQplVuajC1hSBzbedHutQlj9zPV346wnMCryKD4oVb6ww
         6gBcuZ/FzjGtVzrjnSdmx/sfFcZY7ssKQOfBRLBzI+QzmgiEpedv7zQPXlqMZCZtC5T2
         MmjUnE+syJWQy97lQMZ828hhoe+zvGWL5JxSsPMideZGnPXxcAUyYA5ePaey8FAsg9BD
         NSJ5QGuqlSalLpgRHQfi9H1WPebm2mGxTPL5ofqG7wC+k0M9YPsoMP3MJ1s2dAz3tz3K
         4ulA==
X-Gm-Message-State: AG10YORREMzju14tW9ES7SLBwlaQ06HiDDvj+hQS7kS8W1PcHjHZiKMtwO6kQqWQC9VHow==
X-Received: by 10.67.7.197 with SMTP id de5mr20576237pad.105.1456340297039;
        Wed, 24 Feb 2016 10:58:17 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id fl9sm6726317pab.30.2016.02.24.10.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 10:58:16 -0800 (PST)
From:   David Decotigny <ddecotig@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben@decadent.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mips@linux-mips.org,
        fcoe-devel@open-fcoe.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eugenia Emantayev <eugenia@mellanox.co.il>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Ido Shamay <idos@mellanox.com>, Joe Perches <joe@perches.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Venkata Duvvuru <VenkatKumar.Duvvuru@Emulex.Com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Pravin B Shelar <pshelar@nicira.com>,
        Ed Swierk <eswierk@skyportsystems.com>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kan.liang@intel.com, vidya@cumulusnetworks.com,
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v9 00/16] new ETHTOOL_GLINKSETTINGS/SLINKSETTINGS API
Date:   Wed, 24 Feb 2016 10:57:56 -0800
Message-Id: <1456340292-26003-1-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddecotig@gmail.com
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

From: David Decotigny <decot@googlers.com>


History:
 v9
 - add 'link' in macro, struct and function names
 - rename ethtool_link_ksettings::parent -> ::base
 - remove un-needed mlx4 en_dbg_enabled() companion patch
 - note: bitmap u32[] API patches were merged separately by Kan Liang
 v8
 - bitmap u32 API returns number of bits copied, unit tests updated
 v7
 - module_exit in test_bitmap
 v6
 - fix copy_from_user in user/kernel handshake
 v5
 note: please see v4 bullets for a question regarding bitmap.c
 - minor fix to make allyesconfig/allmodconfig
 v4
 - removed typedef for link mode bitmaps
 - moved bitmap<->u32[] conversion routines to bitmap.c . This is the
   naive implementation. I have an endian-aware version that uses
   memcpy/memset as much as possible, but I find it harder to follow
   (see http://paste.ubuntu.com/13863722/). Please let me know if I
   should use it instead.
 - fixes suggested by Ben Hutchings
 v3
 - rebased v2 on top of latest net-next, minor checkpatch/printf %*pb
   updates
 v2
 - keep return 0 in get_settings when successful, instead of
   propagating positive result from driver's get_settings callback.
 v1
 - original submission


The main goal of this series is to support ethtool link mode masks
larger than 32 bits. It implements a new ioctl pair
(ETHTOOL_GLINKSETTINGS/SLINKSETTINGS), its associated callbacks
(get/set_link_ksettings) and a new struct ethtool_link_settings, which
should eventually replace legacy ethtool_cmd. Internally, the kernel
uses fixed length link mode masks defined at compilation time in
ethtool.h (for now: 31 bits), that can be increased by changing
__ETHTOOL_LINK_MODE_LAST in ethtool.h (absolute max is 4064 bits,
checked at compile time), and the user/kernel interface allows this
length to be arbitrary within 1..4064. This should allow some
flexibility without using too much heap/stack space, at the cost of a
small kernel/user handshake for the user to determine the sizes of
those bitmaps.

Along the way, I chose to drop in the new structure the 3 ethtool_cmd
fields marked "deprecated" (transceiver/maxrxpkt/maxtxpkt). They are
still available for old drivers via the (old) ETHTOOL_GSET/SSET API,
but are not available to drivers that switch to new API. Of those 3
fields, ethtool_cmd::transceiver seems to be still actively used by
several drivers, maybe we should not consider this field deprecated?
The 2 other fields are basically not used. This transition requires
some care in the way old and new ethtool talk to the kernel.

More technical details provided in the description for main patch. In
particular details about backward compatibility properties.

Some open questions:
 - the kernel/interface multiplexes the "tell me the bitmap length"
   handshake and the "give me the settings" inside the new
   ETHTOOL_GLINKSETTINGS cmd. I was thinking of making this into 2
   separate cmds: 1 cmd ETHTOOL_GKERNELPROPERTIES which would be
   kernel-wide rather than device-specific, would return properties
   like "length of the link mode bitmaps", and possibly others. And
   ETHTOOL_GLINKSETTINGS would expect the proper bitmaps
 - the link mode bitmaps are piggybacked at tail of the new struct
   ethtool_link_settings. Since its user-visible definition does not
   assume specific bitmap width, I am using a 0-length array as the
   publicly visible placeholder. But then, the kernel needs to
   specialize it (struct ethtool_link_ksettings) to specify its
   current link mode masks. This means that kernel code is "littered"
   with "ksettings->base.field" to access "field" inside
   ethtool_settings:
   + I could use ethtool_link_settings everywhere (instead of a new
     ethtool_ksettings) and an container_of accessor (or a plain cast)
     to retrieve the link mode masks?
   + or: we could decide to make the link mode masks statically
     bounded again, ie. make their width public, but larger than
     current 32, and unchangeable forever. This would make everything
     straightforward, but we might hit limits later, or have an
     unneeded memory/stack usage for unused bits.
   any preference?
 - I foresee bugs where people use the legacy/deprecated SUPPORTED_x
   macros instead of the new ETHTOOL_LINK_MODE_x_BIT enums in the new
   get/set_link_ksettings callbacks. Not sure how to prevent problems
   with this.

The only driver which was converted for now is mlx4. I am not
considering fcoe as fully converted, but I updated it a minima to be
able to remove __ethtool_get_settings, now known as
__ethtool_get_link_ksettings.

Tested with legacy and "future" ethtool on 64b x86 kernel and 32+64b
ethtool, and on a 32b x86 kernel + 32b ethtool.

############################################
# Patch Set Summary:

David Decotigny (16):
  net: usnic: remove unused call to ethtool_ops::get_settings
  net: usnic: use __ethtool_get_settings
  net: ethtool: add new ETHTOOL_xLINKSETTINGS API
  tx4939: use __ethtool_get_ksettings
  net: usnic: use __ethtool_get_ksettings
  net: bonding: use __ethtool_get_ksettings
  net: ipvlan: use __ethtool_get_ksettings
  net: macvlan: use __ethtool_get_ksettings
  net: team: use __ethtool_get_ksettings
  net: fcoe: use __ethtool_get_ksettings
  net: rdma: use __ethtool_get_ksettings
  net: 8021q: use __ethtool_get_ksettings
  net: bridge: use __ethtool_get_ksettings
  net: core: use __ethtool_get_ksettings
  net: ethtool: remove unused __ethtool_get_settings
  net: mlx4: use new ETHTOOL_G/SSETTINGS API

 arch/mips/txx9/generic/setup_tx4939.c           |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  10 +-
 drivers/net/bonding/bond_main.c                 |  14 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 357 ++++++++++---------
 drivers/net/ethernet/mellanox/mlx4/en_main.c    |   1 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |   1 +
 drivers/net/ipvlan/ipvlan_main.c                |   8 +-
 drivers/net/macvlan.c                           |   8 +-
 drivers/net/team/team.c                         |   8 +-
 drivers/scsi/fcoe/fcoe_transport.c              |  36 +-
 include/linux/ethtool.h                         |  87 ++++-
 include/rdma/ib_addr.h                          |  14 +-
 include/uapi/linux/ethtool.h                    | 322 +++++++++++++----
 net/8021q/vlan_dev.c                            |   8 +-
 net/bridge/br_if.c                              |   6 +-
 net/core/ethtool.c                              | 446 +++++++++++++++++++++++-
 net/core/net-sysfs.c                            |  15 +-
 net/packet/af_packet.c                          |  11 +-
 18 files changed, 1032 insertions(+), 327 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
