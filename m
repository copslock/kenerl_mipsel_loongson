Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2003 20:01:03 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:62442
	"EHLO ns.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225408AbTIOTBB>; Mon, 15 Sep 2003 20:01:01 +0100
Received: from PEPELEPEW ([172.30.1.10]) by ns.pioneer-pdt.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-68491U100L2S100V35)
          with SMTP id com for <linux-mips@linux-mips.org>;
          Mon, 15 Sep 2003 12:03:36 -0700
From: craig.mautner@pioneer-pdt.com (Craig Mautner)
To: <linux-mips@linux-mips.org>
Subject: RE: schedule() BUG
Date: Mon, 15 Sep 2003 11:59:50 -0700
Message-ID: <JKEMLDJFFLGLICKLLEFJKEFNCOAA.craig.mautner@pioneer-pdt.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
In-reply-to: <JKEMLDJFFLGLICKLLEFJMEEOCOAA.craig.mautner@alumni.ucsd.edu>
Return-Path: <craig.mautner@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craig.mautner@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

Regarding my previous posting, we had made the assumption that schedule()
could be called from an interrupt that occured within schedule(). However,
because schedule() is in the kernel, ret_from_irq will skip over the call to
schedule() and simply restore the context.

-Craig

-.     .-.     .-_     Craig Mautner
  \   /   \   / / `    Coastal Sr. Consulting, Inc.
   `-'     `-'  `---   (858)361-2683
                       (858)581-0542 (fax)
5580 La Jolla Blvd. #308 La Jolla, CA 92037
mailto:craig.mautner@alumni.ucsd.edu
http://home.san.rr.com/cmautner/csc/craig/
