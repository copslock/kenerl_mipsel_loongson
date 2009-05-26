Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 15:49:12 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:65080 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20024039AbZEZOs6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 15:48:58 +0100
Received: from localhost (p1252-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.252])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 81A87AC41; Tue, 26 May 2009 23:48:51 +0900 (JST)
Date:	Tue, 26 May 2009 23:48:51 +0900 (JST)
Message-Id: <20090526.234851.240501411.anemo@mba.ocn.ne.jp>
To:	huhb@lemote.com
Cc:	yanh@lemote.com, wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, philippe@cowpig.ca, r0bertz@gentoo.org,
	zhangfx@lemote.com, apatard@mandriva.com,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	hofrat@hofr.at, liujl@lemote.com, erwan@thiscow.com
Subject: Re: [loongson-PATCH-v1 22/27] Hibernation Support in mips system
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4A1B53A3.6060503@lemote.com>
References: <20090523.213045.39168996.anemo@mba.ocn.ne.jp>
	<1243302188.9819.58.camel@localhost.localdomain>
	<4A1B53A3.6060503@lemote.com>
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
X-archive-position: 22971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 May 2009 10:27:47 +0800, Hongbing Hu <huhb@lemote.com> wrote:
> > Yes, the struct array method is more efficient, we will change to it.
> >   
> The length of registers  is different between  32bit kernel  and  64bit 
> kernel.
> That means the file hibernate.S wiil be divided into  hibernate_32.S  
> and hibernate_64.S ?

No, you can use macros in include/asm/asm.h to write common code for
32-bit/64-bit kernel.

> >> No, floating point registers are not saved on entering into kernel.
> >> They are saved on context switch.  
> >>     
> Yes, suspend to disk  will freeze processes at first,and i think the 
> process wiil save the float point regs.
> So there is no need to save them.

Hmm, but the floating point registers in _current_ task are not saved
(I think, but it this wrong?).

Maybe nobody might notice if ioctl() of the s2disk process clobbers
floating point registers, but I think something like this is needed:

	if (is_fpu_owner())
		save_fp(current);
	if (cpu_has_dsp)
		save_dsp(p);

I'm not sure DSP part, and I also wonder other cp0 registers should be
saved or not ...

---
Atsushi Nemoto
