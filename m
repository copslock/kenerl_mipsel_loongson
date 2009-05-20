Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:24:26 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:61355 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025140AbZETVYT (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:24:19 +0100
Received: by rv-out-0708.google.com with SMTP id k29so228744rvb.24
        for <multiple recipients>; Wed, 20 May 2009 14:24:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lO09IZJjrHO0/FL/A7Uegqh32PVrPjE9cBgMgu51C7A=;
        b=GIvChwWm93G3fgrKBFDT1IM27doDeQcvg3uBSUbOE7e5QA+Udm5qy6At7FDWGUXZbC
         fX449mvZeejrBVR0A3PSfBxJLX33yyViJ17EWRLbu4q6c6IF3HCLsxO1ceXMA885nlTM
         2pMdG72SjLrITFlSG7U60S0xOAPr+yi3v8h4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gOBjxzJapbF7SEW6pPHtZ1c8liiXjo3iMkP+4meZGskITDIa22Vf3cTx+YSYZzcRx7
         QnMqnCoyrbWazOyrox9TcV6YXnXqTKkKcbrnKD5xBCwqRc76q3Mj/Vg6snOwFGjM0cyY
         /7iFjt6GVot9Dvy8G5+SrrkoXw8x2sh6Fs1D4=
Received: by 10.141.45.16 with SMTP id x16mr870456rvj.33.1242854657508;
        Wed, 20 May 2009 14:24:17 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id f42sm4610744rvb.11.2009.05.20.14.24.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:24:16 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-support 02/27] fix-warning: incompatible argument type of virt_to_phys
Date:	Thu, 21 May 2009 05:24:06 +0800
Message-Id: <0e7026092faebce7caf6bfe9807146cffcd8842a.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

mm/page_alloc.c:1760: warning: passing argument 1 of ‘virt_to_phys’
makes pointer from integer without a cast

mm/page_alloc.c:1760
	...
	unsigned long addr;
	...
	split_page(virt_to_page(addr), order);

arch/mips/include/asm/page.h

	#define virt_to_page(kaddr) pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
	#define virt_addr_valid(kaddr)  pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))

arch/mips/include/asm/io.h
	static inline unsigned long virt_to_phys(volatile const void *address)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
