Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 21:15:10 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.159]:39995 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20035239AbYANVPC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 21:15:02 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2263089fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 13:15:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        bh=+gyUYqrNLcov+1WpdS0lSAIXnTivwZKZx+xbGVLz+YA=;
        b=qKwaJg5GXpdmPul0LyNTEFPkgT/BWSqC/UaLcgGtRRLSbOn3TTc7VabefZudPCP5hXcVszkepre9EDh7SipldbaniTwa+xbWD+Ywg0YJdWs0WJv91XsqmRcvESWXJ8Zce7FG99irideBJDQ3WqI1GH3IbH5Lpe0u5JDkAS3d/ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=rOBqYYn/oWtQ3cmbwzd47Idqf79xqUTdGxQQ/wqsPpSE/H80sHOtgchbIFK4w0vahryq1BfBB0kdzDL1T4S+QRUDBRtpiZFyvfFhtoTPxytI2OvBNU1ZnRa/8j+3qWBJ2rDykcNK14AkI1YJjSle1R9mpQQGMCopFNWkjYdMsZQ=
Received: by 10.86.51.2 with SMTP id y2mr6668131fgy.6.1200345301731;
        Mon, 14 Jan 2008 13:15:01 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.85])
        by mx.google.com with ESMTPS id e11sm5522660fga.5.2008.01.14.13.15.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 13:15:01 -0800 (PST)
Message-ID: <478BD0D2.2060004@gmail.com>
Date:	Tue, 15 Jan 2008 00:14:58 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
CC:	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][MIPS] Add Atlas to feature-removal-schedule.
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle on Atlas board support in the linux-mips mailing list:

Maciej is promising to fix it up since a few years ;-)  Aside of that it's
safe to say the Atlas is dead like a coffin nail.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 20c4c8b..c053318 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -333,3 +333,11 @@ Why:	This driver has been marked obsolete for many years.
 Who:	Stephen Hemminger <shemminger@linux-foundation.org>
 
 ---------------------------
+
+What:	Support for MIPS Technologies' Altas evaluation board
+When:	March 2008
+Why:	Apparently there is no user base left for this platform.
+	Hardware out of production since several years.
+Who:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
+
+---------------------------
-- 
1.5.3
