Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2009 00:49:54 +0000 (GMT)
Received: from fwtops.0.225.230.202.in-addr.arpa ([202.230.225.126]:5520 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S21369240AbZCRAtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2009 00:49:46 +0000
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2C63B42CE2;
	Wed, 18 Mar 2009 09:43:05 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 1FCE642B7A;
	Wed, 18 Mar 2009 09:43:05 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n2I0nZnf030763;
	Wed, 18 Mar 2009 09:49:36 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 18 Mar 2009 09:49:35 +0900 (JST)
Message-Id: <20090318.094935.238694196.nemoto@toshiba-tops.co.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
References: <e9c3a7c20903162152w6b73b4b8hba8004e7b349c447@mail.gmail.com>
	<20090318.010939.128619068.anemo@mba.ocn.ne.jp>
	<e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 17 Mar 2009 10:02:14 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> >> The sysfs device has a longer lifetime than dma_device.  See commit
> >> 41d5e59c [1].
> >
> > The sysfs device for dma_chan (dma_chan_dev) has a shorter lifetime
> > than dma_device, doesn't it?
> 
> No,  dma_async_device_unregister(), and the freeing of dma_device, may
> finish before chan_dev_release is called.  Userspace gates the final
> release of dma_chan_dev objects.

You mean, if the sysfs device file was opened when
dma_async_device_unregister() was called, the sysfs device will not be
released until the sysfs device file is closed, right?  If so I can
see.

BTW, there are another holes in dma_async_device_register.  If
idr_pre_get or idr_get_new was failed, idr_ref will not be freed.

---
Atsushi Nemoto
