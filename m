Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 04:33:35 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53387 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492088AbZJUCd3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 04:33:29 +0200
Received: by ewy10 with SMTP id 10so7832276ewy.33
        for <multiple recipients>; Tue, 20 Oct 2009 19:33:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mDP3E/aN97x50p+BfATyc9hE04SGeVUiiS/Jk3t9bOo=;
        b=KH+aThrZ/n+xw4QYAH5HXhMJIWg+9S3YHYkWvDY+/26Tg7RPa1wGnS5+oZCjpeNAn9
         LUlHKNIWfg8L+2btQMGuIq6HjbddcRP5fjb9gY339SRd7LFZ2LCZRWwyDOwo1LSAv0Jq
         lQcrkfWrc+0xk8IPcwHWNQTo7TJpJ7iZDqDj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=MSGahbdg7D5X28xYRr/iod3OOPe0R4Trlh1U20zzreRSsJ4fa2xjy01Fg+uXvCRZEN
         LK+8T8tfyl8VJEx5DoFyUlwEw2Tg85aaz3/UJQTDIic0ClbBrB/PQVnjq+BJt3u9ZozD
         m9efH7rzB4Q52/WP2Vhfdz+kzursV7f/zKRec=
Received: by 10.216.86.200 with SMTP id w50mr2639123wee.173.1256092403261;
        Tue, 20 Oct 2009 19:33:23 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id i35sm1123704gve.28.2009.10.20.19.33.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Oct 2009 19:33:22 -0700 (PDT)
Subject: Re: ftrace for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1256055714.18347.1608.camel@gandalf.stny.rr.com>
References: <1255995599.17795.15.camel@falcon>
	 <1255997319.18347.576.camel@gandalf.stny.rr.com>
	 <1256052667.8149.56.camel@falcon>
	 <1256055714.18347.1608.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 21 Oct 2009 10:33:15 +0800
Message-Id: <1256092395.5482.32.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, all

Just made it(function graph tracer for MIPS) work :-)

The problem is that: the stack offset should be from 0 to PT_SIZE(304),
but I mask it with 0xff(256), which is totally wrong.

Here is an example, the stack address of ra(return address) should be
(s8 + ffbf0128 & 0xfff).

ffffffff801dad10 <do_sync_read>:
ffffffff801dad10:       67bdfed0        daddiu  sp,sp,-304
ffffffff801dad14:       ffbe0120        sd      s8,288(sp)
ffffffff801dad18:       03a0f02d        move    s8,sp
ffffffff801dad1c:       ffbf0128        sd      ra,296(sp)
ffffffff801dad20:       ffb30118        sd      s3,280(sp)
ffffffff801dad24:       ffb20110        sd      s2,272(sp)
ffffffff801dad28:       ffb10108        sd      s1,264(sp)
ffffffff801dad2c:       ffb00100        sd      s0,256(sp)
ffffffff801dad30:       03e0082d        move    at,ra
ffffffff801dad34:       0c042ab0        jal     ffffffff8010aac0
<_mcount>
ffffffff801dad38:       00020021        nop

Thanks! will send the patches out later.

Regards,
	Wu Zhangjin

On Tue, 2009-10-20 at 12:21 -0400, Steven Rostedt wrote:
> On Tue, 2009-10-20 at 23:31 +0800, Wu Zhangjin wrote:
> 
> > Just added tracing_stop() and tracing_start() around
> 
> That seems a bit heavy handed. I still think writing it in "asm" the way
> x86 and powerpc do is the best.
> 
> > probe_kernel_read(), it works(not hang again), and i can get the stack
> > address of the ra register(return address) now, but failed when trying
> > to hijack the return address via writing &return_to_handler in the stack
> > address:
> > 
> > I can write hijack some of the addresses, but failed with this error at
> > last:
> > 
> > Unable to handle kernel paging request at 0000000000000000, epc =
> > 0000000000000000, ra = 000000000000.
> 
> hmm, looks like you jumped to "0"
> 
> > 
> > Need to check which registers is missing when saving/restoring for
> > _mcount:
> > 
> > 
> > NESTED(ftrace_graph_caller, PT_SIZE, ra) 
> >         MCOUNT_SAVE_REGS
> >         PTR_S   v0, PT_R2(sp)
> > 
> >         MCOUNT_SET_ARGS
> >         jal     prepare_ftrace_return
> >         nop
> > 
> >         /* overwrite the parent as &return_to_handler: v0 -> $1(at) */
> >         move    $1,     v0  
> 
> I'm confused here? I'm not exactly sure what the above is doing. Is $1 a
> register (AT)? And how is this register used before calling mcount?
> 
> > 
> >         PTR_L   v0, PT_R2(sp)
> >         MCOUNT_RESTORE_REGS
> >         RETURN_BACK
> >         END(ftrace_graph_caller)
> > 
> >         .align  2
> >         .globl  return_to_handler
> > return_to_handler:
> >         PTR_SUBU        sp, PT_SIZE
> >         PTR_S   v0, PT_R2(sp)
> 
> BTW, is v0 the only return register? I know x86 can return two different
> registers depending on what it returns. What happens if a function
> returns a 64 bit value on a 32bit box? Does it use two registers for
> that?
> 
> -- Steve
> 
> > 
> >         jal     ftrace_return_to_handler
> >         nop
> > 
> >         /* restore the real parent address: v0 -> ra */
> >         move    ra, v0
> > 
> >         PTR_L   v0, PT_R2(sp)
> >         PTR_ADDIU       sp, PT_SIZE
> > 
> >         jr      ra
> > 
> > ...
> > 
> >         .macro MCOUNT_SAVE_REGS
> >         PTR_SUBU        sp, PT_SIZE
> >         PTR_S   ra, PT_R31(sp)
> >         PTR_S   AT, PT_R1(sp)
> >         PTR_S   a0, PT_R4(sp)
> >         PTR_S   a1, PT_R5(sp)
> >         PTR_S   a2, PT_R6(sp)
> >         PTR_S   a3, PT_R7(sp)
> > #ifdef CONFIG_64BIT
> >         PTR_S   a4, PT_R8(sp)
> >         PTR_S   a5, PT_R9(sp)
> >         PTR_S   a6, PT_R10(sp)
> >         PTR_S   a7, PT_R11(sp)
> > #endif
> >         .endm
> > 
> >         .macro MCOUNT_RESTORE_REGS
> >         PTR_L   ra, PT_R31(sp)
> >         PTR_L   AT, PT_R1(sp)
> >         PTR_L   a0, PT_R4(sp)
> >         PTR_L   a1, PT_R5(sp)
> >         PTR_L   a2, PT_R6(sp)
> >         PTR_L   a3, PT_R7(sp)
> > #ifdef CONFIG_64BIT
> >         PTR_L   a4, PT_R8(sp)
> >         PTR_L   a5, PT_R9(sp)
> >         PTR_L   a6, PT_R10(sp)
> >         PTR_L   a7, PT_R11(sp)
> > #endif
> >         PTR_ADDIU       sp, PT_SIZE
> > 
> > Regards,
> > 	Wu Zhangjin
> > 
> 
