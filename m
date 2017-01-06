Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 11:07:44 +0100 (CET)
Received: from smtp6-v.fe.bosch.de ([IPv6:2a03:cc00:ff0:100::2]:19350 "EHLO
        smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992328AbdAFKHiBv475 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 11:07:38 +0100
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.51])
        by imta24.fe.bosch.de (Postfix) with ESMTP id BB311D80217;
        Fri,  6 Jan 2017 11:07:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1483697252;
        bh=t8uHkQQj6pxf8AENVnNYCiV9YUs8vlnvOnQxlWegysg=; l=10;
        h=From:From:Reply-To:Sender;
        b=Yrw8PFSW2SyPym6uCGPxLWj2926GXefassrOwWmhO7zshOPPfFk7KDqzUeqtMsrhN
         BIc9K/qtZwL+wGuTEbshiB0nIRQ9gNVbZPwSnaLZJxpFewTVXnAGmcDXUgsw+LfiGM
         Y5615diMjlpo5O3Q1JBRaK3Du7nYl97X8punm1xI=
Received: from FE-MBX1027.de.bosch.com (vsgw24.fe.internet.bosch.com [10.4.98.24])
        by vsmta11.fe.internet.bosch.com (Postfix) with ESMTP id 9E7F42380DC7;
        Fri,  6 Jan 2017 11:07:32 +0100 (CET)
Received: from SGPMBX1022.APAC.bosch.com (10.187.56.72) by
 FE-MBX1027.de.bosch.com (10.3.230.85) with Microsoft SMTP Server (TLS) id
 15.0.1236.3; Fri, 6 Jan 2017 11:07:31 +0100
Received: from SGPMBX1023.APAC.bosch.com (10.187.56.73) by
 SGPMBX1022.APAC.bosch.com (10.187.56.72) with Microsoft SMTP Server (TLS) id
 15.0.1236.3; Fri, 6 Jan 2017 18:07:29 +0800
Received: from SGPMBX1023.APAC.bosch.com ([fe80::cd60:2f4f:4eb4:1f62]) by
 SGPMBX1023.APAC.bosch.com ([fe80::cd60:2f4f:4eb4:1f62%17]) with mapi id
 15.00.1236.000; Fri, 6 Jan 2017 18:07:29 +0800
From:   "Anurag Raghavan (RBEI/ETW11)" <Raghavan.Anurag@in.bosch.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "fcoe-devel@open-fcoe.org" <fcoe-devel@open-fcoe.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "uclinux-h8-devel@lists.sourceforge.jp" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "adi-buildroot-devel@lists.sourceforge.net" 
        <adi-buildroot-devel@lists.sourceforge.net>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "mmarek@suse.com" <mmarek@suse.com>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: ubi_io_read: error -74 (ECC error) 
Thread-Topic: ubi_io_read: error -74 (ECC error) 
Thread-Index: AdJoBJJKETho2dejQe2kjWYbADFj5A==
Date:   Fri, 6 Jan 2017 10:07:29 +0000
Message-ID: <38f0cfac3dbe4ea89da84c7fbf667833@SGPMBX1023.APAC.bosch.com>
Accept-Language: en-US, en-SG
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.169.232.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1679-8.0.0.1202-22804.006
X-TMASE-MatchedRID: fnyFuCT6NqmN5TTne9XhR2YNYtsE5knDckmQZ+s4FZRGMe+tDjQ3Fv0u
        b/xgdoFfauYhNh75zVOvoe+4rT18gxLmJd2F/yFuSL9eXW0wwTfmTPEuA2FKKbaOQnQU8q/2B//
        7Jx5rmIHQVBaFvEjqUcilNMkMiqBC3nJGLofAuDnd+fuf9kcapgtPZ6OOYtHx1JVSTP0E9d4nP8
        WWLvfAyJyNrvvsdE26RQAqTwz9sXjUBt3B2BOwCqMeXAXVN6QHsvpfLFIwKZmbKItl61J/yX2PY
        bDNMTe9KrauXd3MZDX/GUgSUFgwKkLN7j6Yw3BpfKv2GJjgtVxDQ6HrsXA93R2U4uXZ9rwQwL6S
        xPpr1/I=
Return-Path: <Raghavan.Anurag@in.bosch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Raghavan.Anurag@in.bosch.com
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

Hi All,

My appdata partition could not be mounted or where the partition was not able to be used. Anyone can help me to find out the root cause of this. What are the possibilities of this ubifs corruption. Any patched are available to fix this issue.

I am using the kernel version-30.3.5
Any kernel patches are available to solve this issue...??

Error logs:

[    1.797141] UBI error: ubi_io_read: error -74 (ECC error) while reading 253952 bytes from PEB 445:8192, read 253952 bytes
[    1.808274] UBIFS error (pid 491): ubifs_scan: corrupt empty space at LEB 489:233760
[    1.816037] UBIFS error (pid 491): ubifs_scanned_corruption: corruption at LEB 489:233760
[    1.828660] UBIFS error (pid 491): ubifs_scan: LEB 489 scanning failed
[    1.835215] UBIFS warning (pid 491): ubifs_ro_mode: switched to read-only mode, error -117
[    1.843502] UBIFS error (pid 491): make_reservation: cannot reserve 58 bytes in jhead 2, error -117
[    1.852569] UBIFS error (pid 491): do_writepage: cannot write page 0 of inode 76584, error -117
dpkg: error: unable to sync new file '/var/lib/dpkg/arch-new': Structure needs cleaning

Best regards

Raghavan Anurag
RBEI/ETW1  

Tel. +91(422)667-4001 | Mobil 9986968950
