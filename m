Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2003 20:10:13 +0100 (BST)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:62163
	"HELO 127.0.0.1") by linux-mips.org with SMTP id <S8225408AbTIOTKL>;
	Mon, 15 Sep 2003 20:10:11 +0100
From: "Craig Mautner" <craig.mautner@alumni.ucsd.edu>
To: <linux-mips@linux-mips.org>
Subject: RE: schedule() BUG
Date: Sat, 13 Sep 2003 09:30:29 -0700
Message-ID: <JKEMLDJFFLGLICKLLEFJGEFECOAA.craig.mautner@alumni.ucsd.edu>
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
Return-Path: <craig.mautner@alumni.ucsd.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: craig.mautner@alumni.ucsd.edu
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
