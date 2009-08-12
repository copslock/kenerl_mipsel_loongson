Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2009 21:59:42 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34329 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493605AbZHLT7f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2009 21:59:35 +0200
Received: by ewy12 with SMTP id 12so333319ewy.0
        for <multiple recipients>; Wed, 12 Aug 2009 12:59:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=aBDF+DAb7xNe1NA4gzl4SXhExo/kp2fM9PkBmQBLCIo=;
        b=d6l/zi5LDzXH3tqCktkLCn5v9QqUjQohnXxkwiK9I5+P4i2OCzwaLygwN9sv+hBZEe
         jacWaI6bcHeBpQ8wGKgHlf5Hjveg8iN/5nqPV/JyU5nStmVMnsQ9EbihRjXtS9NRAhTN
         QUd+jfplibWZwSGLY+WUsE05RFPBsr0xrUQzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=CyHq966sAE3YWwGu9kOfdjNon2wC9pG+jlcIS9JZE7MOsQNCSe9ZkTRI96vZcAQvfn
         gmhmF7EVbtT6bJ2FxT9LlGbXQcpiBwd6fvicbgBTJJjPnTdULYTDzqSsMrrbyvSGKYsB
         aAAAsGSMfN7ZWn/SIaliqoD56PbfGfH9IWE6o=
Received: by 10.210.144.16 with SMTP id r16mr504045ebd.22.1250107170425;
        Wed, 12 Aug 2009 12:59:30 -0700 (PDT)
Received: from localhost ([213.171.34.225])
        by mx.google.com with ESMTPS id 28sm3334585eye.4.2009.08.12.12.59.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 12:59:30 -0700 (PDT)
Date:	Wed, 12 Aug 2009 23:59:27 +0400
From:	Alexey Dobriyan <adobriyan@gmail.com>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] mips: fix compilation of mips-lasat
Message-ID: <20090812195927.GA2647@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <adobriyan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adobriyan@gmail.com
Precedence: bulk
X-list: linux-mips

Header needed for current_cpu_data which expands to smp_processor_id().
However, linux/smp.h can't be included into asm/cpu-info.h due to
horrible circular dependencies, so plug it here.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/mips/include/asm/lasat/lasat.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/lasat/lasat.h
+++ b/arch/mips/include/asm/lasat/lasat.h
@@ -227,6 +227,7 @@ extern void lasat_write_eeprom_info(void);
  * It is used for the bit-banging rtc and eeprom drivers */
 
 #include <linux/delay.h>
+#include <linux/smp.h>
 
 /* calculating with the slowest board with 100 MHz clock */
 #define LASAT_100_DIVIDER 20
