Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2003 11:46:05 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:61450
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225201AbTCBLqF> convert rfc822-to-8bit; Sun, 2 Mar 2003 11:46:05 +0000
Received: from yaelgilad [81.218.92.190] by myrealbox.com
	with NetMail ModWeb Module; Sun, 02 Mar 2003 11:46:07 +0000
Subject: RE: Static variables and "gp"
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Sun, 02 Mar 2003 11:46:07 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1046605567.d43b0840yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Who said user-code ?
Strictly kernel

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Sunday, March 02, 2003 1:18 PM
To: Gilad Benjamini
Cc: linux-mips@linux-mips.org
Subject: Re: Static variables and "gp"


On Sun, Mar 02, 2003 at 09:07:28AM +0000, Gilad Benjamini wrote:

> How can I force a specific static variable to be used by the "gp" register
> rather than by a two-step load ?
> Compiling a mips-linux using gcc.

That feature doesn't work in gcc for userspace code ...

  Ralf
