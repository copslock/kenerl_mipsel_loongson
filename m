Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 15:31:31 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:56378 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492433AbZJVNbY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 15:31:24 +0200
Received: by pzk35 with SMTP id 35so5923716pzk.22
        for <multiple recipients>; Thu, 22 Oct 2009 06:31:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/SPoxqyGVl+bF5SUd2rsPRNBr6XV5CKn+1q9wt/H72U=;
        b=kRSniANiQUIqDkhMu7jnMQ3bxcRAY2aqDTr3xplzuMqcKChyVtzMosQP0+Q0BL7LVo
         5QcB5wqq5q4n/4qO9U1OSYC+lWlDxl/PfyFyOInlTeodryRM13kHfr8YY9JbfAQ6RomO
         3DUoB7pZlSWLgvOPP2u96PAYv1qUB2nBS4D6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EyMJnEKSI0ZLNdSd/uxyKKhi7ggTLSphDYe6hMrxoNn279CScv+hCwI/cUExTSFqU9
         AwR8hPJv9k2RQ5GMok2zhzEsVQoyHrdj/uZiUyG8PjReNeNpifoK+t9xkBcNDvB8sVVw
         /tC6QBUUc0SXhpohWaNjz8dYbgMeKEUJko+Iw=
Received: by 10.114.253.24 with SMTP id a24mr14577669wai.201.1256218274432;
        Thu, 22 Oct 2009 06:31:14 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1315387pxi.13.2009.10.22.06.31.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 06:31:13 -0700 (PDT)
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256217444.20866.599.camel@gandalf.stny.rr.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>
	 <4ADF38D5.9060100@caviumnetworks.com>
	 <1256143568.18347.3169.camel@gandalf.stny.rr.com>
	 <4ADF3FE0.5090104@caviumnetworks.com>
	 <1256145813.18347.3210.camel@gandalf.stny.rr.com>
	 <1256211516.3852.47.camel@falcon>
	 <1256217444.20866.599.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 22 Oct 2009 21:31:03 +0800
Message-Id: <1256218263.3852.115.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-10-22 at 09:17 -0400, Steven Rostedt wrote:
> On Thu, 2009-10-22 at 19:38 +0800, Wu Zhangjin wrote:
> > Hi,
> > 
> > On Wed, 2009-10-21 at 13:23 -0400, Steven Rostedt wrote:
> 
> > Ralf have told me -pg really works with -fomit-frame-pointer, although
> > the gcc tool tell us they are not incompatible when we use both of them
> > together, but when I remove -fno-omit-frame-pointer in
> > KBUILD_FLAGS(enabled by CONFIG_FRAME_POINTER), it definitely remove the
> > s8(fp) relative source code(Seems -fomit-frame-pionter is used by
> > default by gcc), the leaf function becomes this:
> > 
> > function:
> > 
> > 80101144 <au1k_wait>:
> > 80101144:       03e00821        move    at,ra
> > 80101148:       0c04271c        jal     80109c70 <_mcount>
> >
> > No more instruction,
> > 
> > and the non-leaf function becomes,
> > 
> > 80126590 <copy_process>:
> > 80126590:       27bdffa0        addiu   sp,sp,-96
> > 80126594:       afbf005c        sw      ra,92(sp)
> > 80126598:       afbe0058        sw      s8,88(sp)
> > 8012659c:       afb70054        sw      s7,84(sp)
> > 801265a0:       afb60050        sw      s6,80(sp)
> > 801265a4:       afb5004c        sw      s5,76(sp)
> > 801265a8:       afb40048        sw      s4,72(sp)
> > 801265ac:       afb30044        sw      s3,68(sp)
> > 801265b0:       afb20040        sw      s2,64(sp)
> > 801265b4:       afb1003c        sw      s1,60(sp)
> > 801265b8:       afb00038        sw      s0,56(sp)
> > 801265bc:       03e00821        move    at,ra
> > 801265c0:       0c04271c        jal     80109c70 <_mcount>
> > 
> > It may save about two instructions for us.
> > 	
> > 	sw	s8, offset(sp)
> > 	move	s8, fp
> > 
> > and also, I have tried to just search "Save" instruction, if I find one,
> 
> So you look for "sw ..."?
> 
> > that should be a non-leaf function, otherwise, it's leaf function, but I
> > can not prove no "Save" instruction before the leaf function's "move at,
> > ra", for example:
> 
> Yes but it should never be saving the ra. You can search all
> instructions before the move at,ra until you find the save of the ra, or
> you find something that is not a save. If you find the saving of ra, it
> is not a leaf, but if you don't find the saving of ra, then it is a
> leaf.
> 
> > 
> > 8010113c:       03e00008        jr      ra
> > 80101140:       00020021        nop
> > 
> > 80101144 <au1k_wait>:
> > 80101144:       03e00821        move    at,ra
> > 80101148:       0c04271c        jal     80109c70 <_mcount>
> > 
> > if there is "save" instruction at address 80101140, it will fail.
> > Although, I met not failure with several tries, but no prove on it! any
> > ABI protection for this? if YES, this should be a better solution, for
> > it may works without -fno-omit-frame-pointer and save several
> > instructions for us.
> 
> If we don't stop at just one save, but look for the saving of ra, it
> should not fail.
> 

We can not look for the saving of ra continuously(when should we stop?
if with -fno-omit-fram-pointer, we have "move s8,sp" or "addiu sp, sp,
-offset", but without it, we have no "guideboard" to know that is the
beginning of the function!), 'Cause we may find the saving of ra of
another function, which will fail at that time.

BTW: Just replace probe_kernel_read() and tracing_stop/tracing_start by
asm, it works in 32bit, but fails in 64bit, I'm trying to find why!(TLB
miss on load or ifetch, will fix it asap! and resend the patchset out!)

Regards,
	Wu Zhangjin
