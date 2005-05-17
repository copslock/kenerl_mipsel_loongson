Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 20:53:00 +0100 (BST)
Received: from web32503.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.213]:57942
	"HELO web32503.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8226315AbVEQTwo>; Tue, 17 May 2005 20:52:44 +0100
Received: (qmail 40788 invoked by uid 60001); 17 May 2005 19:52:32 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LBysdeL0ujsPg5Wsf/Roll0muB5wnfFILoCtMcjgfEEayNMu73JTzdKqSx+nJBAYRxGk87xkNaeUSTl68o1aVHdGBeoQGVeYeuqGaPl+II7lnM4vD/sbz+FGO8Qv4Yd37PpxqTckgEdXSvMay6Lyn0k3dBIKRnEZ3Zgj9NpSkSA=  ;
Message-ID: <20050517195232.40786.qmail@web32503.mail.mud.yahoo.com>
Received: from [85.250.113.238] by web32503.mail.mud.yahoo.com via HTTP; Tue, 17 May 2005 12:52:32 PDT
Date:	Tue, 17 May 2005 12:52:32 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: Re: 64 bit kernel for BCM1250
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

  Thanks for your reply.
  I tried using the resulted vmlinux.32 and got the
same result. 

  After looking into it, I found out that t0 is loaded
with 0x0 while it should load _edata value which
should be 0xffffffff80310000 (according to the
System.map).   in the 32 bit version (which I build
using a different toolchain), edata is loaded to t0
register as it should.

It looks to me like it is a toolchain problem. 

1. where can I download a pre built, prooven working
64 bit toolchain?

2. Is there anything else that can cause this problem?


Thanks,
 Michael


--- "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> On Tue, 17 May 2005, Michael Belamina wrote:
> 
> >   I have built a 64 bit kernel for BCM1250.
> >   When the kernel is loaded and control is passed
> to
> > kernel_entry there is an exception:
> > 
> > CFE> boot -elf LinuxServer:vmlinux.64
> [...]
> 
>  I'm assuming vmlinux.64 is a 64-bit ELF file.  If
> so, then, well, 
> depending on the version of CFE you have, this may
> or may not work.  The 
> workaround is to always use 32-bit ELF files.  You
> should get one after 
> your Linux build -- if not (which may depend on how
> you do builds), then 
> try `make vmlinux.32' and use the result.
> 
>   Maciej
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
