Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:27:09 +0100 (BST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:33748 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025147AbZETV04 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:26:56 +0100
Received: by mail-px0-f187.google.com with SMTP id 17so626620pxi.22
        for <multiple recipients>; Wed, 20 May 2009 14:26:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U3SJz5/uOwB9bf/NoLEZMdybHMoy3Jq2Tr9lpJRf8Mg=;
        b=Vvulzd7f2KbOQ4dV52sgx/o9kFaIi/rCeFvvWCtbZo1s91U7XGpRFci2jQAurPutDp
         XUEUaAZhyYPdzG6SURYPd7vGq9RYjqh4f2XwylRCcs9A0kNAjFaCFigWWBWCXvNCcXNl
         tw2btb8vltwpDN8z9S/OyhrZr0+DL2o8jW8mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=skCN6ik14mPEws7/X3k1ciTJ6Hp3c4eV2bnp92j1YygIpbLo5gLFWJF4W83XJimCcm
         f5htzDV0GCQd9qc7muZU9EtmJnOZ5QhcLal0lhjycIzDDeHr1F1cDsRvtKamJu7SIA7R
         qLG0n8hVdv4Q27m3WIVc2TwQobK5dIG5frth8=
Received: by 10.114.159.16 with SMTP id h16mr3595323wae.35.1242854814322;
        Wed, 20 May 2009 14:26:54 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id m25sm3960604waf.44.2009.05.20.14.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:26:52 -0700 (PDT)
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
Subject: [loongson-support 08/27] clean up the early printk support for fuloong(2e)
Date:	Thu, 21 May 2009 05:26:42 +0800
Message-Id: <aa96f719cbfc41eda42b5847a8e2a617a374a1f2.1242851584.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

this is originally from the lm2e-fixes branch of Philippe's
git://git.linux-cisco.org/linux-mips.git

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

-- 
1.6.2.1
