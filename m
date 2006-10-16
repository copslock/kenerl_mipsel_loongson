Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 09:10:53 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:40339 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038990AbWJPIKv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 09:10:51 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 16 Oct 2006 17:10:50 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 6904A41AEC;
	Mon, 16 Oct 2006 17:10:47 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 54B6D202E0;
	Mon, 16 Oct 2006 17:10:47 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9G8AkW0051407;
	Mon, 16 Oct 2006 17:10:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 16 Oct 2006 17:10:46 +0900 (JST)
Message-Id: <20061016.171046.55511403.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <45333CC1.3090704@innova-card.com>
References: <11607431461469-git-send-email-fbuihuu@gmail.com>
	<1160743146503-git-send-email-fbuihuu@gmail.com>
	<45333CC1.3090704@innova-card.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 16 Oct 2006 10:03:13 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> >  	end = (unsigned long)&_end;
> >  	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
> >  	if (tmp < end)
> >  		tmp += PAGE_SIZE;
> >  
> 
> Any idea on what is this code for ?
> It seems that a minimum gap is needed betweend the end of kernel
> code and initrd but I don't see why...

Perhaps because current tools put initrd image at that place.

For example:

arch/mips/boot/addinitrd.c:92:
	loadaddr = ((SWAB(esecs[2].s_vaddr) + SWAB(esecs[2].s_size)
			+ MIPS_PAGE_SIZE-1) & ~MIPS_PAGE_MASK) - 8;
	if (loadaddr < (SWAB(esecs[2].s_vaddr) + SWAB(esecs[2].s_size)))
		loadaddr += MIPS_PAGE_SIZE;
	initrd_header[0] = SWAB(0x494E5244);
	initrd_header[1] = SWAB(st.st_size);

---
Atsushi Nemoto
