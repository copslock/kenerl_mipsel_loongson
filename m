Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:01:25 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:47671 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6871404AbaBTOA0Jvr8G (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Feb 2014 15:00:26 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/5] MIPS: regenerate malta defconfigs
Date:   Thu, 20 Feb 2014 14:00:24 +0000
Message-ID: <1392904828-12969-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
References: <1392904828-12969-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_20_14_00_20
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

From: Paul Burton <paul.burton@imgtec.com>

This patch simply regenerates the malta defconfigs such that they don't
change after being used & saved as a defconfig again. ie. it is the
result of running the following:

for cfg in arch/mips/configs/malta*; do
	ARCH=mips make `basename ${cfg}`
	ARCH=mips make savedefconfig
	mv -v defconfig ${cfg}
done

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/configs/malta_defconfig           | 7 +------
 arch/mips/configs/malta_kvm_defconfig       | 9 ++-------
 arch/mips/configs/malta_kvm_guest_defconfig | 6 ------
 arch/mips/configs/maltaaprp_defconfig       | 2 --
 arch/mips/configs/maltasmtc_defconfig       | 2 --
 arch/mips/configs/maltasmvp_defconfig       | 1 -
 arch/mips/configs/maltaup_defconfig         | 2 --
 7 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index ce1d3ee..bc494b2 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -2,6 +2,7 @@ CONFIG_MIPS_MALTA=y
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_MIPS_MT_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
@@ -42,7 +43,6 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
@@ -68,7 +68,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
@@ -125,7 +124,6 @@ CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -185,7 +183,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_PHONET=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
@@ -228,7 +225,6 @@ CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_OOPS=m
 CONFIG_MTD_CFI=y
@@ -328,7 +324,6 @@ CONFIG_LIBERTAS=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HWMON is not set
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malta_kvm_defconfig
index 341bb47..041e41b 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -3,6 +3,7 @@ CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_CPU_MIPS32_R2=y
 CONFIG_PAGE_SIZE_16KB=y
 CONFIG_MIPS_MT_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_HZ_100=y
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
@@ -44,7 +45,6 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
@@ -70,7 +70,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
@@ -127,7 +126,6 @@ CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -187,7 +185,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_PHONET=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
@@ -230,7 +227,6 @@ CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_OOPS=m
 CONFIG_MTD_CFI=y
@@ -300,6 +296,7 @@ CONFIG_IFB=m
 CONFIG_MACVLAN=m
 CONFIG_TUN=m
 CONFIG_VETH=m
+CONFIG_VHOST_NET=m
 CONFIG_PCNET32=y
 CONFIG_CHELSIO_T3=m
 CONFIG_AX88796=m
@@ -329,7 +326,6 @@ CONFIG_LIBERTAS=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HWMON is not set
@@ -453,4 +449,3 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=m
 CONFIG_KVM_MIPS_DYN_TRANS=y
 CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS=y
-CONFIG_VHOST_NET=m
diff --git a/arch/mips/configs/malta_kvm_guest_defconfig b/arch/mips/configs/malta_kvm_guest_defconfig
index 2b8558b..bf186df 100644
--- a/arch/mips/configs/malta_kvm_guest_defconfig
+++ b/arch/mips/configs/malta_kvm_guest_defconfig
@@ -44,7 +44,6 @@ CONFIG_INET_IPCOMP=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
 CONFIG_INET_XFRM_MODE_TUNNEL=m
 CONFIG_TCP_MD5SIG=y
-CONFIG_IPV6_PRIVACY=y
 CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_ROUTE_INFO=y
 CONFIG_IPV6_OPTIMISTIC_DAD=y
@@ -70,7 +69,6 @@ CONFIG_NF_CONNTRACK_SANE=m
 CONFIG_NF_CONNTRACK_SIP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NF_CT_NETLINK=m
-CONFIG_NETFILTER_TPROXY=m
 CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
 CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
 CONFIG_NETFILTER_XT_TARGET_MARK=m
@@ -127,7 +125,6 @@ CONFIG_IP_VS_SH=m
 CONFIG_IP_VS_SED=m
 CONFIG_IP_VS_NQ=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_IP_NF_QUEUE=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
 CONFIG_IP_NF_MATCH_ECN=m
@@ -187,7 +184,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_PHONET=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
@@ -230,7 +226,6 @@ CONFIG_RFKILL=m
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_CONNECTOR=m
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_OOPS=m
 CONFIG_MTD_CFI=y
@@ -331,7 +326,6 @@ CONFIG_LIBERTAS=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
-CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HWMON is not set
diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
index 93057a7..90b1725 100644
--- a/arch/mips/configs/maltaaprp_defconfig
+++ b/arch/mips/configs/maltaaprp_defconfig
@@ -44,7 +44,6 @@ CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -55,7 +54,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
diff --git a/arch/mips/configs/maltasmtc_defconfig b/arch/mips/configs/maltasmtc_defconfig
index 4e54b75..991da9f 100644
--- a/arch/mips/configs/maltasmtc_defconfig
+++ b/arch/mips/configs/maltasmtc_defconfig
@@ -45,7 +45,6 @@ CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -56,7 +55,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
diff --git a/arch/mips/configs/maltasmvp_defconfig b/arch/mips/configs/maltasmvp_defconfig
index d759318..1dafe79 100644
--- a/arch/mips/configs/maltasmvp_defconfig
+++ b/arch/mips/configs/maltasmvp_defconfig
@@ -47,7 +47,6 @@ CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
index 9868fc9..b8a97a2 100644
--- a/arch/mips/configs/maltaup_defconfig
+++ b/arch/mips/configs/maltaup_defconfig
@@ -43,7 +43,6 @@ CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 # CONFIG_INET_LRO is not set
-CONFIG_IPV6_PRIVACY=y
 CONFIG_INET6_AH=m
 CONFIG_INET6_ESP=m
 CONFIG_INET6_IPCOMP=m
@@ -54,7 +53,6 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
 CONFIG_NET_SCH_HTB=m
-- 
1.8.5.5
