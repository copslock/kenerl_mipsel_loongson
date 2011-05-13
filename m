Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 17:30:50 +0200 (CEST)
Received: from mx0.aculab.com ([213.249.233.131]:54879 "HELO mx0.aculab.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S1491851Ab1EMPao convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 17:30:44 +0200
Received: (qmail 27983 invoked from network); 13 May 2011 15:30:30 -0000
Received: from localhost (127.0.0.1)
  by mx0.aculab.com with SMTP; 13 May 2011 15:30:30 -0000
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27321-03 for <linux-mips@linux-mips.org>;
 Fri, 13 May 2011 16:30:30 +0100 (BST)
Received: (qmail 27800 invoked by uid 599); 13 May 2011 15:30:28 -0000
Received: from unknown (HELO saturn3.Aculab.com) (10.202.163.5)
    by mx0.aculab.com (qpsmtpd/0.28) with ESMTP; Fri, 13 May 2011 16:30:28 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system callfiltering
Date:   Fri, 13 May 2011 16:29:27 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
In-Reply-To: <1305299880.2076.31.camel@localhost.localdomain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system callfiltering
Thread-Index: AcwRgP+uf4p6VPi/TNeaJPKux9Io6gAAKobQ
From:   "David Laight" <David.Laight@ACULAB.COM>
To:     "Eric Paris" <eparis@redhat.com>, "Ingo Molnar" <mingo@elte.hu>
Cc:     <linux-mips@linux-mips.org>, <linux-sh@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "David Howells" <dhowells@redhat.com>,
        "Paul Mackerras" <paulus@samba.org>,
        "H. PeterAnvin" <hpa@zytor.com>, <sparclinux@vger.kernel.org>,
        "Jiri Slaby" <jslaby@suse.cz>, <linux-s390@vger.kernel.org>,
        "Russell King" <linux@arm.linux.org.uk>, <x86@kernel.org>,
        "James Morris" <jmorris@namei.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@redhat.com>, <kees.cook@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Tejun Heo" <tj@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        "Michal Marek" <mmarek@suse.cz>, "Michal Simek" <monstr@monstr.eu>,
        "Will Drewry" <wad@chromium.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Mundt" <lethal@linux-sh.org>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
        <linux390@de.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>,
        <agl@chromium.org>, "David S. Miller" <davem@davemloft.net>
X-Virus-Scanned: by iCritical at mx0.aculab.com
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
Precedence: bulk
X-list: linux-mips

> ... If you can be completely stateless its easier, but there's
> a reason that stacking security modules is hard.  Serge has tried in
the
> past and both dhowells and casey schaufler are working on it right
now.
> Stacking is never as easy as it sounds   :)

For a bad example of trying to allow alternate security models
look at NetBSD's kauth code :-)

NetBSD also had issues where some 'system call trace' code
was being used to (try to) apply security - unfortunately
it worked by looking at the user-space buffers on system
call entry - and a multithreaded program can easily arrange
to update them after the initial check!
For trace/event type activities this wouldn't really matter,
for security policy it does.
(I've not looked directly at these event points in linux)

	David
