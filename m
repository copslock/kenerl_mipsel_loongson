Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 16:59:09 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:57360 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20031179AbYENP7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 May 2008 16:59:07 +0100
Received: from [10.11.16.99] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Wed, 14 May 2008 08:58:53 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 33CD32B1; Wed, 14 May 2008 08:58:53 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.11.18.52]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 1EFCA2B0 for
 <linux-mips@linux-mips.org>; Wed, 14 May 2008 08:58:53 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id GWG81990; Wed, 14 May 2008 08:58:52 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com (nt-sjca-0752
 [10.16.192.222]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 9CFAB20502 for <linux-mips@linux-mips.org>; Wed, 14 May 2008 08:58:52
 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Enabling JFFS as Root FS
Date:	Wed, 14 May 2008 08:58:47 -0700
Message-ID: <E06E3B7BBC07864CADE892DAF1EB0FBD07CEB326@NT-SJCA-0752.brcm.ad.broadcom.com>
In-Reply-To: <20080514150859.GA9898@linux-mips.org>
Thread-Topic: Enabling JFFS as Root FS
Thread-Index: Aci11KF4yfiNBuzTQD66oHe+w/sTnAABd0Pw
References: <Pine.LNX.4.64.0805131444360.15369@wrl-59.cs.helsinki.fi>
 <20080513232507.GA24102@linux-mips.org>
 <20080513180225.194f400b.akpm@linux-foundation.org>
 <20080514150859.GA9898@linux-mips.org>
From:	"Ramgopal Kota" <rkota@broadcom.com>
To:	linux-mips@linux-mips.org
X-WSS-ID: 6435D3B74E010654696-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-Path: <rkota@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkota@broadcom.com
Precedence: bulk
X-list: linux-mips

Hi,

Currently I am having a kernel 2.6.14 with INIT_RAMFS and it is using
cpio archive to create the nodes and rootfs.

Now I want to have the rootfs (jffs) on flash. Is there any document
which tells me how to do that ?

I did the following ..

I created the rootfs directory say "embeddedroot" structure except /dev
directory and ran mkfs.jffs2 on "embeddedroot".

The .jffs2 image is loaded onto flash at the correct offset pointed in
the MTD partition structure as mtdblock2.

My basic doubt is , how the kernel will create a node in /dev in the
above case ? or is there any other way to make jffs as rootfs.

I am missing some thing , I will be glad if someone points me that.

Ramgopal Kota
