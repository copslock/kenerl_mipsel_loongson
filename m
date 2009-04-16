Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 04:48:48 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:5262 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S28574035AbZDPDrD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 04:47:03 +0100
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D348B4001F;
	Thu, 16 Apr 2009 05:46:47 +0200 (CEST)
Received: from [192.168.10.105] (c-7bb5e555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.181.123])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id AC30940008;
	Thu, 16 Apr 2009 05:46:47 +0200 (CEST)
Cc:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	Brian Foster <brian.foster@innova-card.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Message-Id: <5A24253D-8F6F-46CE-A121-AD5CADC6D7C8@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20090402133855.GC15021@linux-mips.org>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--446588525"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Date:	Thu, 16 Apr 2009 05:46:56 +0200
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304154418.GA13464@linux-mips.org> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com> <20090402133855.GC15021@linux-mips.org>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.930.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--446588525
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

That article is a classic one, just the name itself...

However the article itself is based on M68K and Intel x86 IIRC.

Indeed, IRIX < 6.2 was all o32, correct me if I'm wrong.

To get back on track, what about a kernel that can be compiled by  
MIPSPro C and not relaying on glibc and GNUisms (al right,  
'asmlinkage' cracked that idea once and for all a few years ago), but  
my point is to change the libc as little as possible.

I hope I brought a grasp of light on the issue (and yes $ra is fun to  
play with), and as Ralph pointed out: the special stack frame makes  
the return address traceability disappear after one step as __GNUC__  
knows it.

//Markus

On 2 Apr 2009, at 15:38, Ralf Baechle wrote:

> On Wed, Mar 04, 2009 at 05:25:35PM -0500, David VomLehn (dvomlehn)  
> wrote:
>
>>>> it's more a matter of "when" rather than "if".
>>>> there is still an intention here to use XI (we
>>>> have SmartMIPS), which requires not using the
>>>> signal (or FP) trampoline on the stack.
>>>>
>>>> moving the signal trampoline to a vdso (which
>>>> is(? was?) called, maybe misleadingly, 'vsyscall',
>>>> on other architectures) is the obvious solution to
>>>> that part of the puzzle.  and yes, it is possible
>>>> to maintain the ABI; the signal trampoline is still
>>>> also put on the stack, and modulo XI, would work if
>>>> used - the trampoline-on-stack is simply not used
>>>> if there is a vdso with the signal trampoline.
>>>
>>> We generally want to get rid of stack trampolines.
>>> Trampolines require
>>> cacheflushing which especially on SMP systems can be a rather
>>> expensive
>>> operation.
>>
>> If I understand this correctly, using a vdso would allow a stack  
>> without
>> execute permission on those processors that differentiate between  
>> read
>> and execute permission. This defeats attaches that use buffer  
>> overrun to
>> write code to be executed onto the stack, a nice thing for more  
>> secure
>> systems.
>
> The good news is that many of these stack buffer overruns don't work  
> on
> MIPS anyway due to the somewhat unusual stack frame.  Don't rely on  
> that
> too much for security though - like 10 years ago Phrack published an
> article under the title "Smashing the stack for fun and profit"  
> explaining
> how to write exploits for IRIX 5 which als was using o32.
>
>  Ralf
>


--Apple-Mail-1--446588525
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAknmqjAACgkQ6I0XmJx2NryjFACfQDS007JV14/dmkqZ929kczuy
yJEAn1adROiyfqgaIh+Yk/X0eawjbVDH
=p55y
-----END PGP SIGNATURE-----

--Apple-Mail-1--446588525--
