Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2009 22:18:01 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:54761 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494355AbZIAURy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Sep 2009 22:17:54 +0200
Received: by ewy25 with SMTP id 25so217506ewy.33
        for <multiple recipients>; Tue, 01 Sep 2009 13:17:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6gAZe4DCuHdeHhPTuE1u511ES02hQXs5ODPcmSauaFg=;
        b=Uq56xg4N9y+6BTt5GMNhsIhH9khZ4bTw+iDh+sO+blfAQr3L5rS0KEWtaFAUv3a0Z2
         +v210lMMo/jhxjQKIEVmm36lTKUYaLbrjTMW+pQFofHPoJcfuATGxDLKv5ryU9cC0waH
         4jHRbvp4P/2YmlYCXfWXe0P35HSOEEsDxRGC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cz7QEOa8E4GiMAAfWXetEO+KdAxeSIpLQSoSquM98TAJxuSmGvZ9zgWq6eCnj/miEB
         fToB8rV4in5jBCumRGET7808+rmqJWvJHbVrOMC8YIGlGWQw4e1GHIIBEPej5p3IVYSg
         czfh9ii2UcVTfXw7xu6RRWAs2R5yZJ1CD6dIw=
Received: by 10.210.127.13 with SMTP id z13mr6694280ebc.85.1251836264908;
        Tue, 01 Sep 2009 13:17:44 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 28sm82019eye.0.2009.09.01.13.17.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 13:17:44 -0700 (PDT)
Message-ID: <4A9D82C0.7070408@gmail.com>
Date:	Tue, 01 Sep 2009 22:23:28 +0200
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
MIME-Version: 1.0
To:	"Ithamar R. Adema" <ithamar.adema@team-embedded.nl>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MSP71xx: request_irq() failure ignored in msp_pcibios_config_access()
References: <4A9D68A7.9000902@gmail.com> <4A9D6E37.1030704@team-embedded.nl>
In-Reply-To: <4A9D6E37.1030704@team-embedded.nl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

Produce an error if request_irq() fails.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---

>> +            return -1;

> I'd personally suggest to return the actual value returned by
> request_irq, instead of returning -EPERM..... ;)
> 
> Ithamar.

The comments at the header states that it returns -1 on failure,
and so do the callers as well, but if preferred, below is as you
suggest.

Thanks,

diff --git a/arch/mips/pci/ops-pmcmsp.c b/arch/mips/pci/ops-pmcmsp.c
index 109c95c..32548b5 100644
--- a/arch/mips/pci/ops-pmcmsp.c
+++ b/arch/mips/pci/ops-pmcmsp.c
@@ -385,6 +385,7 @@ int msp_pcibios_config_access(unsigned char access_type,
 	unsigned long intr;
 	unsigned long value;
 	static char pciirqflag;
+	int ret;
 #if defined(CONFIG_PMC_MSP7120_GW) || defined(CONFIG_PMC_MSP7120_EVAL)
 	unsigned int	vpe_status;
 #endif
@@ -402,11 +403,13 @@ int msp_pcibios_config_access(unsigned char access_type,
 	 * allocation assigns an interrupt handler to the interrupt.
 	 */
 	if (pciirqflag == 0) {
-		request_irq(MSP_INT_PCI,/* Hardcoded internal MSP7120 wiring */
+		ret = request_irq(MSP_INT_PCI,/* Hardcoded internal MSP7120 wiring */
 				bpci_interrupt,
 				IRQF_SHARED | IRQF_DISABLED,
 				"PMC MSP PCI Host",
 				preg);
+		if (ret != 0)
+			return ret;
 		pciirqflag = ~0;
 	}
 
