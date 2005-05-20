Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2005 14:24:34 +0100 (BST)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:21221 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8226391AbVETNYR>; Fri, 20 May 2005 14:24:17 +0100
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id j4KDOfe0005540
	for <linux-mips@linux-mips.org>; Fri, 20 May 2005 15:24:41 +0200
Received: from unknown by gateway id /var/KryptoWall/smtpp/kwuqYR6S; Fri May 20 15:24:24 2005
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id KW3LV1QA; Fri, 20 May 2005 15:23:53 +0200
From:	Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To:	"Linux/MIPS Development" <linux-mips@linux-mips.org>,
	linux-kernel@vger.kernel.org
Subject: vmap() problem, possible bug?
Date:	Fri, 20 May 2005 15:23:52 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Message-Id: <200505201523.52194.thomas.koeller@baslerweb.com>
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi,

writing a device driver I came across something that looks
to me like a bug in the vmap() function. I am using kernel
2.6.11-rc1 (from linux-mips.org cvs, but the problem is
probably not mips-specific).

My driver transfers large amounts of data using DMA to a
buffer passed in from userland and translated to a page
list via get_user_pages(). Due to alignment restrictions
imposed by the DMA hardware, I have to use a temporary
buffer page for a part of the data buffer, and to copy
the data from this page to the actual buffer using
memcpy(). To be able to to so, I am using vmap() to create
a temporary mapping for the part of the buffer where the
data is to be copied, do the copy, and then call vunmap()
to remove the mapping:



if (pkt->copy_size) {
	const unsigned int page_order =
		(pkt->copy_size > PAGE_SIZE) ? 1 : 0;
	void * const dst = vmap(pkt->copy_pg, 0x1 << page_order,
				VM_MAP, PAGE_USERIO);

	if (dst) {
		memcpy(dst + pkt->copy_offs, pkt->copy_src,
		       pkt->copy_size);
		free_pages((unsigned long) pkt->copy_src, page_order);
		vunmap(dst);
	} else {
		pkt->pset->status = XICAP_BUFSTAT_VMERR;
	}
}



The code above is executed once for every data buffer
processed. It works as expected most of the time, but
every once in a while the data copied is not written to
the correct location, but to the previously processed
buffer instead. It looks as if the mapping established
for that buffer had survived the vunmap() / vmap() sequence.

In case it matters, my system is single core (not SMP).
Any ideas, anybody?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
