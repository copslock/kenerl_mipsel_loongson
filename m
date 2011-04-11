Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2011 14:56:59 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:35773 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490987Ab1DKM4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2011 14:56:53 +0200
Received: by iwn36 with SMTP id 36so6553274iwn.36
        for <multiple recipients>; Mon, 11 Apr 2011 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=VoI3ZvmUjucURZ9OhTtR3FGvlbTE5c7WuNr8805Np1o=;
        b=KVyG0wuJ6KheD2lAHnRF82SERKYDAgv9DdzV1Hr4FrRWoDlWTF24qTsAMzt7MQUvNM
         VQoCeU6fSMSk/EsP1rcT9j6jiuzu/42Qd2yyJnTVQRS85Ya9yN/TmVbGmTIwKh0ekbEq
         S7u8N8EXgHs+DlqxF+GdgUc6zcBFah7npIRhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=n5+IpdbTg1SgZkD9fpz3j0wTlbpR64SDMDnKx9hwc5DhO0ffQBcyNVa+JhIX//YOqr
         zoodEp8pq6sltzC4gLtV7Jij3+E4LVaCawUHnnvofpXSR22mJGBLF3uRk8miZzD0gkj6
         ji6uR4KVCJuDobij9NraK71Vxa9Ors2SGAHDg=
Received: by 10.43.135.8 with SMTP id ie8mr8565882icc.171.1302526605529;
        Mon, 11 Apr 2011 05:56:45 -0700 (PDT)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id o3sm4220044ibd.61.2011.04.11.05.56.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 05:56:43 -0700 (PDT)
Date:   Mon, 11 Apr 2011 21:56:39 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     yuasa@linux-mips.org, linux-usb <linux-usb@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] USB: ohci-au1xxx: fix warning "__BIG_ENDIAN" is not defined
Message-Id: <20110411215639.6c443295.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

In file included from drivers/usb/host/ohci-hcd.c:1028:0:
drivers/usb/host/ohci-au1xxx.c:36:7: warning: "__BIG_ENDIAN" is not defined

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/usb/host/ohci-au1xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ohci-au1xxx.c b/drivers/usb/host/ohci-au1xxx.c
index 17a6043..958d985 100644
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -33,7 +33,7 @@
 
 #ifdef __LITTLE_ENDIAN
 #define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C)
-#elif __BIG_ENDIAN
+#elif defined(__BIG_ENDIAN)
 #define USBH_ENABLE_INIT (USBH_ENABLE_CE | USBH_ENABLE_E | USBH_ENABLE_C | \
 			  USBH_ENABLE_BE)
 #else
-- 
1.7.3.4
