Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:28:22 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:56098 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025147AbZETV2P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:28:15 +0100
Received: by rv-out-0708.google.com with SMTP id k29so229203rvb.24
        for <multiple recipients>; Wed, 20 May 2009 14:28:13 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+LB5lDc79BVdBuVgtI1gH6uW9DcqjQgtf+L8ZfK9cVE=;
        b=Km4eI1xntGapw06ep+PKe522D9YNCuILDfgngmSgT82z2PFD6Lq/Y9s8+F/21fymO2
         3sUfAP9LXDqOkBHUaQqlmh2zzk2Jmh2iqJhaguTcd85n0ZQYbzTuCre1HUSabTa9FgUO
         21g6V7x8mP4wPR+wEHLUP4CNo/X+nAJmbOW24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DNZhY1/r/4aMiY107pa/1rQDgnaW2ZXBRpR9qcp6ST3ypM3blbcO6uPF1C2c9Sp9PG
         ExEETRpk/7zg/x7GCs5hyyN2bYvEf39CDK0UIFInIY9E5HJ1vzHay/rip6TevYds2SiR
         Vf0ZHHUZDLs09QC5SNdmmbgYwDrgaSP9/YT+k=
Received: by 10.141.76.1 with SMTP id d1mr855568rvl.110.1242854893630;
        Wed, 20 May 2009 14:28:13 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id g31sm4603236rvb.13.2009.05.20.14.28.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:28:11 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	rtc-linux@googlegroups.com
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-support 09/27] enable Real Time Clock Support for fuloong(2e)
Date:	Thu, 21 May 2009 05:27:54 +0800
Message-Id: <3d13efa122929c5de37175a6da07b3bd856ab226.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

by default, RTC_LIB is selected by MIPS, but if RTC_LIB is enabled,
Enhanced Real Time Clock Support(RTC) will be disabled, so, to enable
it, not select RTC_LIB in LEMOTE_FULOONG2E will fix this problem.

RTC support is needed by some tools like hwclock, if you want hwclock
work well, these two jobs need to do:

kernel configuration:

Device Drivers --->
Character devices --->
<*> Enhanced Real Time Clock Support (legacy PC RTC driver)

user-space configuration:

$ mknod /dev/rtc c 10 135

and there is another RTC support in linux, whose kernel option is
RTC_CLASS, it should be fixed for fuloong(2e) via enabling the binary
mode in driver/rtc/rtc-cmos.c and register the RTC device resource in a
machine specific rtc.c

to make hwclock work with it normally, please do:

kernel configuration:

Device Drivers --->
<*> Real Time Clock --->
	<*>   PC-style 'CMOS'

user-space configuration:

$ mknod /dev/rtc0 c 254 0

/dev/rtc0 is the default RTC device file.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
