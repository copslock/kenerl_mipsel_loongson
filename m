Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:23:51 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:35908 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025140AbZETVXn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:23:43 +0100
Received: by pxi17 with SMTP id 17so625536pxi.22
        for <multiple recipients>; Wed, 20 May 2009 14:23:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BDTR8mISzvIn9A/+zEzJ6vZRqqGhZ5s9LR2M80A9rls=;
        b=G5ofbaFE4V3Bg7TDbUh7sYpjLHfJoMB8UukUjL4uCtEm888wDL3LFsm+bCT+1mUFxT
         3xkyoeDBQdhncPc9frTJMcmFVEoY7DJjq7S+XfaBSPcHQ9ZYy6E9On8orPvjPKZkMqdK
         l9g/rJMHK2OL/fiDsrw5+rVO5uoZz1wuqYlSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o/PWbs4PBrJ+Sv7qSFUXXG+OI1bOtm9N97O/2m5kTGR1GxBeIyHU9KDGodoIyqFlAR
         gDTVXnQnu9XKQa2iYM3I8XTy0y75ayByw7mvGbKokbNOGtEF1MJgzr5eXI0jJfbzWS4M
         pgGTPqVQQOWYIWX7eHpZ7IpyUK/3KrQG+YrYI=
Received: by 10.114.180.1 with SMTP id c1mr3631883waf.206.1242854616588;
        Wed, 20 May 2009 14:23:36 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id d20sm3903295waa.12.2009.05.20.14.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:23:35 -0700 (PDT)
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
Subject: [loongson-support 01/27] fix-warning: incompatible argument type of pci_fixup_irqs
Date:	Thu, 21 May 2009 05:23:21 +0800
Message-Id: <f3a0b5ce4e2e228576f4481f4dfff8d75d33db7a.1242851584.git.wuzhangjin@gmail.com>
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
X-archive-position: 22852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

arch/mips/pci/pci.c:160: warning: passing argument 2 of ‘pci_fixup_irqs’
from incompatible pointer type

include/linux/pci.h:

	void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
            int (*)(struct pci_dev *, u8, u8));

arch/mips/pci/pci.c:160:

	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);

arch/mips/include/asm/pci.h:

	extern int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);

arch/mips/pci/fixup-malta.c

	int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
