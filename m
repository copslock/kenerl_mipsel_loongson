Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 02:58:33 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.244]:47739 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023888AbXIUB6Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 02:58:24 +0100
Received: by an-out-0708.google.com with SMTP id d26so109202and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 18:58:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2u3VLy4ZQPimOOmiY2baO7UqOzsyh/gFud0QmQmexTs=;
        b=c9Wx40C72MPEKzhRVsKR8iN+DswdiR0pHHSeTES74JUzONsQrOQtHa+9ve8/uKPpp7F71AWS/PyuWfeBpTIbVzmyw89IEsdlJAQqxxdaTKDJ++KoISDnvC/4V0Zo1GvQs+ffeW2KUG2f6rsT9RwLn1psYulYeVtvbTtzK1qNRwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NqCrF3UX5wRwNZl2KWsw4Q2vOaXvcP5vp3S5qjV+dbgtX6seymePssPnAeO5IbOAej8qo9752EuaYfv9t5METGsZzGqPhnUTJhHNoOqP9jnKaG4fgXQRmEdMYS9psx9DF9siyQ8xj9XEwFlYONGpH5ZKiKbiKSxQTODB01aTVow=
Received: by 10.100.94.3 with SMTP id r3mr1377101anb.1190339886664;
        Thu, 20 Sep 2007 18:58:06 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id c38sm360664anc.2007.09.20.18.57.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 18:58:04 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
Date:	Fri, 21 Sep 2007 03:57:52 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Florian Fainelli <florian@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	Nicolas Thill <nico@openwrt.org>, ralf@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200709201728.10866.technoboy85@gmail.com> <200709201743.48164.technoboy85@gmail.com>
In-Reply-To: <200709201743.48164.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200709210357.52742.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Forgot this:

diff --git a/include/asm-mips/page.h b/include/asm-mips/page.h
index e3301e5..73a59d1 100644
--- a/include/asm-mips/page.h
+++ b/include/asm-mips/page.h
@@ -184,8 +184,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
-#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
+#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE +	\
+				 PHYS_OFFSET)
+#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET -	\
+				 PHYS_OFFSET)
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
