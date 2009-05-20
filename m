Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:29:23 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:51742 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025150AbZETV3M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:29:12 +0100
Received: by pzk40 with SMTP id 40so616333pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:29:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MARaB1SJqOUfW/qs7LVT5gGxuJJyPz6aTjpezA5yAI4=;
        b=WVT8f/x4AhhKxbRfLp0rMGDOoM9FTgQxfvPHR0LWqPqSv5giO5U3SGVTF1/ndPFso1
         IRQ6zdaNwq2aUTyUGMWF06wLGtBlF0SGOtoP7bwjdXx8ZvmQhwd2qaZRNYjUM5OTw/gB
         EutMTj5I9d3KwOp7noEB+klMLnL3BSg/KYYuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JrR0UNELF5U/3xC7FtfhGOBdqTsZvd9bR+urv6PBottiqT8V3RY2j/NHjyYu/vVeLG
         6m410JNCTROVdOX8lEM3IadTqVwTQCDYLztkuwu6U1iCNUPuMW3OGW7WR1D1qLtxZ7Nk
         3NKINYdRWiQcusFkgyc9SgGz/RYIDEtXWDJjg=
Received: by 10.114.159.17 with SMTP id h17mr3471385wae.197.1242854945906;
        Wed, 20 May 2009 14:29:05 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id m28sm3971502waf.2.2009.05.20.14.29.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:29:05 -0700 (PDT)
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
Subject: [loongson-support 11/27] split the loongson-specific part out
Date:	Thu, 21 May 2009 05:28:54 +0800
Message-Id: <5760e95a45f5dadadf2891fa19060012c0eaafd1.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

for sharing lots of loongson-specific source code among loongson-based
machines, there is a need to split the loongson-specific part out to a
common/ directory.

and the machine-specific files are put in the machine-name/ directory.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
