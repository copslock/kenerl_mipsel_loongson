Received:  by oss.sgi.com id <S42327AbQHWXPI>;
	Wed, 23 Aug 2000 16:15:08 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15709 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42324AbQHWXOp>; Wed, 23 Aug 2000 16:14:45 -0700
Received: from google.engr.sgi.com (google.engr.sgi.com [163.154.10.145]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA01181; Wed, 23 Aug 2000 16:20:32 -0700 (PDT)
	mail_from (kanoj@google.engr.sgi.com)
Received: (from kanoj@localhost)
	by google.engr.sgi.com (SGI-8.9.3/8.9.3) id QAA92824;
	Wed, 23 Aug 2000 16:12:58 -0700 (PDT)
From:   Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200008232312.QAA92824@google.engr.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Wed, 23 Aug 2000 16:12:58 -0700 (PDT)
Cc:     kanoj@oss.sgi.com (Kanoj Sarcar), linux-mips@oss.sgi.com
In-Reply-To: <20000823125657.A1008@bacchus.dhis.org> from "Ralf Baechle" at Aug 23, 2000 12:56:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 
> On Wed, Aug 23, 2000 at 10:23:50AM -0700, Kanoj Sarcar wrote:
> 
> > Log message:
> > 	Make prom_printf() functional on IP27s. And prom_printf() is not an
> > 	init function, it needs to be around during regular system usage.
> 
> On my system after the first TLB flush all PROM functions are no longer
> usable since the function pointer point to mapped space.  Similar for
> other ARC machines.
> 
>   Ralf
> 

I can see how the IP27 can have access to prom functions after init.
Not sure how arc behaves on other machines, but I guess if you really
wanted to use arc prom functions after init, you could take steps to
ensure that ...

Kanoj
