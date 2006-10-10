Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 14:49:50 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:49139 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20039871AbWJJNtq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Oct 2006 14:49:46 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k9ADn9YG013160;
	Tue, 10 Oct 2006 06:49:13 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k9ADnWug007750;
	Tue, 10 Oct 2006 06:49:33 -0700 (PDT)
Message-ID: <003301c6ec73$cfe3ba00$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	<linux-mips@linux-mips.org>, "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	<ralf@linux-mips.org>
References: <20061010.224652.53335173.anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] optimize and cleanup get_saved_sp, set_saved_sp
Date:	Tue, 10 Oct 2006 15:55:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12865
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> This patch also fixes 64-bit SMTC version of get_saved_sp() which is
> broken but harmless since there is no such CPUs for now.

I appreciate and thank you for your prescience, though.  ;o)

            Regards,

            Kevin K.
