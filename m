Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2003 23:32:59 +0000 (GMT)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:55046 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8224939AbTAWXc7>;
	Thu, 23 Jan 2003 23:32:59 +0000
Received: (qmail 24049 invoked from network); 23 Jan 2003 23:32:48 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 23 Jan 2003 23:32:48 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id C99813000B8; Fri, 24 Jan 2003 10:32:38 +1100 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id 12B4D85; Fri, 24 Jan 2003 10:32:37 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: A question on Linux SMP and cache coherency 
In-reply-to: Your message of "Thu, 23 Jan 2003 15:21:01 -0800."
             <71690137A786F7428FF9670D47CB95ED10DF71@SJE4EXM01> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Jan 2003 10:32:31 +1100
Message-ID: <7650.1043364751@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jan 2003 15:21:01 -0800, 
Adam Kiepul <Adam_Kiepul@pmc-sierra.com> wrote:
>	I would really appreciate if anyone could tell me whether Hardware-maintained cache coherency between processors is required for Linux SMP operation.

http://www.uwsg.iu.edu/hypermail/linux/kernel/0007.3/1220.html
