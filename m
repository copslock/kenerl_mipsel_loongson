Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1N2oaa29663
	for linux-mips-outgoing; Fri, 22 Feb 2002 18:50:36 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N2oX929660
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 18:50:33 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g1N1liB11493;
	Fri, 22 Feb 2002 17:47:44 -0800
Message-ID: <3C76F53D.2C893BC7@mvista.com>
Date: Fri, 22 Feb 2002 17:49:49 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: FPU emul and segmentation fault bug
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I remember a while back we had a problem with FPU emulation code which causes
a segmentation fault.  (Perhaps another symptom is bus error, but I am not
100% sure).

Apparently this problem is fixed in the recent kernel.  However, it shows up
again in SMP mode.

Does anybody remember details of the problem and the fix?  I am afraid maybe
something we did there is not SMP safe.

Thanks.

Jun
