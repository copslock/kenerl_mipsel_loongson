Received:  by oss.sgi.com id <S42457AbQIFXyX>;
	Wed, 6 Sep 2000 16:54:23 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:57135 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42230AbQIFXyV>; Wed, 6 Sep 2000 16:54:21 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA06842; Wed, 6 Sep 2000 17:00:54 -0700 (PDT)
	mail_from (kanoj@google.engr.sgi.com)
Received: from google.engr.sgi.com ([163.154.10.145]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id QAA88525; Wed, 6 Sep 2000 16:53:50 -0700 (PDT)
Received: (from kanoj@localhost)
	by google.engr.sgi.com (SGI-8.9.3/8.9.3) id QAA14035;
	Wed, 6 Sep 2000 16:51:19 -0700 (PDT)
From:   Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200009062351.QAA14035@google.engr.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Wed, 6 Sep 2000 16:51:19 -0700 (PDT)
Cc:     linux-mips@oss.sgi.com
In-Reply-To: <20000907014521.A20605@bacchus.dhis.org> from "Ralf Baechle" at Sep 07, 2000 01:45:21 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 
> On Wed, Sep 06, 2000 at 04:36:29PM -0700, Kanoj Sarcar wrote:
> 
> > 	Compile fix: flush only L2 cache.
> 
> That's wrong, sysmips(FLUSH_CACHE) is supposed to flush all caches.
> 
>   Ralf
> 

The act of flushing the L2 cache, should include flushing the L1
cache, whether done by software or processor provided primitives, 
to guarantee the inclusion principle.

Notwithstanding, feel free to add in a call to flush_cache_l1()
(and I don't know whether you want to flush the i and d caches
both, or just one), making sure there are no compile breakages.
(the breakage that I fixed was due to the fact that there is no
__flush_cache_all for mips64).

Kanoj
