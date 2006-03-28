Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 16:02:34 +0100 (BST)
Received: from fw01.bwg.de ([213.144.14.242]:31870 "EHLO fw01.bwg.de")
	by ftp.linux-mips.org with ESMTP id S8133536AbWC1PCZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 16:02:25 +0100
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.13.3/8.13.3) with ESMTP id k2SFCrom013652
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 17:12:53 +0200 (CEST)
Received: from kundenmail (193.47.152.5) by fw01-4.bwg.de (smtprelay) with ESMTP Tue Mar 28 17:12:53 2006.
Received: from ximap.arbeitsgruppe (217.81.172.162)
          by kundenmail with MERCUR Mailserver (v4.03.15 MTI1LTI0MzctNDg3Nw==)
          for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 17:14:21 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with ESMTP id 7A094174B2E
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 17:13:22 +0200 (CEST)
Message-ID: <44295272.5000006@rw-gmbh.de>
Date:	Tue, 28 Mar 2006 17:12:50 +0200
From:	=?ISO-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] rtc.h: fixes to make genrtc.c compilable
References: <20060327074352.GC4781@dusktilldawn.nl> <4427A31F.9080801@ru.mvista.com>
In-Reply-To: <4427A31F.9080801@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

!please ignore attached patch from mail before!

patch below makes genrtc.c compilable again
--
Ralf Roesch


diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
index a2abc45..82ad401 100644
--- a/include/asm-mips/rtc.h
+++ b/include/asm-mips/rtc.h
@@ -32,7 +32,7 @@ static inline unsigned int get_rtc_time(
   {
          unsigned long nowtime;

-       nowtime = rtc_get_time();
+       nowtime = rtc_mips_get_time();
          to_tm(nowtime, time);
          time->tm_year -= 1900;

@@ -47,7 +47,7 @@ static inline int set_rtc_time(struct rt
          nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
                          time->tm_mday, time->tm_hour, time->tm_min,
                          time->tm_sec);
-       ret = rtc_set_time(nowtime);
+       ret = rtc_mips_set_time(nowtime);

          return ret;
   }
