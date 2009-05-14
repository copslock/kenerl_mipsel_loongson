Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 19:29:39 +0100 (BST)
Received: from web65307.mail.ac2.yahoo.com ([68.180.158.233]:21256 "HELO
	web65307.mail.ac2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20025917AbZENS3d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 May 2009 19:29:33 +0100
Received: (qmail 31056 invoked by uid 60001); 14 May 2009 18:29:27 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1242325767; bh=srhgTM3XJtyE3xpU+7sHUI4MinQ2RIGipxCpP4jOPP8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=Pt5FHKZ24FHF5dR2ymVCBYdgjChjkb6IIyxuaVKGtVWiOtjF8lrx/GvjiINuOLlUIYllTNI1EbjkEfLEL72+bMIl2ANJLyThbBUrCr8Spu8+HDuVvwS/nxm/5o838lx5iE5Q9D40dXKArAGePrQIlG4bzcqeQXNRCHZ+6/a0b2g=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=l+csaBSUkcUejy1eePqfA4RjWpw304kv2WEjFRORUsp0txYc2XoifcV6rAToMXtKOCJ+uoPuUwZeNrxEKG6/wAGgcJPlbngm6UKr12BwG4eLmQ0+SfA8dlevUdnlG/afkRQfVRV97gdmrRNSWEQvqiaATKP9fDCFHYwAYEop1WA=;
Message-ID: <273990.30979.qm@web65307.mail.ac2.yahoo.com>
X-YMail-OSG: X3gkQYQVM1nCEhImPoAYivN4cab5lcs1tqsyUeW2MFcL6MkHxu6fVh889E6sEV1A4KMY9jc26NaRkSDBuSJaGH4wynoWl0wQSc7APsq4wq108.iaWVt.WHCqo98WKjc8DWJRiggRnM_S5uZJuEW5i.nWNs419VCQogNrm9ESGosN9XMuaWqYOExmM0VktzNm8i5RSWcTkV0ecnFoBIb4R4TXYvz9trp_rS79sdAU9734LNg_lxyIysDZRhQjcJIW__Ke_uLBRFTlGzB2tappCA--
Received: from [91.196.252.17] by web65307.mail.ac2.yahoo.com via HTTP; Thu, 14 May 2009 11:29:27 PDT
X-Mailer: YahooMailClassic/5.2.20 YahooMailWebService/0.7.289.1
Date:	Thu, 14 May 2009 11:29:27 -0700 (PDT)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Subject: [PATCH] IP32 power button fix for 2.6.30
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips



I think i run into same sort of problem, as described here:

http://lkml.org/lkml/2009/4/16/24
http://lkml.org/lkml/2009/4/14/94

(in my case it was hang after pressing O2's power button)

this patch fixes it:

----

diff --git a/arch/mips/sgi-ip32/ip32-reset.c b/arch/mips/sgi-ip32/ip32-reset.c
index b6cab08..667da93 100644
--- a/arch/mips/sgi-ip32/ip32-reset.c
+++ b/arch/mips/sgi-ip32/ip32-reset.c
@@ -145,7 +145,7 @@ static irqreturn_t ip32_rtc_int(int irq, void *dev_id)
                        "%s: RTC IRQ without RTC_IRQF\n", __func__);
        }
        /* Wait until interrupt goes away */
-       disable_irq(MACEISA_RTC_IRQ);
+       disable_irq_nosync(MACEISA_RTC_IRQ);
        init_timer(&debounce_timer);
        debounce_timer.function = debounce;
        debounce_timer.expires = jiffies + 50;

----

tested with 2.6.30-rc5 mainline (linux-mips.org tree was also affected)


      
