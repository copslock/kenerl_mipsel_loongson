Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Apr 2006 16:04:37 +0100 (BST)
Received: from fw01.bwg.de ([213.144.14.242]:64933 "EHLO fw01.bwg.de")
	by ftp.linux-mips.org with ESMTP id S8133791AbWDDPEP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Apr 2006 16:04:15 +0100
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.13.3/8.13.3) with ESMTP id k34FFNxk017609
	for <linux-mips@linux-mips.org>; Tue, 4 Apr 2006 17:15:24 +0200 (CEST)
Received: from kundenmail (193.47.152.5) by fw01-4.bwg.de (smtprelay) with ESMTP Tue Apr  4 17:15:17 2006.
Received: from ximap.arbeitsgruppe (217.81.168.137)
          by kundenmail with MERCUR Mailserver (v4.03.15 MTI1LTI0MzctNDg3Nw==)
          for <linux-mips@linux-mips.org>; Tue, 4 Apr 2006 17:16:43 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with ESMTP
	id DA1FC174B2E; Tue,  4 Apr 2006 17:15:49 +0200 (CEST)
Message-ID: <44328D82.1040907@rw-gmbh.de>
Date:	Tue, 04 Apr 2006 17:15:14 +0200
From:	=?ISO-8859-1?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] rtc.h fix
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

patch below makes genrtc.c compilable again

Signed-off-by: Ralf Roesch <ralf.roesch@rw-gmbh.de>

diff -Nur -X diff-exclude-files-2.6 linux-2.6/include/asm-mips/rtc.h 
work-2.6/include/asm-mips/rtc.h
--- linux-2.6/include/asm-mips/rtc.h	2006-03-08 14:43:43.000000000 +0100
+++ work-2.6/include/asm-mips/rtc.h	2006-04-04 15:56:38.000000000 +0200
@@ -32,7 +32,7 @@
  {
  	unsigned long nowtime;

-	nowtime = rtc_get_time();
+	nowtime = rtc_mips_get_time();
  	to_tm(nowtime, time);
  	time->tm_year -= 1900;

@@ -47,7 +47,7 @@
  	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
  			time->tm_mday, time->tm_hour, time->tm_min,
  			time->tm_sec);
-	ret = rtc_set_time(nowtime);
+	ret = rtc_mips_set_time(nowtime);

  	return ret;
  }
