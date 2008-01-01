Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2008 13:11:07 +0000 (GMT)
Received: from po-out-1718.google.com ([72.14.252.157]:22691 "EHLO
	po-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20022371AbYAANK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jan 2008 13:10:59 +0000
Received: by po-out-1718.google.com with SMTP id y22so4269424pof.4
        for <linux-mips@linux-mips.org>; Tue, 01 Jan 2008 05:10:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=t5rV21il7smesmoZ8GpLTmiJgChFHrDhLeALgFpQ/ug=;
        b=ExqsiH2aAfb8UbQ3kiq3f1G4QRHg/6EzqGL8gr3b2w+SNaRvSt4MfVpD6TgorXeW+UUR1Inz+GYPVNqFvcUf21byLVfxj12pJsD6jv6MG4254NEO/EGYpnAn8rbkRSUtprTXv6pfWBHxvHjRoQfDn//+wliBeKH+By43mTMZKz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=udN6VnSNWLOlWiBlzo0kJU86GL+gZ/ZtpS9j6RQoirtijOzmMueqfLwsnDwEZe6dZIyxvYgUPZXgi/naEmPxIz1MquDQQISiNT3zCnQffu651uxAiFT6/1W/DyyJqbYKNOyTRriNaupCAJRnC7n2JkZFd6ghsw69q0+cs96Z1RQ=
Received: by 10.115.109.1 with SMTP id l1mr14437238wam.136.1199193054678;
        Tue, 01 Jan 2008 05:10:54 -0800 (PST)
Received: from localhost ( [221.11.20.10])
        by mx.google.com with ESMTPS id j31sm23245529waf.38.2008.01.01.05.10.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2008 05:10:53 -0800 (PST)
Date:	Tue, 1 Jan 2008 21:11:02 +0800
From:	WANG Cong <xiyou.wangcong@gmail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	WANG Cong <xiyou.wangcong@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: (Try #2) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080101131102.GB2499@hacking>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101101540.GB28913@uranus.ravnborg.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips


>> -KERNEL_IMAGE = $(TOPDIR)/vmlinux
>> +KERNEL_IMAGE = $(objtree)/vmlinux
>
>Current directory when building is $(objtree) so here we should
>just skip the use of TOPDIR like this:
>> +KERNEL_IMAGE = vmlinux
>
>
>>  KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
>>  KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
>>  
>> @@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
>>  		-D TIMESTAMP=$(shell date +%s)
>>  
>>  $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
>> -	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
>> +	$(CC) -fno-pic $(HEAD_DEFINES) -I$(objtree)/include -c -o $@ $<
>This has never worked with O=.. builds.
>The correct fix here is to use:
>> +	$(CC) -fno-pic $(HEAD_DEFINES) -Iinclude -Iinclude2 -c -o $@ $<
>
>The -Iinclude2 is only for O=... builds so to keep current
>behaviour removing $(TOPDIR)/ would do it.

Thank you for your explanations!

The following one corrects all the mistakes as you told.

------->

Since TOPDIR is obsolete, this patch removes TOPDIR
from the Mips Makefiles.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 5332449..1ae73ce 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -12,7 +12,7 @@ endif
 
 MKLASATIMG = mklasatimg
 MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
-KERNEL_IMAGE = $(TOPDIR)/vmlinux
+KERNEL_IMAGE = vmlinux
 KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
 KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
 
@@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
 		-D TIMESTAMP=$(shell date +%s)
 
 $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
-	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
+	$(CC) -fno-pic $(HEAD_DEFINES) -Iinclude -Iinclude2 -c -o $@ $<
 
 OBJECTS = head.o kImage.o
 
