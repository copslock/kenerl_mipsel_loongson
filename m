Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBR2oka00663
	for linux-mips-outgoing; Wed, 26 Dec 2001 18:50:46 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBR2odX00660;
	Wed, 26 Dec 2001 18:50:40 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Dec 2001 01:50:37 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id E3815B46D; Thu, 27 Dec 2001 10:50:35 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA15531; Thu, 27 Dec 2001 10:50:35 +0900 (JST)
Date: Thu, 27 Dec 2001 10:55:18 +0900 (JST)
Message-Id: <20011227.105518.74756316.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011226013221.A737@dea.linux-mips.net>
References: <20011106130839.B30219@dea.linux-mips.net>
	<20011107.103947.74756322.nemoto@toshiba-tops.co.jp>
	<20011226013221.A737@dea.linux-mips.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Wed, 26 Dec 2001 01:32:21 -0200, Ralf Baechle <ralf@oss.sgi.com> said:
>> In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
>> disappered from vmalloc_area_pages().  I have a data corruption
>> problem in vmalloc()ed area without this call.  I think we still
>> need this call.

ralf> Have you ever resolved this problem?  I've just doublechecked
ralf> the vmalloc code and it seems as if it should be entirely safe
ralf> without these two calls.  The tlb is flushed on vfree so no
ralf> stale entries for a vmalloc address can ever be in the tlb at
ralf> vmalloc time, so this flush_tlb_all() is just an expensive nop.
ralf> And the same it true for flush_cache_all() no matter if caches
ralf> are physically or virtually indexed.

I am still using the patch and have not tried without the two calls
recently...

When I found this problem, I suppose that vmalloc called after
free_pages causes the data corruption.  vmalloc can re-use pages freed
by free_pages and it seems free_pages does not flush cache.  If
vmalloc is to use a page which is associated with dirty cache and has
different "color", virtual aliasing happens and data may be corrupt.
Is this wrong?

---
Atsushi Nemoto
