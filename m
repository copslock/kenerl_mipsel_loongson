Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2003 13:06:21 +0100 (BST)
Received: from avocet.mail.pas.earthlink.net ([IPv6:::ffff:207.217.120.50]:5330
	"EHLO avocet.mail.pas.earthlink.net") by linux-mips.org with ESMTP
	id <S8225205AbTHaMFs>; Sun, 31 Aug 2003 13:05:48 +0100
Received: from sdn-ap-010masprip0276.dialsprint.net ([63.186.161.22] helo=lahoo.priv)
	by avocet.mail.pas.earthlink.net with esmtp (Exim 3.33 #1)
	id 19tQwU-0005AM-00; Sun, 31 Aug 2003 05:04:27 -0700
Received: from prefect.priv ([10.1.1.102] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 19tQvI-0002fK-00; Sun, 31 Aug 2003 08:03:12 -0400
Message-ID: <009901c36fb8$08190970$6601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Adeel Malik" <AdeelM@avaznet.com>
Cc: <linux-mips@linux-mips.org>
References: <10C6C1971DA00C4BB87AC0206E3CA382627229@1aurora.enabtech>
Subject: Re: RE: Information required
Date: Sun, 31 Aug 2003 08:04:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <brad@ltc.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@ltc.com
Precedence: bulk
X-list: linux-mips

----- Original Message ----- 
From: "Adeel Malik" <AdeelM@avaznet.com>
To: "Dan Aizenstros" <daizenstros@quicklogic.com>
Cc: <linux-mips@linux-mips.org>
Sent: Saturday, August 30, 2003 7:34 AM
Subject: RE: RE: Information required


>        I have been able to resolve all the unresolved function symbols, by
> properly configuring the MODVERSIONING in the module code. Only two
symbols
> are left:
>
> 1. unresolved symbol Atomic_add
> 2. unresolved symbol Atomic_sub
>
> These symbols are not even in /proc/ksyms and System.map file of the
> cross-compild linux-2.4 directory.

I don't think you'll find those in Linux.  Maybe your module relies on
another module.

Regards,
Brad
