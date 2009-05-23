Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 May 2009 13:31:00 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51666 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20022873AbZEWMax (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 May 2009 13:30:53 +0100
Received: from localhost (p4116-ipad313funabasi.chiba.ocn.ne.jp [123.217.230.116])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6951B9DD8; Sat, 23 May 2009 21:30:45 +0900 (JST)
Date:	Sat, 23 May 2009 21:30:45 +0900 (JST)
Message-Id: <20090523.213045.39168996.anemo@mba.ocn.ne.jp>
To:	yanh@lemote.com
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, philippe@cowpig.ca, r0bertz@gentoo.org,
	zhangfx@lemote.com, apatard@mandriva.com,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	hofrat@hofr.at, liujl@lemote.com, erwan@thiscow.com
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1243066003.8509.60.camel@localhost.localdomain>
References: <817be0da759e19d781e98237cc70efeb33f10a40.1242855716.git.wuzhangjin@gmail.com>
	<20090522.220123.59650403.anemo@mba.ocn.ne.jp>
	<1243066003.8509.60.camel@localhost.localdomain>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22949
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 23 May 2009 16:06:43 +0800, yanh <yanh@lemote.com> wrote:
> > > +unsigned long
> > > +	saved_ra,
> > > +	saved_sp,
...
> > > +	saved_v0,
> > > +	saved_v1;
> > 
> > Instead of enumerating them, I would prefer something like "struct
> > pt_regs saved_regs" or "unsigned long saved_regs[32]".
> This implementation is referencing the x86 platform. 
> Not all the 32 reigsters are needed to save. 
> Maybe the whole registers needed to save can still be reduced.

I did not mean save/restore all registers.  I just mean using only one
symbol (struct or array).  Though the struct or array contains some
unused members, it saves many instructions in
swsusp_arch_{suspend,resume}.

For saving N registers, (N * 2) instructions are required to save to
individual variables, but (N + 2) instructions are required to save to
array or struct.

> > > +void save_processor_state(void)
> > > +{
> > > +	saved_status = read_c0_status();
> > > +}
> > 
> > No need to save/restore floating point registers?
> the floating point registers are not used by kernel, for user part, they
> are already saved while entering into kernel mode.

No, floating point registers are not saved on entering into kernel.
They are saved on context switch.  

---
Atsushi Nemoto
