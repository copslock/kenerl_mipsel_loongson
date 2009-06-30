Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jun 2009 16:46:43 +0200 (CEST)
Received: from wf-out-1314.google.com ([209.85.200.174]:30500 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493041AbZF3Oqh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jun 2009 16:46:37 +0200
Received: by wf-out-1314.google.com with SMTP id 28so59543wfa.21
        for <multiple recipients>; Tue, 30 Jun 2009 07:41:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=CI8/mEaWm0rVuZpi7JST8Wpsz7wWILBB7uO6tIAtTys=;
        b=cy/QV6w9XqXWGIT1zyzStB6dmTJ31ZmDSY5uFLnaaJBVHe0y1CD9Q6N8qpTmihiL6R
         JiC2/gfEWgY1wfrOUBpssy/iSFRW4sr9uAQ++pitLHQHQntUIWwdZ1OxjRV5VcpXj3Vy
         l+wRNEuVIj4RP0OB8l1syNjfUquljQxo4f87s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=OTg5ViMGlyM9jh7xgEoFVkXUCJjbvCZFn+n1t81IgB6qTRozC8EDNyHYtyu61sVGP/
         Ss6ap2QSPHnIfaI/hjaEcLae6C10NXGOSSZLnihF1KtdcmNAHuOkZhKbP2zA5+cPDhAx
         ql0TjpHiRbfkWqSMQ2o7mwDjtHuDo6k6fFwTE=
Received: by 10.142.201.3 with SMTP id y3mr546377wff.302.1246372885223;
        Tue, 30 Jun 2009 07:41:25 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id b39sm2152313rvf.8.2009.06.30.07.41.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 07:41:24 -0700 (PDT)
Subject: [BUG] MIPS: Hibernation in the latest linux-mips:master branch not
 work
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Cc:	Pavel Machek <pavel@ucw.cz>, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 30 Jun 2009 22:41:08 +0800
Message-Id: <1246372868.19049.17.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I just updated my git repository to the master branch of the latest
linux-mips git repository, and tested the STD/Hibernation support on
fuloong2e and yeeloong2f, it failed:

when using the no_console_suspend kernel command line to debug, it
stopped on:

PM: Shringking memory... done (1000 pages freed)
PM: Freed 160000 kbytes in 1.68 seconds (95.23 MB/s)
PM: Creating hibernation image:
PM: Need to copy 5053 pages
PM: Hibernation image created (4195 pages copied)

and then, the number indicator light of keyboard works well, but can not
type anything. 

anybody have tested it on another platform? does it work?

Regards,
Wu Zhangjin
