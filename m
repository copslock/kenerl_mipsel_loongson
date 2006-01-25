Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 17:07:30 +0000 (GMT)
Received: from fmr22.intel.com ([143.183.121.14]:64408 "EHLO
	scsfmr002.sc.intel.com") by ftp.linux-mips.org with ESMTP
	id S8133382AbWAYRHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 25 Jan 2006 17:07:04 +0000
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k0PH8nas025719;
	Wed, 25 Jan 2006 17:08:49 GMT
Received: from scsmsxvs040.sc.intel.com (scsmsxvs040.sc.intel.com [10.3.90.8])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k0PAJpWh026569;
	Wed, 25 Jan 2006 10:20:00 GMT
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6])
 by scsmsxvs040.sc.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006012509084130695
 ; Wed, 25 Jan 2006 09:08:42 -0800
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 25 Jan 2006 09:08:41 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 5/6] fix warning on test_ti_thread_flag()
Date:	Wed, 25 Jan 2006 09:08:15 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB509780224@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 5/6] fix warning on test_ti_thread_flag()
Thread-Index: AcYhq35Htc/JS4DwRnqnPZSDMQONvAAJYsOQ
From:	"Chen, Kenneth W" <kenneth.w.chen@intel.com>
To:	"Geert Uytterhoeven" <geert@linux-m68k.org>,
	"Akinobu Mita" <mita@miraclelinux.com>
Cc:	"Linux Kernel Development" <linux-kernel@vger.kernel.org>,
	"Richard Henderson" <rth@twiddle.net>,
	"Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
	"Russell King" <rmk@arm.linux.org.uk>,
	"Ian Molton" <spyro@f2s.com>, <dev-etrax@axis.com>,
	"David Howells" <dhowells@redhat.com>,
	"Yoshinori Sato" <ysato@users.sourceforge.jp>,
	"Linus Torvalds" <torvalds@osdl.org>, <linux-ia64@vger.kernel.org>,
	"Hirokazu Takata" <takata@linux-m32r.org>,
	<linux-m68k@vger.kernel.org>, "Greg Ungerer" <gerg@uclinux.org>,
	"Linux/MIPS Development" <linux-mips@linux-mips.org>,
	<parisc-linux@parisc-linux.org>,
	"Linux/PPC Development" <linuxppc-dev@ozlabs.org>,
	<linux390@de.ibm.com>, <linuxsh-dev@lists.sourceforge.net>,
	<linuxsh-shmedia-dev@lists.sourceforge.net>,
	<sparclinux@vger.kernel.org>, <ultralinux@vger.kernel.org>,
	"Miles Bader" <uclinux-v850@lsi.nec.co.jp>,
	"Andi Kleen" <ak@suse.de>, "Chris Zankel" <chris@zankel.net>
X-OriginalArrivalTime: 25 Jan 2006 17:08:41.0899 (UTC) FILETIME=[FDF19FB0:01C621D1]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Return-Path: <kenneth.w.chen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kenneth.w.chen@intel.com
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote on Wednesday, January 25, 2006 4:29 AM
> On Wed, 25 Jan 2006, Akinobu Mita wrote:
> > If the arechitecture is
> > - BITS_PER_LONG == 64
> > - struct thread_info.flag 32 is bits
> > - second argument of test_bit() was void *
> > 
> > Then compiler print error message on test_ti_thread_flags()
> > in include/linux/thread_info.h
> > 
> > Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> > ---
> >  thread_info.h |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: 2.6-git/include/linux/thread_info.h
> > ===================================================================
> > --- 2.6-git.orig/include/linux/thread_info.h	2006-01-25
19:07:12.000000000 +0900
> > +++ 2.6-git/include/linux/thread_info.h	2006-01-25
19:14:26.000000000 +0900
> > @@ -49,7 +49,7 @@
> >  
> >  static inline int test_ti_thread_flag(struct thread_info *ti, int
flag)
> >  {
> > -	return test_bit(flag,&ti->flags);
> > +	return test_bit(flag, (void *)&ti->flags);
> >  }
> 
> This is not safe. The bitops are defined to work on unsigned long
only, so
> flags should be changed to unsigned long instead, or you should use a
> temporary.
> 
> Affected platforms:
>   - alpha: flags is unsigned int
>   - ia64, sh, x86_64: flags is __u32
> 
> The only affected 64-platforms are little endian, so it will silently
work
> after your change, though...

I thought test_bit can operate on array beyond unsigned long.
It's perfectly legitimate to do: test_bit(999, bit_array) as
long as bit_array is indeed big enough to hold 999 bits.  It
is the responsibility of the caller to make sure that the
underlying array is big enough for the bit that is being tested.

I don't think you need to change the flags size.

- Ken
