Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2009 22:56:53 +0000 (GMT)
Received: from ti-out-0910.google.com ([209.85.142.191]:26287 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S21365777AbZANW4v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Jan 2009 22:56:51 +0000
Received: by ti-out-0910.google.com with SMTP id i7so483188tid.20
        for <multiple recipients>; Wed, 14 Jan 2009 14:56:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:cc
         :message-id:mime-version:content-type:content-transfer-encoding
         :x-mailer;
        bh=k2Lk4p+p9meSzuDu7y5LHWNifGxTCTDpztqw1lW9Ed8=;
        b=kaXxTAmy6yoRzVy4ssPRIXIsVRV0LeHb0TlbL4F2QWrwv1WjK70CcLjFfXZt4NhyCv
         I5gUnsGmlnybCzrO4FFJPI7vAlJ48oDmFNI+KwlfCZmwed2aptKFTFQZpmDRCnkXic8s
         Y3ur9jIWHeq5Ki85JndHGecUHKQc1zVh7zJzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:cc:message-id:mime-version:content-type
         :content-transfer-encoding:x-mailer;
        b=cSumFKc0drpdHRv4VYOMMQye0qHyTJDLssVPYZSXLTLRRNaMG+2M585Rap3epyTec5
         MaMotntOMKNjiYqU/4g3vnf22nROk8MlBCoHuIqsDodsNdIbWm3QbbOCAcOSILe6xiyC
         1W9Y37zT8QPVUAGoo1PhO9F3uL1d+ELlnKrXg=
Received: by 10.110.28.15 with SMTP id b15mr724141tib.56.1231973805811;
        Wed, 14 Jan 2009 14:56:45 -0800 (PST)
Received: from ?192.168.2.20? ([222.95.172.180])
        by mx.google.com with ESMTPS id b4sm1970334tic.2.2009.01.14.14.56.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jan 2009 14:56:44 -0800 (PST)
Date:	Thu, 15 Jan 2009 06:56:46 +0800
From:	Huang Weiyi <weiyi.huang@gmail.com>
To:	ralf@linux-mips.org
Subject: MIPS: remove duplicated #include's
Cc:	linux-mips@linux-mips.org
Message-Id: <20090115065459.1F13.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [en]
Return-Path: <weiyi.huang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: weiyi.huang@gmail.com
Precedence: bulk
X-list: linux-mips

Removed duplicated #include's in 
  arch/mips/cavium-octeon/setup.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index e085fed..5f4e49b 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -15,13 +15,11 @@
 #include <linux/serial.h>
 #include <linux/types.h>
 #include <linux/string.h>      /* for memset */
-#include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/time.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
-#include <linux/string.h>

 #include <asm/processor.h>
 #include <asm/reboot.h>
