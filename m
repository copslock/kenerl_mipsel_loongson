Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 07:45:14 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:61694 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492014AbZJ2GpH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 07:45:07 +0100
Received: by pxi26 with SMTP id 26so1094182pxi.22
        for <multiple recipients>; Wed, 28 Oct 2009 23:44:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=481f4YzT+srM07+Qa+fd8WaJMi4Q2nS0yMpZXyaiNJM=;
        b=NVqWMV60/yeXzUk1n6IAU5UAS6QCmhqQs8GCCSkW0T5DeafFsqZJxJxlAf9BqIxe0J
         GvoAdDo506TUlsoluEf21EXR6uFwokQm2YJfL50B3TKC+eG1oHgYJqeEfBWYSQsu/zJe
         i2XbfQYiEw9YAlLN/6kHjVOGP91Z1VkACOCDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=lwROpl3ql7vJMuJ7LE6hGlWAPgBtDfYt01U1G+KN896xNs/VRm2mYWHhx/OYW3/lB9
         XKWlroOxd8fHsL/gzAf95IzvGwSfMFErdLXoXIUQzSshCo0ug8rFpSFd7Zr+TjK/xpOw
         wNJkbhy0MpQExr7K+VwfdbNvZcO2nzDWE9i1k=
Received: by 10.115.149.4 with SMTP id b4mr19200503wao.18.1256798698585;
        Wed, 28 Oct 2009 23:44:58 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1064823pxi.0.2009.10.28.23.44.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 23:44:57 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Add option to pass return address location to
 _mcount.
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Richard Sandiford <rdsandiford@googlemail.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	GCC Patches <gcc-patches@gcc.gnu.org>,
	linux-mips@linux-mips.org, Adam Nemet <anemet@caviumnetworks.com>,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <87ljiwr0t9.fsf@firetop.home>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <1256138686.18347.3039.camel@gandalf.stny.rr.com>
	 <1256233679.23653.7.camel@falcon> <4AE0A5BE.8000601@caviumnetworks.com>
	 <87y6n36plp.fsf@firetop.home> <4AE232AD.4050308@caviumnetworks.com>
	 <87my3htau1.fsf@firetop.home> <4AE5F392.5020405@caviumnetworks.com>
	 <87ljiwr0t9.fsf@firetop.home>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 29 Oct 2009 14:44:34 +0800
Message-Id: <1256798674.6448.42.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24575
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 2009-10-27 at 21:20 +0000, Richard Sandiford wrote:
[...]
> OK with those changes,

Just applied the above changes, and added one more for not getting the
ra_fp_offset when -pg is not enabled:

@@ -9619,6 +9622,9 @@ mips_for_each_saved_gpr_and_fpr (HOST_WIDE_INT
sp_offset,
   for (regno = GP_REG_LAST; regno >= GP_REG_FIRST; regno--)
     if (BITSET_P (cfun->machine->frame.mask, regno - GP_REG_FIRST))
       {
+       /* Record the ra offset for use by mips_function_profiler.  */
+       if (crtl->profile && regno == RETURN_ADDR_REGNUM)
+         cfun->machine->frame.ra_fp_offset = offset + sp_offset;
        mips_save_restore_reg (word_mode, regno, offset, fn);
        offset -= UNITS_PER_WORD;
       }

"crtl->profile &&" was added.

>  thanks, if it passing testing, and if
> Ralf is happy with the linux side.
> 

Just appended that patch with the above changes to the latest gcc 4.5 in
the git repository, and tested it, which works well.

this is the result of a non-leaf function:

ffffffff80243c08 <copy_process>:
ffffffff80243c08:       67bdff40        daddiu  sp,sp,-192
ffffffff80243c0c:       ffbe00b0        sd      s8,176(sp)
ffffffff80243c10:       03a0f02d        move    s8,sp
ffffffff80243c14:       ffbf00b8        sd      ra,184(sp)
[...]
ffffffff80243c38:       3c038021        lui     v1,0x8021
ffffffff80243c3c:       64631530        daddiu  v1,v1,5424
ffffffff80243c40:       03e0082d        move    at,ra
ffffffff80243c44:       0060f809        jalr    v1
ffffffff80243c48:       67ac00b8        daddiu  t0,sp,184 --> Here it is

and for a leaf function:

ffffffff802054d0 <au1k_wait>:
ffffffff802054d0:       67bdfff0        daddiu  sp,sp,-16
ffffffff802054d4:       ffbe0008        sd      s8,8(sp)
ffffffff802054d8:       03a0f02d        move    s8,sp
ffffffff802054dc:       3c038021        lui     v1,0x8021
ffffffff802054e0:       64631530        daddiu  v1,v1,5424
ffffffff802054e4:       03e0082d        move    at,ra
ffffffff802054e8:       0060f809        jalr    v1
ffffffff802054ec:       0000602d        move    t0,zero --> Here it is

and with this new feature, I can safely remove the old
ftrace_get_parent_addr() and add several more instructions to make
function graph tracer work. and also, 'Cause this feature used the
t0($12) register, I must change the temp registers I have used in the
patches of ftrace for MIPS(t0 --> t1, t1 --> t2, t2-> t3...). no more
touch.

The latest revision of this patch will be sent out in the next E-mail,
and also, the -v8 revision of ftrace for MIPS will be sent out with this
new feature of Gcc asap.

Thanks & Regards,
	Wu Zhangjin
