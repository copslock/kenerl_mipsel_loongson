Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2007 20:16:16 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:5850 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20032583AbXKOUQH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2007 20:16:07 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: "exportfs -a" -> stale NFS filehandle
Date:	Thu, 15 Nov 2007 12:15:39 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DC8F6@exchange.ZeugmaSystems.local>
In-Reply-To: <20071115194548.GA30481@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: "exportfs -a" -> stale NFS filehandle
Thread-Index: AcgnwCCtCdy5qIVVTMaI/zfLoW8HSAAAB8Cw
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17516
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Nov 15, 2007 at 11:26:06AM -0800, Kaz Kylheku wrote:
> 
>> After backing out the nfsutils patch, the diskless node does boot.
>> 
>> However, the original "exportfs -a" problem comes back!
>> 
>> So this problem is not resolved simply by using the correct compat
>> routine; it's deeper. 
>> 
>> Sigh.
> 
> Thanks for testing anyway!

I'm continuing to dig into the problem.

The export logic doesn't even go through nfsctl() anyway, which is why I
originally hadn't even suspected that syscall.

The nfsexport() function in nfsutils first tries opening
"/proc/net/rpc/nfsd.fh./channel". If that works, it uses that, via a
text-based protocol. Only if that interface doesn't exist does it fall
back on the nfsctl(NFSCTL_EXPORT, ...) interface.
