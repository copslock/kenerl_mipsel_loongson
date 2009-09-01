Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2009 20:26:38 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:44235 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494241AbZIAS0b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Sep 2009 20:26:31 +0200
Received: by fxm20 with SMTP id 20so277381fxm.0
        for <multiple recipients>; Tue, 01 Sep 2009 11:26:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=TLtbBscmrNt5Kj+Q8MTHiMcYuBMg3m84JPERBIhSPxY=;
        b=k6bAl9QZoRKK4y3Kc9qOe1AvXgldSgxXhXN25Q/iU4hj5bmTRqR3TGFoobtsMsATrr
         GHg5OYWRyCU0QdXyOtHY/kUwcaS454roqzZwU5UU1CFWxRk2DBJFbIlMtOoQ+1bp1MxQ
         A3splH1HYbOB5a1FnsQHJ1GtzLnm+3OqERVFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=GUG2Zt/dE1Rqcer8s79fS016eIYjYDHSuU4om5v4JYDu39tKMhtvffPhY0S9nHFPoq
         5nzFH0vkZ0Gy4hEtnWN5zkdo1CRRFHQPRYXM06LwWTq2ekwf/m35hWmQYzS/kP35VUyR
         nqlRyUKlvaMMwejnHaI84LRGWpGgnOOQnfkj8=
Received: by 10.204.163.5 with SMTP id y5mr5810288bkx.37.1251829583779;
        Tue, 01 Sep 2009 11:26:23 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 10sm91491eyd.15.2009.09.01.11.26.22
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 11:26:23 -0700 (PDT)
Message-ID: <4A9D68A7.9000902@gmail.com>
Date:	Tue, 01 Sep 2009 20:32:07 +0200
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MSP71xx: request_irq() failure ignored in msp_pcibios_config_access()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

Produce an error if request_irq() fails.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 109c95c..223d822 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -402,11 +402,12 @@ int msp_pcibios_config_access(unsigned char access_type,
 	 * allocation assigns an interrupt handler to the interrupt.
 	 */
 	if (pciirqflag == 0) {
-		request_irq(MSP_INT_PCI,/* Hardcoded internal MSP7120 wiring */
+		if ((request_irq(MSP_INT_PCI,/* Hardcoded internal MSP7120 wiring */
 				bpci_interrupt,
 				IRQF_SHARED | IRQF_DISABLED,
 				"PMC MSP PCI Host",
-				preg);
+				preg)) != 0)
+			return -1;
 		pciirqflag = ~0;
 	}
 
