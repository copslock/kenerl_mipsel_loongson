Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2008 07:22:34 +0000 (GMT)
Received: from po-out-1718.google.com ([72.14.252.155]:11461 "EHLO
	po-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20025540AbYAAHW0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Jan 2008 07:22:26 +0000
Received: by po-out-1718.google.com with SMTP id y22so4081506pof.4
        for <linux-mips@linux-mips.org>; Mon, 31 Dec 2007 23:22:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=7Ko9D5+Z/RfBQGcRhkNNJLUqaQ/ZcNwt3GB6e7SZYtU=;
        b=lmMETg3iMHSzg7sEj25XsS8QmhVj9meENGPkMO5GGfTYcqWxPHTGriptK6bzYu6/+ItO6D9yxTbh6VEz6I89KbNU5H3YAGDkixAIbPA/qwO9ZJk1NElRNo8ulgYgQJYVZaBD2V0b8bqnz2u8xoNsOgamBiNGS38mvJ6jK3M3qP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NN/LtgxMqz73XwZuwe52LNxVJcqOTRoNcicAPcfp3vWg6g6DbKYi7N0VROqOI8jMUMu5q31preQw/xOQfydc4K9EJUoTd2B7xpmWuQjwH9iWkU/ByXvdfM8KOpI74tBSwbh3H9a85oHq+qxEBaSDXq4Au5ZA4XEhNJz1pX5WZlM=
Received: by 10.141.163.12 with SMTP id q12mr1446898rvo.260.1199172144032;
        Mon, 31 Dec 2007 23:22:24 -0800 (PST)
Received: from localhost ( [221.11.20.10])
        by mx.google.com with ESMTPS id g21sm7585558rvb.29.2007.12.31.23.22.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2007 23:22:22 -0800 (PST)
Date:	Tue, 1 Jan 2008 15:22:38 +0800
From:	WANG Cong <xiyou.wangcong@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	LKML <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
Message-ID: <20080101072238.GC2496@hacking>
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
References: <20080101071311.GA2496@hacking>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080101071311.GA2496@hacking>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <xiyou.wangcong@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiyou.wangcong@gmail.com
Precedence: bulk
X-list: linux-mips


TOPDIR is obsolete, use objtree instead.
This patch removes TOPDIR from all Mips Makefiles.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---

diff --git a/arch/mips/lasat/image/Makefile b/arch/mips/lasat/image/Makefile
index 5332449..5196962 100644
--- a/arch/mips/lasat/image/Makefile
+++ b/arch/mips/lasat/image/Makefile
@@ -12,7 +12,7 @@ endif
 
 MKLASATIMG = mklasatimg
 MKLASATIMG_ARCH = mq2,mqpro,sp100,sp200
-KERNEL_IMAGE = $(TOPDIR)/vmlinux
+KERNEL_IMAGE = $(objtree)/vmlinux
 KERNEL_START = $(shell $(NM) $(KERNEL_IMAGE) | grep " _text" | cut -f1 -d\ )
 KERNEL_ENTRY = $(shell $(NM) $(KERNEL_IMAGE) | grep kernel_entry | cut -f1 -d\ )
 
@@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
 		-D TIMESTAMP=$(shell date +%s)
 
 $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
-	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
+	$(CC) -fno-pic $(HEAD_DEFINES) -I$(objtree)/include -c -o $@ $<
 
 OBJECTS = head.o kImage.o
 
