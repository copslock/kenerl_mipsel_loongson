Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Feb 2003 12:56:26 +0000 (GMT)
Received: from gw3.laser5.co.jp ([IPv6:::ffff:211.5.140.198]:60149 "EHLO
	l5ac40.l5.laser5.co.jp") by linux-mips.org with ESMTP
	id <S8225252AbTBNM4Z>; Fri, 14 Feb 2003 12:56:25 +0000
Received: from l5ac40.l5.laser5.co.jp (localhost.localdomain [127.0.0.1])
	by l5ac40.l5.laser5.co.jp (Postfix) with SMTP id 3566674E59
	for <linux-mips@linux-mips.org>; Fri, 14 Feb 2003 21:56:17 +0900 (JST)
Date: Fri, 14 Feb 2003 21:56:16 +0900
From: Kunihiko IMAI <kimai@laser5.co.jp>
To: linux-mips@linux-mips.org
Subject: Re: NEC VR4181A
Message-Id: <20030214215616.074b7ffe.kimai@laser5.co.jp>
In-Reply-To: <02c101c2d362$f9e2eed0$3501a8c0@wssseeger>
References: <20030212224837.D16015@mvista.com>
	<02c101c2d362$f9e2eed0$3501a8c0@wssseeger>
Organization: LASER5 Ltd.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <kimai@laser5.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kimai@laser5.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

I'm also suffered from VR4181A :-)  I'm now trying to USBFU (device side)
driver.  The USBFU hardware has many many erratas.

On Thu, 13 Feb 2003 05:22:36 -0800
sseeger@stellartec.com (Steven Seeger) wrote:

> Yeah I didn't notice the A on there. We are looking into the possibility of
> using the A in our board. Part of the problem is that the A only comes in
> BGA and we don't like dealing with that.

VR4181 and VR4181A are completely different.  A developer of NEC said,
"We mistook at naming.  The name seems to be upgrade version, in fact,
they are quitely different."

On the other hand, VR4122 and VR4131 are similar at hardware level.
If you take care of designing board, they can be replaced with others :-)

Thanks.
_._. __._  _ . ... _  .___ ._. _____ _... ._ _._ _.._. .____  _ . ... _

                                                          Kunihiko IMAI
