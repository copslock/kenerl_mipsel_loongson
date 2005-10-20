Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 07:54:07 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:62216 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S8133380AbVJTGxr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 07:53:47 +0100
Received: from 10.10.64.121 by mms1.broadcom.com with SMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.0)); Wed, 19 Oct 2005 23:53:26 -0700
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Received: from mail-irva-8.broadcom.com ([10.10.64.221]) by
 mail-irva-1.broadcom.com (Post.Office MTA v3.5.3 release 223 ID#
 0-72233U7200L2200S0V35) with ESMTP id com for
 <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:53:23 -0700
Received: from mon-irva-10.broadcom.com (mon-irva-10.broadcom.com
 [10.10.64.171]) by mail-irva-8.broadcom.com (MOS 3.5.6-GR) with ESMTP
 id CAW10425; Wed, 19 Oct 2005 23:53:21 -0700 (PDT)
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-10.broadcom.com (8.9.1/8.9.1) with ESMTP
 id XAA27923 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005 23:53:21
 -0700 (PDT)
Received: from localhost.localdomain (ldt-sj3-054 [10.21.3.41]) by
 mail-sj1-5.sj.broadcom.com (8.12.9/8.12.9/SSF) with ESMTP id
 j9K6rKov008657 for <linux-mips@linux-mips.org>; Wed, 19 Oct 2005
 23:53:20 -0700 (PDT)
Received: (from adi@localhost) by localhost.localdomain (8.11.6/8.9.3)
 id j9K6rK023895 for linux-mips@linux-mips.org; Wed, 19 Oct 2005
 23:53:20 -0700
Date:	Wed, 19 Oct 2005 23:53:20 -0700
From:	"Andrew Isaacson" <adi@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH 0/12] bcm1480 support
Message-ID: <20051020065320.GA23857@broadcom.com>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-WSS-ID: 6F49E16C0684623261-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <adi@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@broadcom.com
Precedence: bulk
X-list: linux-mips

This patch set against git changeset d1a2855c2190 adds support for the
BCM1480 family of SiByte SoCs.  The following are supported:
 - BCM1255, BCM1280, BCM1455, BCM1480 dual and quad core chips
 - 4 on-chip cache-coherent GigE MACs
 - native PCI-X
 - HT/PCI-X tunnel
 - SMBus

as well as the usual assortment of flash, uarts, DDR DRAM, etc.

It also includes a sibyte headers update, some code cleanups, and a hack
to work around a missing firmware feature.

-andy
