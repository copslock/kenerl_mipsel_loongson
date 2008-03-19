Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2008 08:59:46 +0000 (GMT)
Received: from ms5.Sony.CO.JP ([211.125.136.201]:10152 "EHLO ms5.sony.co.jp")
	by ftp.linux-mips.org with ESMTP id S20022164AbYCSI7j (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2008 08:59:39 +0000
Received: from mta6.sony.co.jp (mta6.Sony.CO.JP [137.153.71.9])
 by ms5.sony.co.jp (R8/Sony) with ESMTP id m2J8wg6A018220;
 Wed, 19 Mar 2008 17:58:42 +0900 (JST)
Received: from mta6.sony.co.jp (localhost [127.0.0.1])
 by mta6.sony.co.jp (R8/Sony) with ESMTP id m2J8wgU3007933;
 Wed, 19 Mar 2008 17:58:42 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
 by mta6.sony.co.jp (R8/Sony) with ESMTP id m2J8wfrt007917;
 Wed, 19 Mar 2008 17:58:42 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.4.141.32]) by smail1.sm.sony.co.jp (8.11.6p2/8.11.6) with ESMTP id m2J8wgP19517; Wed, 19 Mar 2008 17:58:42 +0900 (JST)
Received: from localhost (tidal.sm.sony.co.jp [43.4.145.112])
	by imail.sm.sony.co.jp (8.12.11/3.7W) with ESMTP id m2J8wgVA018495;
	Wed, 19 Mar 2008 17:58:42 +0900 (JST)
Date:	Wed, 19 Mar 2008 17:53:28 +0900 (JST)
Message-Id: <20080319.175328.28780867.kaminaga@sm.sony.co.jp>
To:	dan@debian.org
Cc:	linux-mips@linux-mips.org, kaminaga@sm.sony.co.jp
Subject: Re: MIPS prelink question
From:	Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
In-Reply-To: <20080319.142140.21932743.kaminaga@sm.sony.co.jp>
References: <20080318.154701.74743177.kaminaga@sm.sony.co.jp>
	<20080318123330.GA18036@caradoc.them.org>
	<20080319.142140.21932743.kaminaga@sm.sony.co.jp>
X-Mailer: Mew version 4.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kaminaga@sm.sony.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaminaga@sm.sony.co.jp
Precedence: bulk
X-list: linux-mips


> > It should be in their prelink source package.  Or here:
> > 
> >   http://sourceware.org/ml/prelink/2007-q4/msg00001.html
> 
> Thank you very mauch for pointer. I'll try this out and tell you
> the result!

With the patch from above URL, I'm now getting the working prelink!
Thanks a million!


(Hiroki Kaminaga)
t
--
