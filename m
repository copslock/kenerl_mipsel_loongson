Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 00:14:45 +0100 (CET)
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:34447 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993886AbdCFXOhTsNNr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 00:14:37 +0100
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v26NAUSE031721;
        Mon, 6 Mar 2017 17:14:26 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 291abe9mrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2017 17:14:25 -0600
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod3.natinst.com (8.16.0.17/8.16.0.17) with ESMTPS id v26NEOIn009693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2017 17:14:24 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Mon, 6 Mar 2017 17:14:24 -0600
Received: from nathan3500-linux-VM (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Mon, 6 Mar 2017 17:14:24 -0600
Date:   Mon, 6 Mar 2017 17:14:24 -0600
From:   Nathan Sullivan <nathan.sullivan@ni.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linus.walleij@linaro.org>, <gnurou@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: NI 169445 board support
Message-ID: <20170306231424.GA1503@nathan3500-linux-VM>
References: <1488830761-681-1-git-send-email-nathan.sullivan@ni.com>
 <1488830761-681-3-git-send-email-nathan.sullivan@ni.com>
 <20170306230413.GF2878@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170306230413.GF2878@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_23:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1702020001
 definitions=main-1703060185
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-03-06_23:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=30 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.0.1-1702020001 definitions=main-1703060185
Return-Path: <nathan.sullivan@ni.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nathan.sullivan@ni.com
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

On Mon, Mar 06, 2017 at 11:04:13PM +0000, James Hogan wrote:
> Hi Nathan,
> 
> On Mon, Mar 06, 2017 at 02:06:01PM -0600, Nathan Sullivan wrote:
> > Support the National Instruments 169445 board.
> > 
> > Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> > ---
> >  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
> >  arch/mips/boot/dts/Makefile                     |   1 +
> >  arch/mips/boot/dts/ni/169445.dts                | 101 ++++++++++++++++++++
> >  arch/mips/boot/dts/ni/Makefile                  |   7 ++
> >  arch/mips/configs/generic/board-ni169445.config | 117 ++++++++++++++++++++++++
> >  arch/mips/generic/Kconfig                       |   6 ++
> >  arch/mips/generic/vmlinux.its.S                 |  25 +++++
> >  7 files changed, 264 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
> >  create mode 100644 arch/mips/boot/dts/ni/169445.dts
> >  create mode 100644 arch/mips/boot/dts/ni/Makefile
> >  create mode 100644 arch/mips/configs/generic/board-ni169445.config
> > 
> 
> nice :)
> 
> I reckon an entry in MAINTAINERS listing the board specific
> files/directories would probably be worthwhile too.
> 

OK, will do.

> > diff --git a/arch/mips/configs/generic/board-ni169445.config b/arch/mips/configs/generic/board-ni169445.config
> > new file mode 100644
> > index 0000000..2c950a8
> > --- /dev/null
> > +++ b/arch/mips/configs/generic/board-ni169445.config
> > @@ -0,0 +1,117 @@
> > +CONFIG_MIPS_GENERIC=y
> > +CONFIG_FIT_IMAGE_FDT_NI169445=y
> > +CONFIG_CPU_LITTLE_ENDIAN=y
> > +CONFIG_CPU_MIPS32_R2=y
> > +CONFIG_HZ_100=y
> > +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
> > +# CONFIG_SWAP is not set
> > +CONFIG_SYSVIPC=y
> > +CONFIG_HZ_PERIODIC=y
> > +CONFIG_NO_HZ=y
> > +CONFIG_HIGH_RES_TIMERS=y
> > +CONFIG_IKCONFIG=y
> > +CONFIG_IKCONFIG_PROC=y
> > +CONFIG_LOG_BUF_SHIFT=15
> > +CONFIG_BPF_SYSCALL=y
> > +# CONFIG_SHMEM is not set
> > +CONFIG_USERFAULTFD=y
> > +CONFIG_EMBEDDED=y
> > +# CONFIG_COMPAT_BRK is not set
> > +CONFIG_SLAB=y
> > +CONFIG_PROFILING=y
> > +CONFIG_CC_STACKPROTECTOR_REGULAR=y
> > +# CONFIG_LBDAF is not set
> > +# CONFIG_BLK_DEV_BSG is not set
> > +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> > +# CONFIG_SUSPEND is not set
> > +CONFIG_NET=y
> > +CONFIG_PACKET=y
> > +CONFIG_UNIX=y
> > +CONFIG_INET=y
> > +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> > +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> > +# CONFIG_INET_XFRM_MODE_BEET is not set
> > +# CONFIG_INET_DIAG is not set
> > +# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
> > +# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
> > +CONFIG_NETFILTER=y
> > +CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
> > +CONFIG_IP_NF_IPTABLES=y
> > +CONFIG_IP_NF_FILTER=y
> > +CONFIG_IP6_NF_IPTABLES=y
> > +CONFIG_IP6_NF_FILTER=y
> > +# CONFIG_WIRELESS is not set
> > +CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> > +CONFIG_DEVTMPFS=y
> > +CONFIG_DEVTMPFS_MOUNT=y
> > +CONFIG_MTD=y
> > +CONFIG_MTD_CMDLINE_PARTS=y
> > +CONFIG_MTD_BLOCK_RO=y
> > +CONFIG_MTD_NAND=y
> > +CONFIG_MTD_NAND_ECC_BCH=y
> > +CONFIG_MTD_NAND_GPIO=y
> > +CONFIG_MTD_UBI=y
> > +CONFIG_MTD_UBI_BLOCK=y
> > +# CONFIG_BLK_DEV is not set
> > +CONFIG_NETDEVICES=y
> > +# CONFIG_NET_VENDOR_ALACRITECH is not set
> > +# CONFIG_NET_VENDOR_AMAZON is not set
> > +# CONFIG_NET_VENDOR_AQUANTIA is not set
> > +# CONFIG_NET_VENDOR_ARC is not set
> > +# CONFIG_NET_CADENCE is not set
> > +# CONFIG_NET_VENDOR_BROADCOM is not set
> > +# CONFIG_NET_VENDOR_EZCHIP is not set
> > +# CONFIG_NET_VENDOR_INTEL is not set
> > +# CONFIG_NET_VENDOR_MARVELL is not set
> > +# CONFIG_NET_VENDOR_MICREL is not set
> > +# CONFIG_NET_VENDOR_NATSEMI is not set
> > +# CONFIG_NET_VENDOR_NETRONOME is not set
> > +# CONFIG_NET_VENDOR_QUALCOMM is not set
> > +# CONFIG_NET_VENDOR_RENESAS is not set
> > +# CONFIG_NET_VENDOR_ROCKER is not set
> > +# CONFIG_NET_VENDOR_SAMSUNG is not set
> > +# CONFIG_NET_VENDOR_SEEQ is not set
> > +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> > +# CONFIG_NET_VENDOR_SMSC is not set
> > +CONFIG_STMMAC_ETH=y
> > +CONFIG_DWMAC_DWC_QOS_ETH=y
> > +# CONFIG_NET_VENDOR_VIA is not set
> > +# CONFIG_NET_VENDOR_WIZNET is not set
> > +# CONFIG_NET_VENDOR_XILINX is not set
> > +# CONFIG_WLAN is not set
> > +# CONFIG_INPUT_KEYBOARD is not set
> > +# CONFIG_INPUT_MOUSE is not set
> > +# CONFIG_SERIO is not set
> > +# CONFIG_VT is not set
> > +CONFIG_LEGACY_PTY_COUNT=32
> > +CONFIG_SERIAL_8250=y
> > +# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> > +CONFIG_SERIAL_8250_CONSOLE=y
> > +CONFIG_SERIAL_8250_NR_UARTS=2
> > +CONFIG_SERIAL_8250_RUNTIME_UARTS=2
> > +CONFIG_SERIAL_OF_PLATFORM=y
> > +# CONFIG_PTP_1588_CLOCK is not set
> > +CONFIG_GPIOLIB=y
> > +CONFIG_GPIO_SYSFS=y
> > +CONFIG_GPIO_GENERIC_PLATFORM=y
> > +# CONFIG_HWMON is not set
> > +# CONFIG_HID is not set
> > +# CONFIG_USB_SUPPORT is not set
> > +# CONFIG_MIPS_PLATFORM_DEVICES is not set
> > +# CONFIG_IOMMU_SUPPORT is not set
> > +CONFIG_FANOTIFY=y
> > +CONFIG_UBIFS_FS=y
> > +CONFIG_SQUASHFS=y
> > +CONFIG_SQUASHFS_XATTR=y
> > +# CONFIG_SQUASHFS_ZLIB is not set
> > +CONFIG_SQUASHFS_LZO=y
> > +# CONFIG_NETWORK_FILESYSTEMS is not set
> > +CONFIG_PRINTK_TIME=y
> > +CONFIG_DEBUG_INFO=y
> > +CONFIG_DEBUG_INFO_REDUCED=y
> > +CONFIG_DEBUG_FS=y
> > +# CONFIG_SCHED_DEBUG is not set
> > +CONFIG_RCU_TRACE=y
> > +# CONFIG_FTRACE is not set
> > +# CONFIG_CRYPTO_ECHAINIV is not set
> > +# CONFIG_CRYPTO_HW is not set
> 
> I think this file is intended to be more minimal than a normal
> defconfig, only enabling hardware device drivers (and related options)
> and FIT IMAGE on top of the generic_defconfig and other snippets in this
> directory, e.g. have you seen the other board config examples here?
> 
> https://git.linux-mips.org/cgit/linux-mti.git/tree/arch/mips/configs/generic?h=eng
> 
> If specific generic kernel features are desired we should probably
> consider whether it makes sense to add them to the generic_defconfig so
> other generic boards can benefit.
> 
> Cheers
> James

I was a little confused here, I'll rewrite this by hand for v3 and follow the
examples. I see the intent now.

Thanks,
Nathan
