Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 14:23:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49101 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3558331AbWGKNXo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2006 14:23:44 +0100
Received: from localhost (p6234-ipad28funabasi.chiba.ocn.ne.jp [220.107.205.234])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0AF9AAF65; Tue, 11 Jul 2006 22:23:39 +0900 (JST)
Date:	Tue, 11 Jul 2006 22:24:58 +0900 (JST)
Message-Id: <20060711.222458.74752678.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] do not count pages in holes with sparsemem
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <44B3625B.7000700@innova-card.com>
References: <cda58cb80607100434h13831eb7rc6eda13a0d9e373f@mail.gmail.com>
	<20060710.233454.39153668.anemo@mba.ocn.ne.jp>
	<44B3625B.7000700@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 11 Jul 2006 10:33:31 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > We can, but we can get more precise value using page_is_ram().  The
> > pfn_valid() returns true for _all_ pages on present section, and
> > currently the section size is 256MB.
> 
> so your total pages of RAM in show_mem() is incorrect...
> 
>                if (!pfn_valid(pfn))
>                         continue;
>                 page = pfn_to_page(pfn);
>                 total++;
> 
> 
> I don't know SPARSEMEM a lot but is it allowed to have holes inside
> a section ? Shouldn't we tune the section size to avoid holes inside
> section ?

If holes exist in a section, show_mem() will count these pages as
"reserved".  You can count real pages by "total - reserved".

Talking about nr_kernel_pages (calculated by zones_size[] and
zones_holes[]) and num_physpages, these values are used to determine
sizes of some kernel data structures, it would be better to set more
precise value for them.

While large holes in a section wastes some memory, make the section
size customizable might be a good idea.  Anyone?  ;-)

---
Atsushi Nemoto
