Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA71Z8s24519
	for linux-mips-outgoing; Tue, 6 Nov 2001 17:35:08 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA71Z1024516;
	Tue, 6 Nov 2001 17:35:01 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 7 Nov 2001 01:35:01 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 88C46B471; Wed,  7 Nov 2001 10:34:59 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id KAA59722; Wed, 7 Nov 2001 10:34:59 +0900 (JST)
Date: Wed, 07 Nov 2001 10:39:47 +0900 (JST)
Message-Id: <20011107.103947.74756322.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: dony.he@huawei.com, linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011106130839.B30219@dea.linux-mips.net>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com>
	<20011106130839.B30219@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 6 Nov 2001 13:08:39 -0800, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> Vmalloc is probably innocent I'd rather guess cache flushing is
ralf> broken on your platform.

In 2.4.5, flush_cache_all() (and flush_tlb_all()) is called in
vmalloc_area_pages().  I think this call protect us from virtual
aliasing problem.

By the way, does anybody have any problem with vmalloc on recent
kernel?

In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
disappered from vmalloc_area_pages().  I have a data corruption
problem in vmalloc()ed area without this call.  I think we still need
this call.

--- linux-sgi-cvs/mm/vmalloc.c	Tue Sep 18 05:16:31 2001
+++ linux.new/mm/vmalloc.c	Wed Nov  7 10:33:47 2001
@@ -144,6 +144,7 @@
 	int ret;
 
 	dir = pgd_offset_k(address);
+	flush_cache_all();
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
@@ -163,6 +164,7 @@
 		ret = 0;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
+ 	flush_tlb_all();
 	return ret;
 }
 
---
Atsushi Nemoto
