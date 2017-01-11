Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 15:31:14 +0100 (CET)
Received: from mout.kundenserver.de ([217.72.192.74]:55303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993889AbdAKObHOKlEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jan 2017 15:31:07 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MPXo9-1cNDCF0IBV-004gd2; Wed, 11 Jan 2017 15:30:58 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mips: update defconfigs for NF_CT_PROTO_DCCP/UDPLITE change
Date:   Wed, 11 Jan 2017 15:29:48 +0100
Message-Id: <20170111143054.410084-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:oR0yVATSCseZOTk1LWB01mwkCRCizrUC92LtCcNPDJAlC8OL8PI
 +4VM9jMwV895yolokaviWjs1+GMleOt7agmWBsFMK0wicghoQBWoE82+rOwxZ+hMtiJkAEA
 +/kHT2x6G7IAtQ71eLl5EXlEC/nfyUkssjvGxByUQDPmMsgUksYraADLYx+Lui/4motrQa4
 +XmN9qbi2UpJ0KRWs4S7g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hwmIfO/eNow=:MqrOsRlOha3rfvN2uPOgMj
 OdHHXR55Ku7L5vS9t35brlATUF5J57QHd1bJjHabEqIR9tgKFrePjDCNBC32cf0P6dylTn+E4
 Nf1txuVKrnXzsqBE40CUrsTDE+oMAUl/VbRCvAENdJPEofUOHYHrgunGy5Fk7go72AdaJyj0f
 AXi4hvuZ4rOBRlhyK2DHoy+CEeQzRXnDDOnANnmhl8gQUahdKbBJ7I7hTdRCupwbiBKMt4bZv
 ST+r3SCb0Gz1jRb40Plvsy1sM3eRWL3R6l2NqhmBfFyDCDaoVd6zMr4Gl+GFskuB3BG3lM1H5
 TaPINtNJ0PMH3wHzZJTIOlXFsNYezfxvJyvZDjuRvGkEUpwyNgJbSiui4xrYpx11RQ/uE96M/
 WbhkZBKsy2jo+vd3RXu7GyOlkc6yg8X7mbp4o4DvDZcJtza3PNpT0GUxzb1XAGhjhqQQpplml
 iMYBPrud82rteGtrvLj0mqf00JvdSBQLXi6BYOYxFJWOVmgyJWqULPcVwX7VOHdReaj660a/j
 hP1vkDnzlh8SzZ230j5aCKp2M0oE53LR8l/VazAitsM28k8r6EIvb079XD7Rza+9DnYI+xZae
 EDFhDZMqLmhvaJL2ji9MMnk+9XZfz70EbocHXaT/7lnPGWMzhq729WRgkccWNehvAxlFDLRL/
 Wkq7PgXtvW0+YgLqZxoxoRv8TVxDtdUsAomvKuA0CM0w2Svqkegi90QVd+sCZ16Ei7Nk=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

In linux-4.10-rc, NF_CT_PROTO_UDPLITE and NF_CT_PROTO_DCCP are bool
symbols instead of tristate, and kernelci.org reports a bunch of
warnings for this, like:

arch/mips/configs/malta_kvm_guest_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
arch/mips/configs/malta_defconfig:62:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
arch/mips/configs/malta_defconfig:63:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE
arch/mips/configs/ip22_defconfig:70:warning: symbol value 'm' invalid for NF_CT_PROTO_DCCP
arch/mips/configs/ip22_defconfig:71:warning: symbol value 'm' invalid for NF_CT_PROTO_UDPLITE

This changes all the MIPS defconfigs with these symbols to have them
built-in.

Fixes: 9b91c96c5d1f ("netfilter: conntrack: built-in support for UDPlite")
Fixes: c51d39010a1b ("netfilter: conntrack: built-in support for DCCP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/configs/ip22_defconfig            | 4 ++--
 arch/mips/configs/malta_defconfig           | 4 ++--
 arch/mips/configs/malta_kvm_defconfig       | 4 ++--
 arch/mips/configs/malta_kvm_guest_defconfig | 4 ++--
 arch/mips/configs/maltaup_xpa_defconfig     | 4 ++--
 arch/mips/configs/nlm_xlp_defconfig         | 2 +-
 arch/mips/configs/nlm_xlr_defconfig         | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 5d83ff755547..ec8e9684296d 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -67,8 +67,8 @@ CONFIG_NETFILTER_NETLINK_QUEUE=m
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 58d43f3c348d..078ecac071ab 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -59,8 +59,8 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index c8f7e2835840..e233f878afef 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -60,8 +60,8 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index d2f54e55356c..fbe085c328ab 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -59,8 +59,8 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/maltaup_xpa_defconfig
index 3d0d9cb9673f..2942610e4082 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -61,8 +61,8 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_DCCP=m
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index b496c25fced6..07d01827a973 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -110,7 +110,7 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 8e99ad807a57..f59969acb724 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -90,7 +90,7 @@ CONFIG_NETFILTER=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_UDPLITE=m
+CONFIG_NF_CT_PROTO_UDPLITE=y
 CONFIG_NF_CONNTRACK_AMANDA=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_H323=m
-- 
2.9.0
