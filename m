Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA72KC925470
	for linux-mips-outgoing; Tue, 6 Nov 2001 18:20:12 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA72Jv025462;
	Tue, 6 Nov 2001 18:19:57 -0800
Received: from hcdong11752a ([10.105.28.74]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GMER5C00.34C; Wed,
          7 Nov 2001 10:05:36 +0800 
Message-ID: <001301c16731$47c473c0$4a1c690a@huawei.com>
From: "machael" <dony.he@huawei.com>
To: <ralf@oss.sgi.com>, "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>
Cc: <linux-mips@oss.sgi.com>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com><20011106130839.B30219@dea.linux-mips.net> <20011107.103947.74756322.nemoto@toshiba-tops.co.jp>
Subject: Re: vmalloc bugs in 2.4.5???
Date: Wed, 7 Nov 2001 10:09:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> ralf> Vmalloc is probably innocent I'd rather guess cache flushing is
> ralf> broken on your platform.
> 
> In 2.4.5, flush_cache_all() (and flush_tlb_all()) is called in
> vmalloc_area_pages().  I think this call protect us from virtual
> aliasing problem.
> 
> By the way, does anybody have any problem with vmalloc on recent
> kernel?
> 
> In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
> disappered from vmalloc_area_pages().  I have a data corruption
> problem in vmalloc()ed area without this call.  I think we still need
> this call.
> 
> --- linux-sgi-cvs/mm/vmalloc.c Tue Sep 18 05:16:31 2001
> +++ linux.new/mm/vmalloc.c Wed Nov  7 10:33:47 2001
> @@ -144,6 +144,7 @@
>   int ret;
>  
>   dir = pgd_offset_k(address);
> + flush_cache_all();
>   spin_lock(&init_mm.page_table_lock);
>   do {
>   pmd_t *pmd;
> @@ -163,6 +164,7 @@
>   ret = 0;
>   } while (address && (address < end));
>   spin_unlock(&init_mm.page_table_lock);
> + flush_tlb_all();
>   return ret;
>  }

In 2.4.5, vmalloc has these two lines in vmalloc_area_pages().
So what else may be the problem?
Thanks!

machael
