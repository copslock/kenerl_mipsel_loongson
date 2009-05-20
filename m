Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:26:46 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:33748 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023181AbZETV0h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:26:37 +0100
Received: by pxi17 with SMTP id 17so626620pxi.22
        for <multiple recipients>; Wed, 20 May 2009 14:26:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TGkbFiOzxeIi2LZ4OMwNPQWoiy3z3zJm5PP3wYWRHHY=;
        b=FQXQSM/U47my+n2ZU94rIuq3HJdgd8caxCgdZlxDcczN/mWGKTtscv4/IAXWwuwH9k
         IOsuIH6EIedQZ3tHq6jIOFThk/uapLtQAW4uGZnjcRJ1jUYplTykI+/EH4P9IYBfKZMH
         vYfV1OWcdLjcI4YQEp9NxdscIyFpe6i7wCB7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cExLjsuqaPCwsZx1kNs2xsYXm/Mb4DqY7c7CWef12edXft5fdcAh6B0zejjaw+ukDY
         HDQI4F/ud9o/hBc+oX1r78m1K8FURPoihHQwEGX3sm2VZN1kgJT1lHy+tyklguC6yDkq
         BmWCd+ElQ6/JZl5PfnSwQ8V48EMVISX8S5rW4=
Received: by 10.115.18.3 with SMTP id v3mr3534587wai.32.1242854791062;
        Wed, 20 May 2009 14:26:31 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id m30sm3950315wag.18.2009.05.20.14.26.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:26:29 -0700 (PDT)
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
Subject: [loongson-support 07/27] replace tons of magic numbers by understandable symbols
Date:	Thu, 21 May 2009 05:26:17 +0800
Message-Id: <a32a65a4b7c785030cc72adfa865db0311a4d52e.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

tons of magic numbers are replaced by understandable symbols, and two
new header files are added to support this substitution.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
