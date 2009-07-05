Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jul 2009 13:16:58 +0200 (CEST)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:65325 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491772AbZGELQv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 5 Jul 2009 13:16:51 +0200
Received: by ewy10 with SMTP id 10so3893236ewy.0
        for <multiple recipients>; Sun, 05 Jul 2009 04:10:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EhmqvfeDlpNm20PykHxQTyCJgtpUG67yJm0GNCCUE7o=;
        b=tMX7BzlpXMrMZv3mT5AeWtbZd5UxBvOoAHSRooqZSgL83VX1xMTkRLhoCZwcg+K9ag
         6LSXtdNlbPmcJt6xwHthjAYjCfesaq8NF9aeZpOUKlLSZOzHC3lfs9y07JLg6uNoFJD2
         LraaBgfaSoYz6uGcakMs1jo931xuLhV6ssQu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=R3i4ZjmU3eYgkuTBbjm0tTiOuDby66LObxSwDNaVjrFRKxf1PjPYbVM1B//Y8Dz/LE
         jfb+uQ4QoCltnGUsNUDe3NdB6jrFeAZCq4gZPO62Wjrpa7GjGUidQEWAgwtoYUsqpGLi
         hfm5nm6J7+ivOWDsAmVS3oULrq0U/cMkCWZ8M=
Received: by 10.210.81.9 with SMTP id e9mr3393726ebb.68.1246792211285;
        Sun, 05 Jul 2009 04:10:11 -0700 (PDT)
Received: from lenovo.mimichou.home (home.mimichou.net [82.67.132.19])
        by mx.google.com with ESMTPS id 28sm8287505eye.16.2009.07.05.04.10.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Jul 2009 04:10:07 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Subject: Re: mtd related Cobalt build failure with current git
Date:	Sun, 5 Jul 2009 13:10:01 +0200
User-Agent: KMail/1.9.9
Cc:	Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
	dwmw2@infradead.org
References: <20090704213741.GA6438@deprecation.cyrius.com>
In-Reply-To: <20090704213741.GA6438@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200907051310.02673.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Martin,

Le Saturday 04 July 2009 23:37:41 Martin Michlmayr, vous avez écrit :
> I get the following Cobalt build failure with current git:
>
>   CC      arch/mips/cobalt/mtd.o
> cc1: warnings being treated as errors
> In file included from arch/mips/cobalt/mtd.c:22:
> include/linux/mtd/partitions.h:50: warning: ‘struct mtd_info’ declared
> inside parameter list include/linux/mtd/partitions.h:50: warning: its scope
> is only this definition or declaration, which is probably not what you want
> include/linux/mtd/partitions.h:51: warning: ‘struct mtd_info’ declared
> inside parameter list include/linux/mtd/partitions.h:61: warning: ‘struct
> mtd_info’ declared inside parameter list include/linux/mtd/partitions.h:67:
> warning: ‘struct mtd_info’ declared inside parameter list make[1]: ***
> [arch/mips/cobalt/mtd.o] Error 1
> make: *** [arch/mips/cobalt] Error 2
>
> Does anyone know if there's a fix for this already?

I also had that problem and did the following fix, which still applies to
the mtd-2.6 tree, master branch.
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] Fix arch/mips/cobalt/mtd.c build failure

This patch fixes a warning in include/linux/mtd/partitions which
results in the following build failure on MIPS:
 CC arch/mips/cobalt/mtd.o
cc1: warnings being treated as errors
In file included from arch/mips/cobalt/mtd.c:22:
include/linux/mtd/partitions.h:50: warning: 'struct mtd_info' declared inside parameter list
include/linux/mtd/partitions.h:50: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/mtd/partitions.h:51: warning: 'struct mtd_info' declared inside parameter list
include/linux/mtd/partitions.h:61: warning: 'struct mtd_info' declared inside parameter list
include/linux/mtd/partitions.h:67: warning: 'struct mtd_info' declared inside parameter list
make[1]: *** [arch/mips/cobalt/mtd.o] Error 1
make: *** [arch/mips/cobalt] Error 2

Reported-by: Martin Michlmayr <tbm@cyrius.com>
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/include/linux/mtd/partitions.h b/include/linux/mtd/partitions.h
index af6dcb9..c8eaf44 100644
--- a/include/linux/mtd/partitions.h
+++ b/include/linux/mtd/partitions.h
@@ -10,7 +10,7 @@
 #define MTD_PARTITIONS_H
 
 #include <linux/types.h>
-
+#include <linux/mtd/mtd.h>
 
 /*
  * Partition definition structure:
