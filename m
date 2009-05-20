Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:28:59 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:41356 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025147AbZETV2x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:28:53 +0100
Received: by pxi17 with SMTP id 17so627519pxi.22
        for <multiple recipients>; Wed, 20 May 2009 14:28:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C9vcV85NMBW80XQHXFcFCO03WUKTU7naHEUCydLa6k8=;
        b=dB/u/9hGGziSIvNU258DFDBHvbJKx/cCp/BA0GllXnESEY5iCMP6wxwSaI/i0+VK0K
         JxGvUE0f+ojY0agpBNKsFIWb5G1M2+LMOaCZa1tbSTEpHBsiuQ0z+lwxNMq9T8qqFGIZ
         EBR33HBCxPJNmDyWKZFIEXt7gtpKln7NwcMMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WkLSUF0OiQLlbhd+822v4vf5CC3OcUCeC78XptT65zlkWMrjfipz3jLu5ENS45h//P
         1T4Mp/dOiQzBxE0KPo0VFwevlTimJIwigtgh3B7gbiJzaibhvsBfxDX0sFODdqm81Fys
         iCxvF5VyaEm2VgZ3y7Ryr9kUUEP6BpnbH1BqI=
Received: by 10.142.221.11 with SMTP id t11mr617758wfg.115.1242854926713;
        Wed, 20 May 2009 14:28:46 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm348990wfd.19.2009.05.20.14.28.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:28:45 -0700 (PDT)
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
Subject: [loongson-support 10/27] add loongson-specific cpu-feature-overrides.h
Date:	Thu, 21 May 2009 05:28:35 +0800
Message-Id: <13b257a1608147ad3089a054e888ab240e19a75d.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This file will obviously reduce the size of kernel image file, reduce
tons of branches and enhance the performance.

$ wc -c vmlinux		// before
8054849 vmlinux
$ wc -c vmlinux		// after
7626936 vmlinux
$ echo $(((8054849-7626936)/1024))	// kb
417
$ echo "(8054849-7626936)/8054849" | bc -l
.05312489408553779220

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
