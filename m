Received:  by oss.sgi.com id <S42459AbQIGAGn>;
	Wed, 6 Sep 2000 17:06:43 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:31280 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42230AbQIGAGe>; Wed, 6 Sep 2000 17:06:34 -0700
Received: from google.engr.sgi.com (google.engr.sgi.com [163.154.10.145]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA01307; Wed, 6 Sep 2000 17:13:07 -0700 (PDT)
	mail_from (kanoj@google.engr.sgi.com)
Received: (from kanoj@localhost)
	by google.engr.sgi.com (SGI-8.9.3/8.9.3) id RAA27824;
	Wed, 6 Sep 2000 17:05:18 -0700 (PDT)
From:   Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200009070005.RAA27824@google.engr.sgi.com>
Subject: Re: CVS Update@oss.sgi.com: linux
To:     ralf@oss.sgi.com (Ralf Baechle)
Date:   Wed, 6 Sep 2000 17:05:18 -0700 (PDT)
Cc:     linux-mips@oss.sgi.com
In-Reply-To: <20000907020237.B20605@bacchus.dhis.org> from "Ralf Baechle" at Sep 07, 2000 02:02:37 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> 
> On Wed, Sep 06, 2000 at 04:51:19PM -0700, Kanoj Sarcar wrote:
> 
> > The act of flushing the L2 cache, should include flushing the L1
> > cache, whether done by software or processor provided primitives, 
> > to guarantee the inclusion principle.
> 
> The inclusion principle is not true for all processor types.

Which processor is supported out of the mips64 tree that does
not obey the inclusion principle?

Kanoj
