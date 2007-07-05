Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2007 17:24:04 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:35465 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20023048AbXGEQYA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jul 2007 17:24:00 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l65GNwtI012547;
	Thu, 5 Jul 2007 09:23:58 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id l65GNj2c013994;
	Thu, 5 Jul 2007 09:23:50 -0700 (PDT)
Message-ID: <01dc01c7bf20$e03f6c20$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>
References: <20070705144641.GA20210@linux-mips.org>
Subject: Re: dead(?) MIPS config stuff
Date:	Thu, 5 Jul 2007 18:23:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1896
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> ========== SMTC_IDLE_HOOK_DEBUG ==========
> arch/mips/kernel/smtc.c:146:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/kernel/smtc.c:181:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
> arch/mips/kernel/smtc.c:399:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/kernel/smtc.c:402:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
> arch/mips/kernel/smtc.c:614:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/kernel/smtc.c:828:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/kernel/smtc.c:830:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
> arch/mips/kernel/smtc.c:1055:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/kernel/smtc.c:1148:#endif /* CONFIG_SMTC_IDLE_HOOK_DEBUG */
> arch/mips/kernel/process.c:54:#ifdef CONFIG_SMTC_IDLE_HOOK_DEBUG
> arch/mips/Kconfig.debug:40:config CONFIG_SMTC_IDLE_HOOK_DEBUG

It's cruft, but it's cruft that does have some utility when porting SMTC to a new
platform, as it helps identify interrupt management bugs.  It needs to be eliminated
or replaced with a revision of the interface between architecture and platform 
support for SMTC, toward which I've made some small progress recently, 
but I'd prefer not to see it disappear before reinforcements arrive.

            Regards,

            Kevin K.
