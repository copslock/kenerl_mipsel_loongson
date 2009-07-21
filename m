Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 14:44:50 +0200 (CEST)
Received: from mail-ew0-f215.google.com ([209.85.219.215]:59994 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493260AbZGUMon (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 14:44:43 +0200
Received: by ewy11 with SMTP id 11so3140259ewy.0
        for <multiple recipients>; Tue, 21 Jul 2009 05:44:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=nSvZqk1S5pJnoLRHZNJvDjf6UrcxZW86/wfOVXIBpl0=;
        b=XF6oUBSOuuJUxJ1IlGqRKXnhwMECut370T6hzkx+/VV7T9dwBMdQCccr5mhp7Delzg
         Z2ckrAUuErYcZjB5CG1YWUl9SIkjRXQCwsRkFtsl5WAWiRSmbdIVFJZ8B6MUZuXNrgB7
         qgM4xdc7fCT24hhWD6k4h/PWYkxWgwTC/WgMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=J0Pu/skla1iASUZFp7upxJv+sOp1xXIel6bAAb5VAyTlYhKuebo/Di2qnVRVgjXSVw
         f+y8/OEnk0tkanqEhvQ/UJhA/cXS0iYKZTMsshcFmQCVmVGjY0e9G7rFPCBP9FBAuQLw
         ldvYhKTxvPfD86uf7djtKA0SBde6keWx0swDA=
Received: by 10.210.10.11 with SMTP id 11mr5031258ebj.5.1248180277967;
        Tue, 21 Jul 2009 05:44:37 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 10sm1697426eyd.18.2009.07.21.05.44.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 05:44:37 -0700 (PDT)
Message-ID: <4A65B8BB.40502@gmail.com>
Date:	Tue, 21 Jul 2009 14:46:51 +0200
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
MIME-Version: 1.0
To:	rjw@sisk.pl, ralf@linux-mips.org,
	linux-pm@lists.linux-foundation.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mips: decrease size of au1xxx_dbdma_pm_regs[][]
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

Only registers [0-DDMA_CHANNEL_BASE][0-6] are used by the suspend
and resume routines.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
These routines are on the bottom of the file. Only used are
registers:

au1xxx_dbdma_pm_regs[0][0-3]

and 

au1xxx_dbdma_pm_regs[1-NUM_DBDMA_CHANS][0-6]

Is my patch right, that assumes that the array can be smaller, or
should the storage and recovery of other registers be added?

Roel

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 3ab6d80..bf48a21 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -175,7 +175,7 @@ static dbdev_tab_t dbdev_tab[] = {
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
 #ifdef CONFIG_PM
-static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][8];
+static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS][7];
 #endif
 
 
