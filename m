Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Dec 2004 20:33:13 +0000 (GMT)
Received: from web201.biz.mail.re2.yahoo.com ([IPv6:::ffff:68.142.224.163]:58813
	"HELO web201.biz.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225227AbUL1UdI>; Tue, 28 Dec 2004 20:33:08 +0000
Message-ID: <20041228203251.7298.qmail@web201.biz.mail.re2.yahoo.com>
Received: from [63.194.140.131] by web201.biz.mail.re2.yahoo.com via HTTP; Tue, 28 Dec 2004 12:32:51 PST
Date: Tue, 28 Dec 2004 12:32:51 -0800 (PST)
From: Peter Popov <ppopov@embeddedalley.com>
Subject: Re: defconfig for dbAu1550 (Cabarnet) and problems booting kernel
To: Prashant Viswanathan <vprashant@echelon.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB59016543D9@miles.echelon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> I am trying to get Linux up and running on the
> DbAu1550 (Cabarnet) using the
> latest code from linux-mips.org.  I was wondering if
> somebody would have a default config file 
> for building the kernel.

The DbAu1550 should just work with the default config
that's in arch/mips/defconfigs. There have been a
number of patches that went into the tree since I was
built a kernel for that board, but assuming the
patches did not break anything, the kernel should
boot.

> Also, when I try to boot the kernel from Yamon, I
> don't see anything
> happening. Any ideas on what could be wrong?
> YAMON> go . console=ttyS0,115200
> << nothing happens after this >>

If you are using the arch/mips/de
--- Prashant Viswanathan <vprashant@echelon.com>
wrote:

> 
> Hi All,
> 
fconfigs/ 1550 config file, it will expect to mount an
nfs root fs. The proper way to boot it is:
go . ip=any root=/dev/nfs

However, the fact that you don't see anything on the
console is really suspicious. I'll pull the latest
bits tonight and see if something broke.

Pete
