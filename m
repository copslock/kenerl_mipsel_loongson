Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:29:47 +0100 (CET)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33851 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009890AbcBJA3pvCTXx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:29:45 +0100
Received: by mail-pa0-f66.google.com with SMTP id yy13so159628pab.1
        for <linux-mips@linux-mips.org>; Tue, 09 Feb 2016 16:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=eDnCVkEtGRkjUO60FOyDv9no8JNtFFSXFMdQ2StdQVk=;
        b=tbTlDD5sPwqctvUvspn1nhWAOdvq2KDZKSDvLW2OKkyKqxBET0cagVyXh2cs1NAYwq
         iAgSGyDlB9qde7qikP3BWbwwAVpyK4mTcfcX8df/OGqB8eHRtlUtpFXgC/l8W2S1VPyN
         lBUqkvnsWbBaMwAIsWMGz4S45ngUCMHsBi+7Fp1sKvs7arVK3Ub8GxWTUIRRMBFpCg43
         INz0141peMrFn4Kvf+305yVjyZ1cm0GWmr5ctfp++6hNXj1YBRmz/aAlahRts7be1qJD
         id4xZ99NLpr79Qlb/TRGROt/qgoueFWTLFerm3aJeitFUHUcz/mHxkpPVx+PFQ2J+VCh
         cX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eDnCVkEtGRkjUO60FOyDv9no8JNtFFSXFMdQ2StdQVk=;
        b=d+f8IqvAmko/aabxRpZMWdOkUlDsEtvzAicMN8JdkvuY1joFTqIx1iKJs4VbgY7lUP
         T+Cj2umjmYBQYe6jT4yx+M8thfBQkkNEYpYNromRVEqe4S4tB0Xfm2opSd4L2py1lCnF
         JpQx4gEvuKTSlBKmdIun/Dq30rlm5ZkY5DukMragCDE4sJ0nIDafzto7FqOxtsVGvdvw
         xX04x5uEB5OiMeSqYjP8oub7JFNduA0mqMSGMjE9qNHDFwIIQ97bOjGibGIjWU1D7c+e
         OK+DxEBwkO2EHOJu6Bt7OfVlUTMJYJaWaEUlaCufYQQwwEV99KatXe4+VxEvN3z57n4k
         JgJg==
X-Gm-Message-State: AG10YOQ3Q8YtumkCd3RtHbVONQ3s/LJBDqbjZGN/ntT4bR2P39ldHKKVRAEop47/zE3bPw==
X-Received: by 10.66.222.101 with SMTP id ql5mr54560723pac.144.1455064179836;
        Tue, 09 Feb 2016 16:29:39 -0800 (PST)
Received: from decotigny.mtv.corp.google.com ([172.18.64.159])
        by smtp.gmail.com with ESMTPSA id s90sm429295pfa.49.2016.02.09.16.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 16:29:38 -0800 (PST)
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
        David Decotigny <decot@googlers.com>
Subject: [PATCH net-next v8 00/19] new ETHTOOL_GSETTINGS/SSETTINGS API
Date:   Tue,  9 Feb 2016 16:29:09 -0800
Message-Id: <1455064168-5102-1-git-send-email-ddecotig@gmail.com>
X-Mailer: git-send-email 2.7.0.rc3.207.g0ac5344
Return-Path: <ddecotig@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51938
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
(ETHTOOL_GSETTINGS/SSETTINGS), its associated callbacks
(get/set_settings) and a new struct ethtool_settings, which should
eventually replace legacy ethtool_cmd. Internally, the kernel uses
fixed length link mode masks defined at compilation time in ethtool.h
(for now: 31 bits), that can be increased by changing
__ETHTOOL_LINK_MODE_LAST in ethtool.h (absolute max is 4064 bits,
checked at compile time), and the user/kernel interface allows this
length to be arbitrary within 1..4064. This should allow some
flexibility without using too much heap/stack space, at the cost of
a small kernel/user handshake for the user to determine the sizes of
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

Some questions to more experts than me:
 - the kernel/interface multiplexes the "tell me the bitmap length"
   handshake and the "give me the settings" inside the new
   ETHTOOL_GSETTINGS cmd. I was thinking of making this into 2
   separate cmds: 1 cmd ETHTOOL_GKERNELPROPERTIES which would be
   kernel-wide rather than device-specific, would return properties
   like "length of the link mode bitmaps", and possibly others. And
   ETHTOOL_GSETTINGS would expect the proper bitmaps
 - the link mode bitmaps are piggybacked at tail of the new struct
   ethtool_settings. Since its user-visible definition does not assume
   specific bitmap width, I am using a 0-length array as the publicly
   visible placeholder. But then, the kernel needs to specialize it
   (struct ethtool_ksettings) to specify its current link mode
   masks. This means that kernel code is "littered" with
   "ksettings->parent.field" to access "field" inside
   ethtool_settings:
   + I don't like the field name "parent", any suggestion welcome
   + and/or: I could use ethtool_settings everywhere (instead of a new
     ethtool_ksettings) and an accessor to retrieve the link mode
     masks?
   + or: we could decide to make the link mode masks statically
     bounded again, ie. make their width public, but larger than
     current 32, and unchangeable forever. This would make everything
     straightforward, but we might hit limits later, or have an
     unneeded memory/stack usage for unused bits.
   any preference?
 - I foresee bugs where people use the legacy/deprecated SUPPORTED_x
   macros instead of the new ETHTOOL_LINK_MODE_x_BIT enums in the new
   get/set__ksettings callbacks. Not sure how to prevent problems with
   this.

The only driver which was converted for now is mlx4. I am not
considering fcoe as fully converted, but I updated it a minima to be
able to remove __ethtool_get_settings, now known as
__ethtool_get_ksettings.

Tested with legacy and "future" ethtool on 64b x86 kernel and 32+64b
ethtool, and on a 32b x86 kernel + 32b ethtool.

############################################
# Patch Set Summary:

David Decotigny (19):
  lib/bitmap.c: conversion routines to/from u32 array
  test_bitmap: unit tests for lib/bitmap.c
  net: usnic: remove unused call to ethtool_ops::get_settings
  net: usnic: use __ethtool_get_settings
  net: ethtool: add new ETHTOOL_GSETTINGS/SSETTINGS API
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
  net: mlx4: convenience predicate for debug messages
  net: mlx4: use new ETHTOOL_G/SSETTINGS API

 arch/mips/txx9/generic/setup_tx4939.c           |   7 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  10 +-
 drivers/net/bonding/bond_main.c                 |  14 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 344 ++++++++++----------
 drivers/net/ethernet/mellanox/mlx4/en_main.c    |   1 +
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |   5 +-
 drivers/net/ipvlan/ipvlan_main.c                |   8 +-
 drivers/net/macvlan.c                           |   8 +-
 drivers/net/team/team.c                         |   8 +-
 drivers/scsi/fcoe/fcoe_transport.c              |  36 ++-
 include/linux/bitmap.h                          |  10 +
 include/linux/ethtool.h                         |  84 ++++-
 include/rdma/ib_addr.h                          |  14 +-
 include/uapi/linux/ethtool.h                    | 320 ++++++++++++++----
 lib/Kconfig.debug                               |   8 +
 lib/Makefile                                    |   1 +
 lib/bitmap.c                                    |  89 +++++
 lib/test_bitmap.c                               | 358 ++++++++++++++++++++
 net/8021q/vlan_dev.c                            |   8 +-
 net/bridge/br_if.c                              |   6 +-
 net/core/ethtool.c                              | 413 +++++++++++++++++++++++-
 net/core/net-sysfs.c                            |  15 +-
 net/packet/af_packet.c                          |  11 +-
 tools/testing/selftests/lib/Makefile            |   2 +-
 tools/testing/selftests/lib/bitmap.sh           |  10 +
 25 files changed, 1462 insertions(+), 328 deletions(-)
 create mode 100644 lib/test_bitmap.c
 create mode 100644 tools/testing/selftests/lib/bitmap.sh

-- 
2.7.0.rc3.207.g0ac5344
