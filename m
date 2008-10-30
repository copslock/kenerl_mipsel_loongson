Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 11:14:07 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:44442 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22721716AbYJ3LN6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2008 11:13:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9UBDtvk010947;
	Thu, 30 Oct 2008 11:13:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9UBDs6F010945;
	Thu, 30 Oct 2008 11:13:54 GMT
Date:	Thu, 30 Oct 2008 11:13:54 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
Message-ID: <20081030111354.GF26256@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de> <4908B717.3010603@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4908B717.3010603@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 12:18:47PM -0700, David Daney wrote:

> That file contains the bit definitions for all on-chip registers.
>
> We are interested in transforming this information into a form suitable  
> for inclusion in the kernel.  Any specific suggestions as to improve the  
> patch will be considered.
>
> Several possibilities are:
>
> 1) Don't typedef all the unions in  cvmx-csr-typedefs.h.  An rename the  
> file so it doesn't contain the reprehensible word 'typedef'
>
> 2) Break cvmx-csr-addresses.h and cvmx-csr-typedefs.h into several  
> parts, one for each functional block in the processor.
>
> There are obviously other options as well...

The use of bitfields also fires back:

+       struct cvmx_ciu_intx_en1_w1c_cn58xx {
+#if __BYTE_ORDER == __BIG_ENDIAN
+               uint64_t reserved_16_63:48;
+               uint64_t wdog:16;
+#else
+               uint64_t wdog:16;
+               uint64_t reserved_16_63:48;
+#endif

You see, everything was defined twice.  And gcc even recent gccs tend to
do silly stuff with bitfields when combined with volatile:

struct foo {
	unsigned int	x:1;
	unsigned int	y:4;
};

void bar(volatile struct foo *p)
{
	p->x = 1;
	p->y++;
}

which gcc 4.3 for a MIPS32R2 target will compile into:

	lw	$3, 0($4)
	li	$2, 1
	ins	$3, $2, 31, 1
	sw	$3, 0($4)
	lw	$2, 0($4)
	lw	$3, 0($4)
	ext	$2, $2, 27, 4
	addiu	$2, $2, 1
	ins	$3, $2, 27, 4
	sw	$3, 0($4)
	j	$31
	nop

Imagine struct foo was describing a hardware register so the pointer to it
was marked volatile.  A human coder wouldn't have done multiple loads /
stores.  Worse, if you actually want to change multiple fields in a
register atomically then with bitfields you have _no_ possibility to enforce
that.

The Linux programming programming model relies on accessor functions like
readl, ioread32 etc.  Those take addresses as arguments - but bitfields
don't have addresses in C ...

So exec summary: bitfields bad for such low-level stuff.

  Ralf
