Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 02:21:41 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57118 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494108AbZKEBVe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 02:21:34 +0100
Received: by pwi11 with SMTP id 11so3664671pwi.24
        for <multiple recipients>; Wed, 04 Nov 2009 17:21:25 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=tc7vz03WIlXtccCmDS5L0kynSxbxLiFdEDkFSR9ZESQ=;
        b=ph+tbL5Lbuy+0YBZBDyI3uuoyjsfjZVKcUZzGE9QuEyb1BWc+JmJXqlAY8kGiUFGRK
         nvas2c5tV7ZiO7ATDWdSrczHAflaFedei43P6qgnqh1gnpoX7r8jHdm3rc6dYDpofuW9
         yQJvNUsRKR0QI17Z9YH2u7h5yILFprOOB7vlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gyf5Nlg7g3ksqEN4xBEBF9Hm/1sh4riKVxtVBXubkbBKctQVa3m235iCRYfZI8YrTM
         CkYRxgscH2v/piZVGdg3ZROAYs8hRqsUhEfCfTqLEDhCZQOVUEkPv9RdhDGibXbG+Pq9
         I2QnfSgkI/knrwlLCbxLJEBXCUYXqtw/ZHDAU=
Received: by 10.114.4.14 with SMTP id 14mr3517968wad.224.1257384085058;
        Wed, 04 Nov 2009 17:21:25 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm955953pxi.6.2009.11.04.17.21.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 17:21:24 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Ralf Baechle <ralf@linux-mips.org>,
	Arnaud Patard <apatard@mandriva.com>
Cc:	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 0/3] add RTC_LIB support for loongson family machines
Date:	Thu,  5 Nov 2009 09:21:15 +0800
Message-Id: <cover.1257383343.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The coming three patchs add RTC_LIB support for loongson family machines, which
incorporated the feedback of the first patchset from Ralf and Arnaud Patard.

Hi, Paul Gortmaker or Alessandro Zummo, could you please help to apply the
first two patches to linux-2.6.32? 

And the third patch is for the queue branch of Ralf's -queue git repo.

Regards,
	Wu Zhangjin

Wu Zhangjin (3):
  RTC: rtc-cmos.c: fix warning for MIPS
  RTC: rtc-cmos.c: enable RTC_DM_BINARY of RTC_LIB for fuloong2e and
    fuloong2f
  [loongson] RTC: Registration of Loongson RTC platform device

 arch/mips/loongson/common/Makefile |    6 +++++
 arch/mips/loongson/common/rtc.c    |   43 ++++++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-cmos.c             |    8 +++---
 3 files changed, 53 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/loongson/common/rtc.c
