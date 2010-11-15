Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 05:53:06 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:48030 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491042Ab0KOExA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Nov 2010 05:53:00 +0100
Received: by ywf7 with SMTP id 7so1814926ywf.36
        for <multiple recipients>; Sun, 14 Nov 2010 20:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=7XuCggeZ/PbTrcbSRl9lE4StecQcW4x+jDJBvWpAbTA=;
        b=iZd8NSj27210vGEnk5biTtf/YaPssi4oGWOwQ0OwhnDwSLvh6aYiNSjjJHsS3ZL/H5
         QclEjgKA0FFcsYI6M137Koc1YWEtUp2U2Cq7dq9KOKrefyR5hlo2LGHhrGBX0Bbkq4kr
         r/G7xlI1PFdqH3GvtEsx5RR3Cr/K5aYuzkbO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L0v5ycmREtZwxUfJVQvnWNetgL/ZIT6HnSAjP+tabYeI+WtP9GtelgphjMewXi5Yh8
         FxWhZjjabDaSrO8X+eSYUmZJKr1fC/1xHkiYcpYoqkuEIRw9j70eA52opVnhZ9uSdZtd
         BLRiZkW3phwxaOsf8DcFVJbMbuKsIjKrBen0o=
Received: by 10.100.137.7 with SMTP id k7mr3955147and.248.1289796773306;
        Sun, 14 Nov 2010 20:52:53 -0800 (PST)
Received: from mattst88@gmail.com (cpe-065-190-173-137.nc.res.rr.com [65.190.173.137])
        by mx.google.com with ESMTPS id w15sm3328488anw.33.2010.11.14.20.52.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 20:52:52 -0800 (PST)
Received: by mattst88@gmail.com (sSMTP sendmail emulation); Sun, 14 Nov 2010 23:54:17 -0500
From:   Matt Turner <mattst88@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>, kaloz@openwrt.org,
        Mark Zhan <rongkai.zhan@windriver.com>
Subject: MIPS: RTC and hwmon for SWARM
Date:   Sun, 14 Nov 2010 23:53:46 -0500
Message-Id: <1289796829-29222-1-git-send-email-mattst88@gmail.com>
X-Mailer: git-send-email 1.7.2.2
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,
Following are three patches that enable hwmon and rtc on SWARM.

They were found [1] where there are two more as well.

I've said that Maciej is the author, because [2], but I also see [3]. 
There's a pretty extensive commit message in [2] that I haven't included
so maybe Maciej would like to comment on this patch. The first patch
probably needs to go through the RTC tree anyway, but I wasn't sure if
it was needed for the subsequent patches.

I've tested these patches on my SWARM and they work fine.

Thanks,
Matt

[1] https://dev.openwrt.org/browser/trunk/target/linux/sibyte/patches/
[2] http://lkml.org/lkml/2008/5/12/391
[3] http://lists.lm-sensors.org/pipermail/i2c/2007-September/001907.html
