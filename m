Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2004 16:13:08 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:25817
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225934AbUFBPND>; Wed, 2 Jun 2004 16:13:03 +0100
Received: from wh85.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id C67022F56A; Wed,  2 Jun 2004 17:12:57 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: ilya@theIlya.com
Subject: Re: help needed : cannot install linux on SGI O2 R5000
Date: Wed, 2 Jun 2004 17:13:02 +0200
User-Agent: KMail/1.5.3
Cc: linux-mips@linux-mips.org
References: <200405281210.05259.maksik@gmx.co.uk> <200406020859.36095.maksik@gmx.co.uk> <20040602145831.GK6398@gateway.total-knowledge.com>
In-Reply-To: <20040602145831.GK6398@gateway.total-knowledge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406021713.02541.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi,

Ok, what I've decided to do is to try to pull the stage3 system and build the 
actual kernel with frame-buffer support while running glaurung's kernel 
(which was the only binary kernel that worked for me). Actually, glaurung's 
kernel is definitely not perfectly stable, I'm experiencing random hangs and 
oops time to time, but I thought it would be good enough for bootstrapping. 
Is it really?

Btw, the neither from Ilya's kernels did not work for me -- the recent one 
boots but hangs on busybox startup. The older ones either do not boot at all 
or crash during bootup. 

So, is there a way out? I did not try yet the binary kernels from Kumba, 
because they are built for a serial console and I don't have a cable so far. 
Honestly, looking for such a cable would be the last thing on my list...

Any advises would be greatly appreciated.

--Max

On Wednesday 02 June 2004 04:58 pm, ilya@theIlya.com wrote:
> Right - this is not correct list to complaint to about Gentoo installation
> problems. As for the problem - chances of getting bootstrap all the
> way to the end on glaurung's kernel are very slim due to broken RTC
> support (which is what bit you). Make gets rather confused, when
> time goes backwards, or in zig-zags and circles ;-)
>
