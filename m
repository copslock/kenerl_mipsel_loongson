Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 14:00:11 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:41739 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022564AbZFDNAE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 14:00:04 +0100
Received: by pzk40 with SMTP id 40so735719pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 05:59:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=u+nsltYDdnjfVtXQla0aXV0FlWOpEWy6ZNdPEoKIHu8=;
        b=sL36pUegjyla43qnQT5SYApxI2fvXfWtAME5edpbAYTGN/lF6mUQvLVCrZEHG7Sem4
         YBg4G8mrht919Thz9ct/I7tY8q8PExz2vwVADLzFRVSdTp3kFSALOwjbhUrArz4n7Xqa
         8lrvPJOVR8WqEfKSae6s4T1h4gZJuQye9rLrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T81wV7JjxHGNOKELO/LSIfYpntK/nA6jdrFHigF5Xl//CYG8dIRB5L/odaaVPeTcq2
         HEprnDWyLrwwCuQmA7bRMhKqh5Vqkwp2iAUSTGiiPtZl3VHKrNp3B+kap0iuhlHUpZJ+
         jZC8CSzPclcigDFqpYIumFT4lkZ8xYzI0uJ0Q=
Received: by 10.114.67.17 with SMTP id p17mr2466266waa.163.1244120397266;
        Thu, 04 Jun 2009 05:59:57 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l38sm10940983waf.3.2009.06.04.05.59.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 05:59:56 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Wu Zhangjin <wuzj@lemote.com>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v3 01/25] add vmlinux.32 in .gitignore
Date:	Thu,  4 Jun 2009 20:59:44 +0800
Message-Id: <e0c8063caf1075d1eaf5e2d720f6563a9a2e61d7.1244120172.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244120172.git.wuzj@lemote.com>
References: <cover.1244120172.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 .gitignore |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 51bd99d..8ceeffb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -32,6 +32,7 @@
 tags
 TAGS
 vmlinux
+vmlinux.32
 System.map
 Module.markers
 Module.symvers
-- 
1.6.0.4
