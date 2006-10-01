Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Oct 2006 15:50:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:23259 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037863AbWJAOur (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Oct 2006 15:50:47 +0100
Received: from localhost (p3194-ipad03funabasi.chiba.ocn.ne.jp [219.160.83.194])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DE5669C55; Sun,  1 Oct 2006 23:50:43 +0900 (JST)
Date:	Sun, 01 Oct 2006 23:52:54 +0900 (JST)
Message-Id: <20061001.235254.126142488.anemo@mba.ocn.ne.jp>
To:	girishvg@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: PATCH] cleanup hardcoding __pa/__va macros etc. (take-5)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <8D501155-BC7A-471A-9374-9EB8D48BE307@gmail.com>
References: <B3C723F6-A2B3-4A0E-88BB-FF36AB58FFB4@gmail.com>
	<20060930.025956.108739154.anemo@mba.ocn.ne.jp>
	<8D501155-BC7A-471A-9374-9EB8D48BE307@gmail.com>
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
X-archive-position: 12755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 30 Sep 2006 03:33:01 +0900, girish <girishvg@gmail.com> wrote:
> > Looks good to me, except for page.h part.
> 
> I agree, but as of now, I do not have any better solution. If & when  
> I will implement kernel page table for memory above 2000_0000, I plan  
> to give it a through mapping. That is to say, 4000_0000 physical  
> mapped to 4000_0000 virtual. In that case the page.h __pa/__va macros  
> stand a chance (^_^;)

No.  4000_0000 physical is never mapped to 4000_0000 virtual.  The low
2GB of virtual address space are used for user mapping.

> If somebody has already done kernel page table implementation, could  
> you please pass on the relevant patch? Thanks.

If you have a 64-bit CPU, you can use a 64-bit kernel which gives you
large XKPHYS area.  If not, and your CPU does not have D-cache
aliasing, you can use CONFIG_HIGHMEM which are using kernel page table
already.  Otherwise you are out of luck for now unfortunately.

Anyway, you do not have to change __pa() and __va().

---
Atsushi Nemoto
