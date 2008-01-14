Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 23:25:11 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.154]:16880 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20035795AbYANXZC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 23:25:02 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2298715fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 15:25:02 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=MDdcqzlTvkeNtLNrcjT7cTeAo6gu4ptBERJDdw0avA0=;
        b=Ud128pWOfGiYPOvm9GmVhWLkDRgWASiroJnEd1rT9valIeXjMHhX5pZWI1RuFcjtvDsf/d67ms6HxEPzOAheFa3UJEtv5C6VX5sEWBmXTbkVngh0uIhUWwJ2qo43VBqqqZsVu3S/OaSpx2DJOhz5GGEliysA5M7mgFDFdjEFC48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Mo071wRkXbBFpybYmco+4WR7qO0MpwD0T2lD2cu/a/3Af82I6pT7hKklVNJ1LdOeIWz8kXo0ibdf83BTlRN6KyGqibHfvQHADJPBZpXI5wXAhAmbGPbCOINmEyqlqCokMC/SNn8Nf31pWwbHMCcJwQAtvDMG+Cyz23SMvycO1MI=
Received: by 10.86.84.5 with SMTP id h5mr6732686fgb.75.1200353102089;
        Mon, 14 Jan 2008 15:25:02 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.28.153])
        by mx.google.com with ESMTPS id l19sm7097316fgb.3.2008.01.14.15.25.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 15:25:01 -0800 (PST)
Message-ID: <478BEF4A.80805@gmail.com>
Date:	Tue, 15 Jan 2008 02:24:58 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
CC:	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH -v2][MIPS] Add Atlas to feature-removal-schedule.txt
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle on Atlas board support in the linux-mips mailing list:

> Maciej is promising to fix it up since a few years ;-)  Aside of that it's
> safe to say the Atlas is dead like a coffin nail.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>

---
diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 20c4c8b..2693ebc 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -333,3 +333,11 @@ Why:	This driver has been marked obsolet
 Who:	Stephen Hemminger <shemminger@linux-foundation.org>
 
 ---------------------------
+
+What:	Support for MIPS Technologies' Atlas evaluation board
+When:	March 2008
+Why:	Apparently there is no user base left for this platform.
+	Hardware out of production since several years.
+Who:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
+
+---------------------------
