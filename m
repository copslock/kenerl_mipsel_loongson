Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Oct 2003 03:15:38 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:36363 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225465AbTJDCPf>;
	Sat, 4 Oct 2003 03:15:35 +0100
Received: (qmail 20450 invoked from network); 4 Oct 2003 02:15:26 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 4 Oct 2003 02:15:26 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id B1B50C02CB; Sat,  4 Oct 2003 12:15:24 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP id AE63B140086
	for <linux-mips@linux-mips.org>; Sat,  4 Oct 2003 12:15:24 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-mips@linux-mips.org
Subject: Re: mailing list spam 
In-reply-to: Your message of "Fri, 03 Oct 2003 16:09:07 -0400."
             <200310031609.07289.mips082-nospam@vtnet.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Oct 2003 12:15:23 +1000
Message-ID: <10035.1065233723@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Fri, 3 Oct 2003 16:09:07 -0400, 
Trevor Woerner <mips082-nospam@vtnet.ca> wrote:
>I appreciate microsoft *.exe updates by email just as much as the next
>guy, however...
>
>I create email aliases for the different mailing lists I join. I
> noticed that I've been receiving a fair amount of spam to the email
> address I setup for this list. I figured it was because I posted
> something in the past, so I unsubscribed my old email address, created
> a new one, and re-subscribed.
>
>Without having made any postings since the change, I have just received
>spam to the new address I've setup for this list, which means someone
>has access to the membership list. Any chance this could be looked into
>and turned off?

Not necessarily.  This particular virus hunts around for anything that
looks like an email address and spams it.  My logs show a couple of
these virus loads from the list itself, linux-mips.org does not filter
out this virus.

Oct  4 02:21:19 reject: header Content-Type: application/x-msdownload;
name="Upgrade53.exe" from mail.linux-mips.org[62.254.210.162];
from=<linux-mips-bounce@linux-mips.org>
