Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2017 17:54:47 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:55739 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993985AbdF1PxxPglu8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Jun 2017 17:53:53 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id CF2C01A47EE;
        Wed, 28 Jun 2017 17:53:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.domain.local (unknown [10.10.13.95])
        by mail.rt-rk.com (Postfix) with ESMTPSA id AD2651A47C6;
        Wed, 28 Jun 2017 17:53:47 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v2 10/10] MIPS: generic: Add optional support for Android kernel
Date:   Wed, 28 Jun 2017 17:47:03 +0200
Message-Id: <1498664922-28493-11-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

This commit adds new android.config configuration file including
the most common prerequisites for running Android operating system.

The selected set of platform independent configuration parameters
have been taken from the official Android kernel repo:
https://android.googlesource.com/kernel/common/+
/android-4.4/android/configs/android-base.cfg

android.config will be merged with the selected generic kernel
configuration only if explicitly specified through environment
variable OS=android.

Example:
make ARCH=mips 64r6el_defconfig BOARDS="list of boards" OS=android

android.config file should be occasionally revisited and updated
with latest requirements from Google.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 MAINTAINERS                              |   1 +
 arch/mips/Makefile                       |   8 +-
 arch/mips/configs/generic/android.config | 173 +++++++++++++++++++++++++++++++
 3 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/configs/generic/android.config

diff --git a/MAINTAINERS b/MAINTAINERS
index 35dfdd0..0b141eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10683,6 +10683,7 @@ M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
 L:	linux-mips@linux-mips.org
 S:	Supported
 F:	arch/mips/generic/board-ranchu.c
+F:	arch/mips/configs/generic/android.config
 
 RANDOM NUMBER DRIVER
 M:	"Theodore Ts'o" <tytso@mit.edu>
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 02a1787..bc96c39 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -448,7 +448,10 @@ define archhelp
 	echo '  If you are targeting a system supported by generic kernels you may'
 	echo '  configure the kernel for a given architecture target like so:'
 	echo
-	echo '  {micro32,32,64}{r1,r2,r6}{el,}_defconfig <BOARDS="list of boards">'
+	echo '  {micro32,32,64}{r1,r2,r6}{el,}_defconfig <BOARDS="list of boards"> <OS=android>'
+	echo
+	echo '  By setting OS=android, the generic kernel configuration will enable common'
+	echo '  prerequisites for running Android OS.'
 	echo
 	echo '  Otherwise, the following default configurations are available:'
 endef
@@ -488,7 +491,8 @@ $(eval $(call gen_generic_defconfigs,micro32,r2,eb el))
 $(generic_defconfigs):
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh \
 		-m -O $(objtree) $(srctree)/arch/$(ARCH)/configs/generic_defconfig $^ \
-		$(foreach board,$(BOARDS),$(generic_config_dir)/board-$(board).config)
+		$(foreach board,$(BOARDS),$(generic_config_dir)/board-$(board).config) \
+		$(foreach os,$(OS),$(generic_config_dir)/$(os).config)
 	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
 
 #
diff --git a/arch/mips/configs/generic/android.config b/arch/mips/configs/generic/android.config
new file mode 100644
index 0000000..8d0c93f
--- /dev/null
+++ b/arch/mips/configs/generic/android.config
@@ -0,0 +1,173 @@
+# CONFIG_DEVKMEM is not set
+# CONFIG_DEVMEM is not set
+# CONFIG_FHANDLE is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_SYSVIPC is not set
+# CONFIG_USELIB is not set
+CONFIG_ANDROID=y
+CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
+CONFIG_ANDROID_BINDER_IPC=y
+CONFIG_ANDROID_LOW_MEMORY_KILLER=y
+CONFIG_ASHMEM=y
+CONFIG_AUDIT=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_DEBUG=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUPS=y
+CONFIG_DEFAULT_SECURITY_SELINUX=y
+CONFIG_EMBEDDED=y
+CONFIG_FB=y
+CONFIG_HARDENED_USERCOPY=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_INET6_AH=y
+CONFIG_INET6_ESP=y
+CONFIG_INET6_IPCOMP=y
+CONFIG_INET=y
+CONFIG_INET_DIAG_DESTROY=y
+CONFIG_INET_ESP=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_IP6_NF_FILTER=y
+CONFIG_IP6_NF_IPTABLES=y
+CONFIG_IP6_NF_MANGLE=y
+CONFIG_IP6_NF_RAW=y
+CONFIG_IP6_NF_TARGET_REJECT=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_NF_ARP_MANGLE=y
+CONFIG_IP_NF_ARPFILTER=y
+CONFIG_IP_NF_ARPTABLES=y
+CONFIG_IP_NF_FILTER=y
+CONFIG_IP_NF_IPTABLES=y
+CONFIG_IP_NF_MANGLE=y
+CONFIG_IP_NF_MATCH_AH=y
+CONFIG_IP_NF_MATCH_ECN=y
+CONFIG_IP_NF_MATCH_TTL=y
+CONFIG_IP_NF_NAT=y
+CONFIG_IP_NF_RAW=y
+CONFIG_IP_NF_SECURITY=y
+CONFIG_IP_NF_TARGET_MASQUERADE=y
+CONFIG_IP_NF_TARGET_NETMAP=y
+CONFIG_IP_NF_TARGET_REDIRECT=y
+CONFIG_IP_NF_TARGET_REJECT=y
+CONFIG_IPV6=y
+CONFIG_IPV6_MIP6=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_IPV6_OPTIMISTIC_DAD=y
+CONFIG_IPV6_ROUTE_INFO=y
+CONFIG_IPV6_ROUTER_PREF=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
+CONFIG_NET=y
+CONFIG_NET_CLS_ACT=y
+CONFIG_NET_CLS_U32=y
+CONFIG_NET_EMATCH=y
+CONFIG_NET_EMATCH_U32=y
+CONFIG_NET_KEY=y
+CONFIG_NET_SCH_HTB=y
+CONFIG_NET_SCHED=y
+CONFIG_NETDEVICES=y
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_XT_MATCH_COMMENT=y
+CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
+CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
+CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
+CONFIG_NETFILTER_XT_MATCH_HELPER=y
+CONFIG_NETFILTER_XT_MATCH_IPRANGE=y
+CONFIG_NETFILTER_XT_MATCH_LENGTH=y
+CONFIG_NETFILTER_XT_MATCH_LIMIT=y
+CONFIG_NETFILTER_XT_MATCH_MAC=y
+CONFIG_NETFILTER_XT_MATCH_MARK=y
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
+CONFIG_NETFILTER_XT_MATCH_POLICY=y
+CONFIG_NETFILTER_XT_MATCH_QTAGUID=y
+CONFIG_NETFILTER_XT_MATCH_QUOTA2=y
+CONFIG_NETFILTER_XT_MATCH_QUOTA2_LOG=y
+CONFIG_NETFILTER_XT_MATCH_QUOTA=y
+CONFIG_NETFILTER_XT_MATCH_SOCKET=y
+CONFIG_NETFILTER_XT_MATCH_STATE=y
+CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
+CONFIG_NETFILTER_XT_MATCH_STRING=y
+CONFIG_NETFILTER_XT_MATCH_TIME=y
+CONFIG_NETFILTER_XT_MATCH_U32=y
+CONFIG_NETFILTER_XT_TARGET_CLASSIFY=y
+CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
+CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
+CONFIG_NETFILTER_XT_TARGET_MARK=y
+CONFIG_NETFILTER_XT_TARGET_NFLOG=y
+CONFIG_NETFILTER_XT_TARGET_NFQUEUE=y
+CONFIG_NETFILTER_XT_TARGET_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
+CONFIG_NETFILTER_XT_TARGET_TPROXY=y
+CONFIG_NETFILTER_XT_TARGET_TRACE=y
+CONFIG_NF_CONNTRACK=y
+CONFIG_NF_CONNTRACK_AMANDA=y
+CONFIG_NF_CONNTRACK_EVENTS=y
+CONFIG_NF_CONNTRACK_FTP=y
+CONFIG_NF_CONNTRACK_H323=y
+CONFIG_NF_CONNTRACK_IPV4=y
+CONFIG_NF_CONNTRACK_IPV6=y
+CONFIG_NF_CONNTRACK_IRC=y
+CONFIG_NF_CONNTRACK_NETBIOS_NS=y
+CONFIG_NF_CONNTRACK_PPTP=y
+CONFIG_NF_CONNTRACK_SANE=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NF_CONNTRACK_TFTP=y
+CONFIG_NF_CT_NETLINK=y
+CONFIG_NF_CT_PROTO_DCCP=y
+CONFIG_NF_CT_PROTO_SCTP=y
+CONFIG_NF_CT_PROTO_UDPLITE=y
+CONFIG_NF_NAT=y
+CONFIG_NO_HZ=y
+CONFIG_PACKET=y
+CONFIG_PM_AUTOSLEEP=y
+CONFIG_PM_WAKELOCKS=y
+CONFIG_PPP=y
+CONFIG_PPP_BSDCOMP=y
+CONFIG_PPP_DEFLATE=y
+CONFIG_PPP_MPPE=y
+CONFIG_PPPOLAC=y
+CONFIG_PPPOPNS=y
+CONFIG_PREEMPT=y
+CONFIG_PROFILING=y
+CONFIG_QFMT_V2=y
+CONFIG_QUOTA=y
+CONFIG_QUOTA_NETLINK_INTERFACE=y
+CONFIG_QUOTA_TREE=y
+CONFIG_QUOTACTL=y
+CONFIG_RANDOMIZE_BASE=y
+CONFIG_RT_GROUP_SCHED=y
+CONFIG_RTC_CLASS=y
+CONFIG_SECCOMP=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_PERF_EVENTS_RESTRICT=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SETEND_EMULATION=y
+CONFIG_STAGING=y
+CONFIG_SWP_EMULATION=y
+CONFIG_SYNC=y
+CONFIG_TASK_IO_ACCOUNTING=y
+CONFIG_TASK_XACCT=y
+CONFIG_TASKSTATS=y
+CONFIG_TUN=y
+CONFIG_UID_SYS_STATS=y
+CONFIG_UNIX=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_F_ACC=y
+CONFIG_USB_CONFIGFS_F_AUDIO_SRC=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_USB_CONFIGFS_F_MIDI=y
+CONFIG_USB_CONFIGFS_F_MTP=y
+CONFIG_USB_CONFIGFS_F_PTP=y
+CONFIG_USB_CONFIGFS_UEVENT=y
+CONFIG_USB_GADGET=y
+CONFIG_XFRM_USER=y
-- 
2.7.4
