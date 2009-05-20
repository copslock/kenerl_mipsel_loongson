Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:26:21 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:55687 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025147AbZETV0O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:26:14 +0100
Received: by pzk40 with SMTP id 40so615268pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:26:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Mk8MBxYVbDCDjXInRiRbhLD9U3KcIH2c/Sq3koLumZg=;
        b=UTMZpSjMsNt2xP235Oww2uy+nfxSZoAGQuK/zmP+z8RKcc3N3ZhwCZwb8wMJjjsQCP
         MW4MgvJoufWqCuUYCUmPNhOFeaEZ85zkCxwWOrk8rZz56BG1O56V+Oiwwpnf/Z5nQM+m
         w/CO5RhZnxJbna4WPm0rVl6EX0Y4QUcaOnkJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RfndEC+wapCXkuI4QK0EeSRDmjcdXCt3hAEB+VP7arURJoH1dx3WzBVVN1A0u4IXve
         9MgyOub0+D0o76gEU/qH3SP9G3BN54HdzEcMA1uQfsJ+QXn5FxwjaYBuhWqIekoVEpZk
         zy3zBQGI46+VXKnLm5/AjgHcnLaF5bqHGAXFU=
Received: by 10.142.68.5 with SMTP id q5mr618496wfa.114.1242854767533;
        Wed, 20 May 2009 14:26:07 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 27sm4402058wff.6.2009.05.20.14.26.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:26:06 -0700 (PDT)
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
Subject: [loongson-support 06/27] divide the files to the smallest logic unit
Date:	Thu, 21 May 2009 05:25:55 +0800
Message-Id: <9944ac1eb11fbbf996ee649dd6053b0baffef50f.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

to enhance the maintainability and scalability of the source code, there
is a need to divide the files to the smallest logic function unit.

at the same time, the header files references are cleaned up, and some
loongson2e* names are changed to loongson* for future source code
sharing between loongson-2e and loongson-2f

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
