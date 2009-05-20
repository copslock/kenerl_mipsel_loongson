Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:25:56 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.249]:1452 "EHLO
	rv-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025145AbZETVZt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:25:49 +0100
Received: by rv-out-0708.google.com with SMTP id k29so228917rvb.24
        for <multiple recipients>; Wed, 20 May 2009 14:25:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=869Il9uTs7KDRYjdLgxg3Ys4wDKqDY6+RpaBw7zDDmE=;
        b=Zn7zGDFVL0EdzdIRqiu6cssypqY+aPv5PNIpPXBmpZKFluu+I4m0U5++Wu6lK1tD3S
         oRFJqQz9JrMjVPkZDIqsaoIDXhWBSwmesx7xa3ImFS+CYkRuyB+4ApTec15XtGV+GD8/
         ozLMChwqhIjXI6TwEsNkq7pZ+YCcvBaChXxdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pcI1cTNbMSZ3VUnayHDTvF+QyTtUHvjX55QHDl+HjEBFUAmzlu5iehdmpVyuZu/Xtq
         J1Kc+TOKEk5paPnHa+c3F3TFWFigUvtD4OCKhP3Y/9wUiEp3zi+sSh9QCUaR70Khky+x
         qJ10IJOfGQ9cll9B+TJ+S9HjXMMqHYZzpgPQY=
Received: by 10.142.44.14 with SMTP id r14mr450752wfr.331.1242854746914;
        Wed, 20 May 2009 14:25:46 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 24sm718196wff.11.2009.05.20.14.25.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:25:45 -0700 (PDT)
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
Subject: [loongson-support 05/27] remove reference to bonito64.h
Date:	Thu, 21 May 2009 05:25:34 +0800
Message-Id: <01f3463d9bccf5786ed259bc93deee97df798673.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

in loongson2e, there is an internal bonito64 compatiable north bridge,
but in loongson2f and the later loongson revisions, this will change a
lot, so, remove reference from bonito64.h and create a new loongson.h is
better.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

arch/mips/include/asm/mach-loongson/loongson.h:206: ends with blank lines.
-- 
1.6.2.1
