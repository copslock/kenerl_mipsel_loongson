Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Jul 2008 09:43:54 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.168]:29253 "EHLO
	wf-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20032350AbYGZInr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 26 Jul 2008 09:43:47 +0100
Received: by wf-out-1314.google.com with SMTP id 27so3571010wfd.21
        for <linux-mips@linux-mips.org>; Sat, 26 Jul 2008 01:43:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=OkXMCvCm8XylKtWCPAl/+g9yN+n9mPOkuv4UbKx6IfE=;
        b=b3ssCADQ5k6C1UqKSj2TX1o+hXSdOSvn1LlSK7SksqmW1o4YqMbeLtRnJuxdqOrbll
         zhcwM9MemjjzS/jRAWxyJY0q7tFj2+5vmaS09VXn5nsXansfIqLEApwFfuSZ7FGq/lmz
         KTXWEspAVMLxfZX7b9nJUqH8dP5C0CmnYmWEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=mMbe5IcUjt1Bdo1N4Efl6WyQNdzp0Vgrp+IgTKyW6KqF1Cn87YkCM38EdOhlogueOr
         gf2Ooph2wsE/7hkhDwWmkoMI7b/L8ZdMFXp4tgCX7pUW6JOx9NcNYNkCSeg+0RFi/ZDI
         PQ5m15yI8S9Fnf3XR5DvzTswQTtUUpd96E3yI=
Received: by 10.142.53.19 with SMTP id b19mr849481wfa.167.1217061824984;
        Sat, 26 Jul 2008 01:43:44 -0700 (PDT)
Received: by 10.142.49.17 with HTTP; Sat, 26 Jul 2008 01:43:44 -0700 (PDT)
Message-ID: <64660ef00807260143i26aa0d1bn90eb5dc5de9f7504@mail.gmail.com>
Date:	Sat, 26 Jul 2008 09:43:44 +0100
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	linux-serial@vger.kernel.org
Subject: [PATCH] Allow PNX8XXX serial when PNX833x is selected.
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: ddeba17bc8588db5
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

This enables support for the serial console on PNX833x.
Same block as PNX8550 just need to unhide config option.

 Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Daniel Laird <daniel.j.laird@nxp.com>

--- a.updated/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -975,7 +975,7 @@

 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
-	depends on MIPS && SOC_PNX8550
+	depends on MIPS && (SOC_PNX8550 || SOC_PNX833X)
 	select SERIAL_CORE
 	help
 	  If you have a MIPS-based Philips SoC such as PNX8550 or PNX8330
