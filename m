Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2006 09:50:33 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.198]:27046 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20037753AbWHRIu3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Aug 2006 09:50:29 +0100
Received: by nz-out-0102.google.com with SMTP id s1so473293nze
        for <linux-mips@linux-mips.org>; Fri, 18 Aug 2006 01:50:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=dfwD6PwbAU8VUXs+6NA4I8niwFl5TAmYmyaL3Bwfinif21CuM0I8MBQ34Nmi2b1/iljBObnuStbq3m2Xi6iZjXXMOKCF9smJ2mPaIfegh1t+1fEbgSu15gka5ovooCqdOS90zU1pNuQD0PbIqjLhArmzG4ZkS30JvrrZwj7FNMI=
Received: by 10.65.139.9 with SMTP id r9mr3347488qbn;
        Fri, 18 Aug 2006 01:50:28 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e14sm1907787qbe.2006.08.18.01.50.26;
        Fri, 18 Aug 2006 01:50:27 -0700 (PDT)
Message-ID: <44E57F39.2020009@innova-card.com>
Date:	Fri, 18 Aug 2006 10:50:01 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Remove mfinfo[64] used by get_wchan()
References: <44E475C8.5000105@innova-card.com>	<20060818.115213.108739385.nemoto@toshiba-tops.co.jp>	<44E57161.5060104@innova-card.com> <20060818.171558.89065994.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060818.171558.89065994.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 18 Aug 2006 09:50:57 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>>> +	unsigned long size = 0;
>>> You must pass some non-zero size even if CONFIG_KALLSYMS was not set.
>>> Otherwise schedule_mfi will not be initialized as expected.  Actually,
>>> this is not a problem of this patch, but we missed this point on
>>> previous cleanups for the get_frame_info()...
>> or maybe we can just fix get_frame_info() and make it more robust ?
> 
> Maybe.  But info->func_size == 0 is valid input when it was called via
> show_backtrace.  If an exception occured on a first instruction of a
> function, get_frame_info() should return 1.  So it would be easy to
> give some appropriate (128?) size here.
> 

Does something like this seem correct ? If an exception occured on a first
instruction of a function, show_backtrace() will call get_frame_info()
with info->func_size != 0 but very small. In this case it returns 1.

If the caller of get_frame_info() set info->func_size = 0, then it doesn't
know the size of the function, and we assume it to 128 instructions.

		Franck

-- >8 --


diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 951bf9c..5b18806 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -311,12 +311,19 @@ static inline int is_sp_move_ins(union m
 static int get_frame_info(struct mips_frame_info *info)
 {
 	union mips_instruction *ip = info->func;
-	int i, max_insns =
-		min(128UL, info->func_size / sizeof(union mips_instruction));
+	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
+	unsigned i;
 
 	info->pc_offset = -1;
 	info->frame_size = 0;
 
+	if (!ip)
+		goto err;
+	
+	if (max_insns == 0)
+		max_insns = 128U;
+	max_insns = min(128U, max_insns);
+
 	for (i = 0; i < max_insns; i++, ip++) {
 
 		if (is_jal_jalr_jr_ins(ip))
@@ -337,6 +344,7 @@ static int get_frame_info(struct mips_fr
 	if (info->pc_offset < 0) /* leaf */
 		return 1;
 	/* prologue seems boggus... */
+err:
 	return -1;
 }
