Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2014 15:12:38 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:65037 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816676AbaDCNMdunrkp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 3 Apr 2014 15:12:33 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s33DC32M012737
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 3 Apr 2014 09:12:03 -0400
Received: from x2.localnet (vpn-62-75.rdu2.redhat.com [10.10.62.75])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s33DC2te013717
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 3 Apr 2014 09:12:02 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Manuel Lauss <manuel.lauss@gmail.com>, linux-audit@redhat.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [RESEND PATCH 1/2] MIPS syscall auditing patches
Date:   Thu, 03 Apr 2014 09:12:01 -0400
Message-ID: <22527060.aLC9JPau8e@x2>
Organization: Red Hat
User-Agent: KMail/4.12.3 (Linux/3.13.7-200.fc20.x86_64; KDE/4.12.3; x86_64; ; )
In-Reply-To: <20140403093257.GO17197@linux-mips.org>
References: <1396433596-612624-1-git-send-email-manuel.lauss@gmail.com> <20140402155519.GA749@madcap2.tricolour.ca> <20140403093257.GO17197@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Return-Path: <sgrubb@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sgrubb@redhat.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thursday, April 03, 2014 11:32:57 AM Ralf Baechle wrote:
> > >  - To make matters worse, most MIPS processors can be configured to be
> > >    big or little endian.  Traditionally the the 64-bit little endian
> > >    configuration is named mips64el, so I've changed references to
> > >MIPSEL64
> > >    in audit.h to MIPS64EL.
> > > 
> > >  - The code treats the little endian MIPS architecture as separate from
> > >    big endian.  Combined with the 3 ABIs that's 6 combinations.  I tried
> > >    to sort of follow the example set by ARM which explicitly lists the
> > >    (rare) big endian architecture variant - but it doesn't seem to very
> > >    useful so I wonder if this could be squashed to just the three ABIs
> > >    without consideration of endianess?
> >
> > In ARM's case, endian-ness doesn't affect the ABI, from what I
> > understand.
> 
> There's probably the odd bitfield or similar where it might matter?  I
> did dig a bit in the history of the auditing code and found no code that
> uses __AUDIT_ARCH_LE other than setting that flag.
> 
> David - you introduced __AUDIT_ARCH_LE in kernel commit 2fd6f58ba6e
> "[AUDIT] Don't allow ptrace to fool auditing, log arch of audited syscalls."
> on April 29 2005.  Do you still recall the purpose of this flag?

I am certain its to signify the syscall is Little Endian.
 

> > >  - Talking about flags; I've defined the the N32 architecture flags were
> > >defined 
> > >     #define AUDIT_ARCH_MIPS64_N32  (EM_MIPS|__AUDIT_ARCH_ALT)
> > >     #define AUDIT_ARCH_MIPS64EL_N32
> > >(EM_MIPS|__AUDIT_ARCH_ALT|__AUDIT_ARCH_LE 
> > >     N32 is a 32-bit ABI but one that only runs on 64-bit processors as
> > >it
> > >     uses 64-bit registers for 64-bit integers.  So I'm uncertain if the
> > >     __AUDIT_ARCH_64BIT flags should be set or not.
> >
> > I would guess it should, but I am no expert.
> 
> Steve?

The core issue is to tell the kernel exactly what syscall you want inspected 
by the audit system. You should be able to specify a particular ABI and 
syscall and get that and only that. Then the event should record the 
information so that user space can figure out which syscall table to lookup the 
syscall number from so that it can turn it into text. Using the LE and other 
flags helps to know what we are dealing with if you have events aggregated in a 
server from multiple machines of different CPUs.

Assuming the AUDIT_ARCH_* follows expected conventions, the main test for 
correctness is whether or not you get a round trip from rules to interpreted 
events, its exactly what was expected.

-Steve
