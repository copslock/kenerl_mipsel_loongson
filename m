Received:  by oss.sgi.com id <S42201AbQHJCi6>;
	Wed, 9 Aug 2000 19:38:58 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29816 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42199AbQHJCiZ>; Wed, 9 Aug 2000 19:38:25 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id TAA06431
	for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 19:43:57 -0700 (PDT)
	mail_from (nemoto@toshiba-tops.co.jp)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA12238 for <linux-mips@oss.sgi.com>; Wed, 9 Aug 2000 19:37:22 -0700 (PDT)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA46148
	for <linux@engr.sgi.com>;
	Wed, 9 Aug 2000 19:35:50 -0700 (PDT)
	mail_from (nemoto@toshiba-tops.co.jp)
Received: from fwgate.toshiba-tops.co.jp (fwgate.toshiba-tops.co.jp [202.230.225.20]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id TAA24432
	for <linux@engr.sgi.com>; Wed, 9 Aug 2000 19:28:12 -0700 (PDT)
	mail_from (nemoto@toshiba-tops.co.jp)
Received: from topsms by fwgate.toshiba-tops.co.jp
          via smtpd (for deliverator.sgi.com [204.94.214.10]) with SMTP; 10 Aug 2000 02:35:46 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id LAA02650;
	Thu, 10 Aug 2000 11:30:37 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id LAA89823; Thu, 10 Aug 2000 11:30:37 +0900 (JST)
To:     jsun@mvista.com
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: bug in the latest cache code?
From:   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <3992007C.49050FC@mvista.com>
References: <3992007C.49050FC@mvista.com>
X-Mailer: Mew version 1.94.1 on Emacs 20.5 / Mule 4.0 (HANANOEN)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000810113036S.nemoto@toshiba-tops.co.jp>
Date:   Thu, 10 Aug 2000 11:30:36 +0900
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

>>>>> On Wed, 09 Aug 2000 18:08:12 -0700, Jun Sun <jsun@mvista.com> said:
jsun> A new function, r4k_flush_icache_page_i32(), was added recently.
jsun> It calls blast_icache32_page(), which uses Hit cache operations
jsun> to flush cache.  Unfortunately, that will generate TLB fault if
jsun> virtual address is not present in TLB.  Under certain
jsun> conditions, r4k_flush_icache_page_i32() will be called in the
jsun> middle of handling a page fault, and it will then generate the
jsun> same page fault again with cache hit operation.  This causes a
jsun> deadlock (on current->mm->mmap_sem).

To my knowlege, if the vierual address is not present in TLB, cache
hit operation generates TLB refill exception, not TLB invalid
exception.  After the TLB refill excepsion, the cache instruction can
continue execution without a page fault (no deadlock).

I met the same deadlock problem on my r3k (with r4k-like cache) board
with 2.2.12 based kernel.  I doubted my TLB/cache codes first, but the
real cause was in vt.c.  _kd_mksound() modifies TLB refill handler
code if mips_io_port_base == 0xa0000000.  Modifing the #if-line near
_kd_mksound() fixed my problem.

Hope this helps.

---
Atsushi Nemoto
