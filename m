Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2011 12:44:32 +0100 (CET)
Received: from mx0.aculab.com ([213.249.233.131]:41891 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1903609Ab1LELo2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2011 12:44:28 +0100
Received: (qmail 12983 invoked from network); 5 Dec 2011 11:44:20 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 5 Dec 2011 11:44:20 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 12870-04 for <linux-mips@linux-mips.org>;
 Mon,  5 Dec 2011 11:44:20 +0000 (GMT)
Received: (qmail 12709 invoked by uid 599); 5 Dec 2011 11:44:16 -0000
Received: from unknown (HELO saturn3.Aculab.com) (10.202.163.5)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Mon, 05 Dec 2011 11:44:16 +0000
Received: from saturn3.Aculab.com ([10.202.163.5]) by saturn3.Aculab.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 5 Dec 2011 11:44:10 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Re: [PATCHv5] atomic: add *_dec_not_zero
Date:   Mon, 5 Dec 2011 11:44:10 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEFE@saturn3.aculab.com>
In-Reply-To: <20111204221850.GC14542@n2100.arm.linux.org.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [PATCHv5] atomic: add *_dec_not_zero
Thread-Index: Acyy0x4HjkbAO+BaTWSu0XHw1HNtUwAb8ndQ
From:   "David Laight" <David.Laight@ACULAB.COM>
To:     "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
        "Sven Eckelmann" <sven@narfation.org>
Cc:     <linux-m32r-ja@ml.linux-m32r.org>, <linux-mips@linux-mips.org>,
        <linux-ia64@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Randy Dunlap" <rdunlap@xenotime.net>,
        "Paul Mackerras" <paulus@samba.org>,
        "Helge Deller" <deller@gmx.de>, <sparclinux@vger.kernel.org>,
        <linux-hexagon@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        "Richard Weinberger" <richard@nod.at>,
        "Hirokazu Takata" <takata@linux-m32r.org>, <x86@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Matt Turner" <mattst88@gmail.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Arnd Bergma nn" <arnd@arndb.de>, "Jeff Dike" <jdike@addtoit.com>,
        "Chris Metcalf" <cmetcalf@tilera.com>,
        <linux-m32r@ml.linux-m32r.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "Richard Henderson" <rth@twiddle.net>,
        "Tony Luck" <tony.luck@intel.com>, <linux-parisc@vger.kernel.org>,
        <b.a.t.m.a.n@lists.open-mesh.org>, <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Kyle McMartin" <kyle@mcmartin.ca>, <linux-alpha@vger.kernel.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        <linux390@de.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
X-OriginalArrivalTime: 05 Dec 2011 11:44:10.0781 (UTC) FILETIME=[3441CCD0:01CCB343]
X-Virus-Scanned: by iCritical at mx0.aculab.com
X-archive-position: 32030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3141

Looking at this:

> #ifndef atomic_inc_unless_negative
> static inline int atomic_inc_unless_negative(atomic_t *p)
> {
>         int v, v1;
>         for (v = 0; v >= 0; v = v1) {
>                 v1 = atomic_cmpxchg(p, v, v + 1);
>                 if (likely(v1 == v))
>                         return 1;
>         }
>         return 0;
> }
> #endif

why is it optimised for '*p' being zero??
I'd have though the initial assignment to 'v' should
be made by reading '*p' without any memory barriers (etc).

	David
