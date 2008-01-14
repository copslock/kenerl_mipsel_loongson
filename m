Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 20:25:51 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.234]:17544 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20033141AbYANUZm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 20:25:42 +0000
Received: by wr-out-0506.google.com with SMTP id 67so698129wri.6
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 12:25:41 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=IB0LSjV53TIzZmR6t0KCmRosOyPsSLVh/sLGBckmc+Y=;
        b=lVcDIQLEEDOYyI68Avty+btgLVwj20e81h2KbezdFS/y3kibKns0r0vFSdvRhz+2YZv/mXMZ4JqMaXCNoZypgeuJ5V9UNL+WjGcMWq7dWirpmapASOa/l4xNxcozNucwVqEncyTEebLiq7o/qvfY7k6cndq4wRm4g0PTpiQ0n00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t0ALF6RJxuhnvsYHk2xi3sMov8YnD/oACZPAZ8Nstx/QuEoHyLBll53EWoisXnv5jAv/lCNlJiLKTC0DQ+jbMb3G3kKzFuimMtN16xE1y78eljFe0scsmJjFbHJ1XHmFHjxlXGq4WpQ/eytYKhQaOI8RH8szKW0jQJm9QhN2QUE=
Received: by 10.142.103.6 with SMTP id a6mr2774726wfc.21.1200342340181;
        Mon, 14 Jan 2008 12:25:40 -0800 (PST)
Received: by 10.142.140.11 with HTTP; Mon, 14 Jan 2008 12:25:40 -0800 (PST)
Message-ID: <1a18fe6d0801141225u2395ae6dj39d268014019b4a1@mail.gmail.com>
Date:	Mon, 14 Jan 2008 21:25:40 +0100
From:	"The Engineer" <lper.home@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Cache aliasing issues using 4K pages.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <lper.home@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lper.home@gmail.com
Precedence: bulk
X-list: linux-mips

We are working with a 2.6.12 kernel on a dual-core mips architecture.
In this dual-core system, one core is running the linux kernel and the
other is used for some real-time handling (not directly controlled by
Linux)
We had different stability issues, which could be pinpointed to be
related with cache aliasing problems.
Cache aliasing happens when the same physical memory can be cached
twice as it is accessed by two different virtual addresses.
Indeed, for the index to select the correct cache line the virtual
address is used. If some bits of the virtual page address are used in
the cache index, aliasing can occur.


As there is no hardware solution in the mips to recover from this
(which would provide some cache coherency, even for one core), the
only intrinsic safe solution is to enlarge the page size, so that
cache indexing is only done by the offset address in the page (thus
the physical part of the address).
Another solution is to flush the cache if a page is being remapped to
an aliased address (but in our case linux does not has control on the
second core, which can cause issues with shared data between both
cores).
Currently the second solution is used in the kernel, but we found
different issues with it (for instance: we had to merge more recent
mips kernels, to get a reliable copy-on-write behaviour after
forks...).

Therefore some questions:
- Are there still some known issues with cache aliasing in the MIPS kernel?
- Are there known issues when using 16KB pages (8KB pages seems not be
possible due to tlb issues).

Thanks in advance,
Luc
