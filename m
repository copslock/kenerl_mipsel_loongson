Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 03:13:02 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.185]:34299 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20029868AbZDTCM4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 03:12:56 +0100
Received: by ti-out-0910.google.com with SMTP id 11so1064560tim.20
        for <multiple recipients>; Sun, 19 Apr 2009 19:12:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=/YvVWGSu/LPf11rv8QihU/KmtSiR8NE4SrajnCYHLxs=;
        b=vEkuCakQYFkry6xt/DAzctHNkoCzrUSMJY2foyiqbiDv2U8zGpltPfUsAeKZfp15N0
         MyWYXCrpDm/WVMYLrVHSqnQM61lZt8rsfqMfak8u5vZQr0pCHHeAVaDfpBGV8qzRzjHM
         ZzUzOsefBQTHCjw4E1NSAKlaFlY2cYUZDh6Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=iedzYVKcY+/TdgEceCfDkCMNCc5iRR6hx9qDlb1+IINmvdyEU4AjCC2kBl7gah8D9i
         KzvLBoZFhciigjXis0MPMRcdrKwlG2qrjNYcrmMOfe6bBRMVPRcD26LLZy68HbLmJZ0O
         LoBU97h06t+A400B3K22i7nKDQjPtNA1srZ0k=
Received: by 10.110.31.5 with SMTP id e5mr5678145tie.35.1240193572530;
        Sun, 19 Apr 2009 19:12:52 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id 2sm40635tif.5.2009.04.19.19.12.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 19:12:51 -0700 (PDT)
Subject: "RT_PREEMPT for loongson" is updated to patch-2.6.29.1-rt8
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-kernel@vger.kernel.org
Cc:	Nicholas Mc Guire <hofrat@hofr.at>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, zhangfx@lemote.com,
	loongson-dev@googlegroups.com, yanh@lemote.com,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Zhang Le <r0bertz@gentoo.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 20 Apr 2009 10:12:27 +0800
Message-Id: <1240193547.25532.52.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

hi, all

I just update "RT_PREEMPT for loongson" to the latest RT_PREEMPT
(patch-2.6.29.1-rt8), welcome to pull & test it.

$ git clone git://dev.lemote.com/rt4ls.git
or
http://dev.lemote.com/http_git/rt4ls.git

this version include basic-RT support for mips, ftrace support for mips
(static function tracer/dynamic function tracer/function graph
tracer/system call tracer). 

* current status

the "system call tracer" need to fix when compiled in 64bit, because
there are several sys_call_table entries for different mips64
standards(o32, n32), currently, i only use the one in
arch/mips/kernel/scall64-o32.S via EXPORT(sys_call_table).

the "function graph tracer" is not stable under 100% load(lots of
"find /" background). 

best regards,
Wu Zhangjin

-- 
Wu Zhangjin
DSLab, Lanzhou University, China
www.lemote.com, Jiangsu Province, China
