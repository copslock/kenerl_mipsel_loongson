Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:24:50 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:64851 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025144AbZETVYn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:24:43 +0100
Received: by pzk40 with SMTP id 40so614649pzk.22
        for <multiple recipients>; Wed, 20 May 2009 14:24:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TDvL7gVd6SpeOgk8rKZFbCnUnFwrgbxzVW8G2xCezvg=;
        b=FPB9A2wPzHwEcMplGsS/Qx4e0o5C1dV6lEKEtIT0tpgl9b0TWhM7W5ZCfvq5w+RQHO
         C9zYNIh3oGMcV51RMw5QEhWDwaoGUV8BAbtPI+okjWUzeq8yzAaTs+qynm6E2YQXyaGm
         t3IkAgAgIrXe8Cmg5iwNes7RXepVnwlv7+3xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Edl/yv1m4zm6mohQ8BGD/vcCnOTQqHuF9QqKs370CzDu/3SCsPbxnRVoNOJnxPyq3G
         xo+ryFrt2JI/0qrtPF27hCJAWbH9WkTURM0+XMW699CmcQ7BIs3924w6mr+ZF8CRkF63
         bYMuzd/QG/70R8S4epJsiUlpdES6vGYmp3fUs=
Received: by 10.142.177.5 with SMTP id z5mr710187wfe.235.1242854676212;
        Wed, 20 May 2009 14:24:36 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm4230321wfg.28.2009.05.20.14.24.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:24:35 -0700 (PDT)
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
Subject: [loongson-support 03/27] fix-error: incompatiable argument type of clear_user
Date:	Thu, 21 May 2009 05:24:25 +0800
Message-Id: <8f44bd7169af8d4fdafa42ce4750943ef4da439f.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

there are lots of warnings about the macro: clear_user in linux-mips.

the type of the second argument of access_ok should be (void __user *),
but there is an un-needed (unsigned long) conversion before __cl_addr,
so, remove the (unsigned long) will fix this problem.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
