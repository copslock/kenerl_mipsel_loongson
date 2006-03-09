Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Mar 2006 09:53:57 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:19592 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133426AbWCIJxs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Mar 2006 09:53:48 +0000
Received: from localhost.localdomain (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id D5B56FC4F; Thu,  9 Mar 2006 02:02:21 -0800 (PST)
Date:	Thu, 09 Mar 2006 04:05:15 -0600
To:	"Martin Michlmayr" <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: 1480: ethernet stops working, box okay
References: <20060309060606.GA16963@deprecation.cyrius.com>
From:	"Tom Rix" <trix@specifix.com>
Organization: specifix
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.s544y1x4thfl8t@localhost.localdomain>
In-Reply-To: <20060309060606.GA16963@deprecation.cyrius.com>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Return-Path: <trix@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trix@specifix.com
Precedence: bulk
X-list: linux-mips

I have seen something similar on my 1250.  I have a patch that should  
help.  I am cleaning it up and will post it shortly.

Tom


On Thu, 09 Mar 2006 00:06:06 -0600, Martin Michlmayr <tbm@cyrius.com>  
wrote:

> I just thought that my 1480 box had crashed, but as it turns out I
> could still issue commands on the serial console - however, the
> network wasn't working anymore.  There was nothing in dmesg and
> bringing the interface down and up again didn't help.  I've seen this
> twice now while compiling lots of stuff in parallel.
>
> Has anyone else seen this?



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
