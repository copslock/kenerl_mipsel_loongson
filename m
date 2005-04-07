Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 15:06:27 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:7015 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225209AbVDGOGC>; Thu, 7 Apr 2005 15:06:02 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 10:01:51 -0400
Message-ID: <42553E49.7080004@timesys.com>
Date:	Thu, 07 Apr 2005 10:06:01 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: another 4kc machine check.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 14:01:51.0640 (UTC) FILETIME=[59131980:01C53B7A]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is the malta branch with the tlb patch from Ralf applied. The LTP test:


-bash-2.05b# shmem_test_06
shmem_test_06: IPC Shared Memory TestSuite program
 
        mykey to uniquely identify the shared memory segment 0x330b035a
 
...
       
        Detach from the segment using the shmdt subroutine
 
        Release shared memory
 

causes:

timesys-bsp login: Got mcheck at 802199bc
Cpu 0
$ 0   : 00000000 1000fc00 00000004 00000000
$ 4   : 80401d30 00020004 c0002034 803e5964
$ 8   : 803e598c 00000000 fffffffa 8299f470
$12   : 00000001 000000ff 00000000 00000000
$16   : 80400000 00020004 82d15720 82d15724
$20   : 60100000 803e5964 8337dd38 00000000
$24   : 00000000 8014e6a4
$28   : 82d3e000 82d3fe38 10021a80 8021d314
Hi    : d3c9c18f
Lo    : 7263fc03
epc   : 802199bc ipc_lock+0x14/0x54     Not tainted
ra    : 8021d314 shm_close+0x5c/0x11c
Status: 1020fc03    KERNEL EXL IE
Cause : 00800060
PrId  : 00018001
                
Kernel panic - not syncing: Caught Machine Check exception - caused by 
multiple matching entries in the TLB.
                            
To run this test I have a different config from the default malta.
[gweeks@tanith linux]$ diff -du arch/mips/configs/malta_defconfig .config
--- arch/mips/configs/malta_defconfig   2005-03-18 12:36:52.000000000 -0500
+++ .config     2005-04-07 09:42:47.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.12-rc1
-# Fri Mar 18 15:41:40 2005
+# Thu Apr  7 09:42:47 2005
 #
 CONFIG_MIPS=y
 
@@ -18,7 +18,7 @@
 CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
@@ -158,6 +158,7 @@
 # CONFIG_PAGE_SIZE_16KB is not set
 # CONFIG_PAGE_SIZE_64KB is not set
 CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_BOARD_HAS_MEMCPY_PREFETCH_BUG=y
 # CONFIG_64BIT_PHYS_ADDR is not set
 # CONFIG_CPU_ADVANCED is not set
 CONFIG_CPU_HAS_LLSC=y
@@ -187,7 +188,7 @@
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
+CONFIG_BINFMT_MISC=y
 CONFIG_TRAD_SIGNALS=y
 
 #
@@ -394,8 +395,7 @@
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
-CONFIG_DM_MULTIPATH=m
-CONFIG_DM_MULTIPATH_EMC=m
+# CONFIG_DM_MULTIPATH is not set
 
 #
 # Fusion MPT device support
@@ -663,7 +663,7 @@
 CONFIG_NET_QOS=y
 CONFIG_NET_ESTIMATOR=y
 CONFIG_NET_CLS=y
-CONFIG_NET_CLS_BASIC=m
+# CONFIG_NET_CLS_BASIC is not set
 CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_ROUTE=y
@@ -1006,10 +1006,13 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
+CONFIG_DEVFS_FS=y
+# CONFIG_DEVFS_MOUNT is not set
+# CONFIG_DEVFS_DEBUG is not set
 CONFIG_DEVPTS_FS_XATTR=y
 CONFIG_DEVPTS_FS_SECURITY=y
-# CONFIG_TMPFS is not set
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
 
@@ -1138,7 +1141,7 @@
 CONFIG_CRYPTO_SHA256=m
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
+# CONFIG_CRYPTO_TGR192 is not set
 CONFIG_CRYPTO_DES=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_TWOFISH=m
[gweeks@tanith linux]$
