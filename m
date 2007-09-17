Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 00:12:55 +0100 (BST)
Received: from mail-out.m-online.net ([212.18.0.10]:42914 "EHLO
	mail-out.m-online.net") by ftp.linux-mips.org with ESMTP
	id S20021909AbXIQXMq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Sep 2007 00:12:46 +0100
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 2AA002237F8;
	Tue, 18 Sep 2007 01:12:46 +0200 (CEST)
X-Auth-Info: AtTzLq6rZRzYMOnys33RtHLXBx0ohrulGSLdljQ7UCY=
X-Auth-Info: AtTzLq6rZRzYMOnys33RtHLXBx0ohrulGSLdljQ7UCY=
Received: from mail.denx.de (p5496483C.dip.t-dialin.net [84.150.72.60])
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 1658C90337;
	Tue, 18 Sep 2007 01:12:46 +0200 (CEST)
Received: from gemini.denx.de (gemini.denx.de [10.0.0.2])
	by mail.denx.de (Postfix) with ESMTP id 981746D00B5;
	Tue, 18 Sep 2007 01:12:45 +0200 (CEST)
Received: from gemini.denx.de (localhost.localdomain [127.0.0.1])
	by gemini.denx.de (Postfix) with ESMTP id 8A733247FE;
	Tue, 18 Sep 2007 01:12:45 +0200 (CEST)
To:	Paul Marciano <pm940@yahoo.com>
cc:	linux-mips@linux-mips.org
From:	Wolfgang Denk <wd@denx.de>
Subject: Re: busybox / ELDK fails to run.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 17 Sep 2007 15:23:25 PDT."
             <446032.91533.qm@web54007.mail.re2.yahoo.com>
Date:	Tue, 18 Sep 2007 01:12:45 +0200
Message-Id: <20070917231245.8A733247FE@gemini.denx.de>
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <446032.91533.qm@web54007.mail.re2.yahoo.com> you wrote:
> First, apologies if this is an inappropriate list for
> this question, but there doesn't seem to be a list for
> ELDK, and there doesn't seem to be much MIPS traffic

You can always ask us directly...

> Is anyone else here using the ELDK and busybox?  If

We are, obviously.

> so, I'd be interested in knowing if you've seen the
> same problem, or if you think there's something wrong
> with my setup.  

It works fine in our tests...

Did you try using the NFS root file system for these  tests,  or  the
included ramdisk images? Which of these is giving you the problems?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There is such a fine line between genius and stupidity."
- David St. Hubbins, "Spinal Tap"
