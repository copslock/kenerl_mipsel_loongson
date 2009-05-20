Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:25:14 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:64851 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025145AbZETVY7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:24:59 +0100
Received: by mail-pz0-f202.google.com with SMTP id 40so614649pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:24:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s/DPw/utjr92MINnuPgkqoJ5D75JadK3PlN6GpSZT4g=;
        b=Uxzya73TU38NBZ+IQCHthOI8mUNNZXHo8CKQS+T6NEqK5bJSS7ayJUb9AfPuz48Kh0
         kxzgB0IuKgWmvYlXGZP4PgoPtU5w7vD2NlA+4P76ishmNTiVroKk4afviIp+4jVPNGMm
         awLYhuPjOZ0gdaAPsF2ufvAgq7HTBdAIT9uK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=g5Eme/JHaRVaH18BXxAAAXGAU2l4YZLL14ryspK2Jyxm/R/FV9FxsVtB4lY2zK7YCj
         5l87g2OF/3z3vBWLI+oFAHlrUe+MCTuff7z+s6LqJdyYrpBCQkIrRcJNa9za8kfIKucc
         JcpuoKflhKmbaCsFNGv+CKV23xY21HHxH+s2E=
Received: by 10.114.58.15 with SMTP id g15mr3478138waa.226.1242854698869;
        Wed, 20 May 2009 14:24:58 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id j31sm876280waf.26.2009.05.20.14.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:24:58 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-support 04/27] change the naming methods
Date:	Thu, 21 May 2009 05:24:47 +0800
Message-Id: <c29fbc62564a7ed90e0d0cb8114a2c0b14155370.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

to support loongson-based machines made by non-lemote companies, some
lemote* names should be changed to loongson* names, and to support the
future loongson2f-based fulong machines, the current fulong's name
should be fuloong-2e or fuloong2e, and also, FULONG to FULOONG2E, lm2e
to fuloong2e, LEMOTE to LOONGSON.

at the same time, tons of lines have been cleaned up with the help of
scripts/checkpatch.pl

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

arch/mips/include/asm/mach-loongson/loongson.h:14: ends with blank lines.
-- 
1.6.2.1
