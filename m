Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 12:57:51 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.225]:1882 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28590817AbYB1M5t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 12:57:49 +0000
Received: by wx-out-0506.google.com with SMTP id h30so4113204wxd.21
        for <linux-mips@linux-mips.org>; Thu, 28 Feb 2008 04:57:47 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=JmToEGOoC3bF0Mv5L34KcTGtxMpTDpNqY+S6eXv862g=;
        b=J9iad1oVlyG6ZuQq4eZGKaFwMUu4mHOQBEWT6IHgp/C+V5x9YlIbM9v5Jt9Abm4IKCeJPTQzAAlx2AzNSSjO0OC3rA8LFfgwYTijFAOXcZRylq2ihXr42LOuX7jyOrSZy0OHs8XAsfsZXcXnlVMUbkfTYE19zpSqTL+0bpCURTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=KiNO2nJ99BFWZxB38zA1HgJgFl8myPLYnlbYSI6O4ZIUSRUAh+vAdmEIfgud0HQxaDhb5O597FZj/3Y2IOPlN/+blfUGkGuZDHM1CrKaYJDBioN1jczpQ4cgRi0s+NeJHAnQ6PFphDBnyGNHxsWzy9FHEgyFbeuXbQ5ZcWjSY9g=
Received: by 10.70.42.18 with SMTP id p18mr5642406wxp.59.1204203467425;
        Thu, 28 Feb 2008 04:57:47 -0800 (PST)
Received: by 10.70.44.20 with HTTP; Thu, 28 Feb 2008 04:57:47 -0800 (PST)
Message-ID: <64660ef00802280457i3eef020chd70f85c011c5a770@mail.gmail.com>
Date:	Thu, 28 Feb 2008 12:57:47 +0000
From:	"Daniel Laird" <daniel.j.laird@nxp.com>
To:	linux-mips@linux-mips.org
Subject: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: edfeb21de15cb502
Return-Path: <daniel.j.laird@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.j.laird@nxp.com
Precedence: bulk
X-list: linux-mips

Hi all.

I have been happily using Linux 2.6.22.1 for ages on PNX8550 (STB810).
 I have recently decided to step up and move onto Linux 2.6.24 series.
However I am not getting very far. :-(
It seems that all the clock stuff has changed again (since 2.6.22.1)
and this is causing issues.
The board crashes as soon as local_irq_enable is called in main.c

I was wondering if anyone out there might also be running on an
STB810/JBS PNX8550 based system and have any ideas as to why I am
crashing.
I know that PNX8550 does not enable the R4K Clock source stuff as the
chip is a bit 'special' and requires the two timers to be used instead
of one.

As far as I can see I think my interrupts are not being setup.

Any help, ideas etc are appreciated.

Daniel Laird
