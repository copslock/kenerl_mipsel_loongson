Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jan 2008 06:21:40 +0000 (GMT)
Received: from po-out-1718.google.com ([72.14.252.152]:47081 "EHLO
	po-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20023273AbYABGVb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 2 Jan 2008 06:21:31 +0000
Received: by po-out-1718.google.com with SMTP id y22so4771996pof.4
        for <linux-mips@linux-mips.org>; Tue, 01 Jan 2008 22:21:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=SNaZNNAVWjviEQuIbxoNl8YuOzODd/hYRK9utqwE1LQ=;
        b=bvjlQnz9+DDpFS9imMAicvH+nkhD696acHwt85kVWx/go246Sj0Cn51WxVLh8mafoM+azXm02vor+k3pgjAAvJhDMQN/rH7yFxFioucA6PKO3TfBpiEOT9AU1pYCDn2xC8xCtUi6yu8f1JyBtBbnOzbb2DdGPZnvj23ffsfOK1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oOvA2EbPmh9dBVKAYNfGjQHStAjzfgh0iCigR/Zr8Y649ogwnm8aBM2PukHITY3d/Gx7XwpDXfj0cxes5Vv3sHhXq46Tubc9FkIQVtJOzMd7Cn+2goIfI7jOWPwKhInlEnyTDx/F0TbdTitw0DtwCAgXWS7raAg1Dz731eXV2BY=
Received: by 10.114.159.1 with SMTP id h1mr1881413wae.122.1199254889843;
        Tue, 01 Jan 2008 22:21:29 -0800 (PST)
Received: from localhost ( [221.11.20.10])
        by mx.google.com with ESMTPS id l27sm24501725waf.26.2008.01.01.22.21.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Jan 2008 22:21:28 -0800 (PST)
Date:	Wed, 2 Jan 2008 14:21:36 +0800
From:	WANG Cong <xiyou.wangcong@gmail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Andreas Schwab <schwab@suse.de>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: (Try #3) [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080102062135.GE2493@hacking>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking> <20080101101540.GB28913@uranus.ravnborg.org> <jefxxhlkxb.fsf@sykes.suse.de> <20080101175754.GC31575@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101175754.GC31575@uranus.ravnborg.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips


>> 
>> Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?
>It would be better to use $(LINUXINCLUDE) as we then pull in all config
>symbols too and do not have to hardcode kbuild internal names (include2).

OK. Refine this patch.

----------->

Since TOPDIR is obsolete, this patch removes TOPDIR
from the Mips Makefiles.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 5332449..17f5266 100644
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
+	$(CC) -fno-pic $(HEAD_DEFINES) $(LINUXINCLUDE) -c -o $@ $<
 
 OBJECTS = head.o kImage.o
 
