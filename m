Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 03:34:27 +0200 (CEST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:43284 "HELO
	topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S1122977AbSIDBe0>; Wed, 4 Sep 2002 03:34:26 +0200
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; 4 Sep 2002 01:34:25 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id A7E41B471; Wed,  4 Sep 2002 10:34:17 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA74293; Wed, 4 Sep 2002 10:34:17 +0900 (JST)
Date: Wed, 04 Sep 2002 10:36:01 +0900 (JST)
Message-Id: <20020904.103601.74754748.nemoto@toshiba-tops.co.jp>
To: werkt@csh.rit.edu
Cc: linux-mips@linux-mips.org
Subject: Re: root-nfs hang and error
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3D752698.5040907@csh.rit.edu>
References: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu>
	<20020903.163711.104027127.nemoto@toshiba-tops.co.jp>
	<3D752698.5040907@csh.rit.edu>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 71
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Tue, 03 Sep 2002 17:16:08 -0400, George Gensure <werkt@csh.rit.edu> said:
werkt> I have no idea why this kernel is able to mount nfs partitions
werkt> in the install, but not at boot time.

On install, rootfs is ramdisk and you will be prompted network
parameters by the installer.  On diskless boot, kernel ip pnp will be
used to configure network.  So "ip=" and "nfsroot=" options may be
required on diskless boot.  But I do not know how to specify these
options on Indy boot loader.

---
Atsushi Nemoto
