Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2011 15:53:40 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:53192 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903614Ab1LVOxd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Dec 2011 15:53:33 +0100
Received: by iadk27 with SMTP id k27so14569245iad.36
        for <multiple recipients>; Thu, 22 Dec 2011 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=nVEMytF4T5xa8cZgu7bS6imq8oQ70QM6UHAUGignoCQ=;
        b=sf0dW0uL8JswhST7/A8gWUsSPk5TWtSXQAZFtoXJSZWGPsqE34lsk0VvkDMXy88XMI
         FOyQ6+61vzg4ODMUtcxKQUi33/jk/2v4VVkRwiX+zOjNPjWM946CPh3RkR+fJVydg+w3
         T12K+e22+AxFf7eRf4yIOctvmM+OZn1gdqkB4=
Received: by 10.43.43.130 with SMTP id uc2mr11550290icb.35.1324565606749;
        Thu, 22 Dec 2011 06:53:26 -0800 (PST)
Received: from hades ([58.210.254.98])
        by mx.google.com with ESMTPS id j3sm29894366ibj.1.2011.12.22.06.53.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Dec 2011 06:53:25 -0800 (PST)
Date:   Thu, 22 Dec 2011 22:53:17 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] vmlinux.lds.S: remove duplicate _sdata symbol
Message-ID: <20111222145317.GA411@hades>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18109


_sdata is defined twice in vmlinux.lds.S. According to vmlinux.ld.h
in asm-generic, _sdata should be marked at the beginning RO_DATA_SECTION.

 *      _sdata = .;
 *      RO_DATA_SECTION(PAGE_SIZE)
 *      RW_DATA_SECTION(...)
 *      _edata = .;

Remove the one that is marked at RW_DATA_SECTION.

Signed-off-by: Tony Wu <tung7970@gmail.com>
---
 arch/mips/kernel/vmlinux.lds.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index a81176f..924da5e 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -69,7 +69,6 @@ SECTIONS
 	RODATA
 
 	/* writeable */
-	_sdata = .;				/* Start of data section */
 	.data : {	/* Data */
 		. = . + DATAOFFSET;		/* for CONFIG_MAPPED_KERNEL */
 
-- 
1.7.4.4
