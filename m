Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4V9gsnC024716
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 31 May 2002 02:42:54 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4V9gsKM024715
	for linux-mips-outgoing; Fri, 31 May 2002 02:42:54 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from t111.niisi.ras.ru (t111.niisi.ras.ru [193.232.173.111])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4V9genC024712;
	Fri, 31 May 2002 02:42:41 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id NAA13476;
	Fri, 31 May 2002 13:44:22 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id NAA17165; Fri, 31 May 2002 13:36:31 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id NAA12452; Fri, 31 May 2002 13:39:29 +0400 (MSK)
Message-ID: <3CF745B7.16CD0387@niisi.msk.ru>
Date: Fri, 31 May 2002 13:43:19 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.79 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com,
   Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: 3 questions about linux-2.4.18 and R3000
References: <3CEEBBA9.5070809@niisi.msk.ru> <3CEEAC5F.6010802@mvista.com> <3CF2A17D.6050207@niisi.msk.ru> <3CF3BB4B.504@mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun Sun wrote:
> >>
> >> We have been using gcc 2.9.5 and binutils 2.10.x for R3000 CPUs for
> >> quite a  while with no problems.  It seems newer gcc and binutiles are
> >> fine too.
> >>
> > I understand, but is there any __official__ recommended versions of these
> > utils? http://oss.sgi.com/mips/mips-howto.html is out-of-date :(
> >
> 
> Who are the "officiers" to decide on __official__ versions? :-)  If you are
> really uncomfortable with non-official stuff, you might want to consider
> paying some vendor and I am sure you will be given an "official" version.

"Official" means "if I report a bug w/o a patch in this list, I don't
get a message which requests to change the tools". 

I think, Ralf is the "officier" who decides what the right toolchain is.
Now, last toolchain Ralf announced was 

- binutils

Date:            Fri, 1 Dec 2000 03:06:19 +0100
From:            Ralf Baechle <ralf@oss.sgi.com>
To:            linux-mips@oss.sgi.com, linux-mips@fnet.fr

Binutils were buggy handling a cases involving empty object files.  I've
uploaded fixed binutils 2.8.1 cross-linker packages to oss.sgi.com; 
I'll
upload fixed binutils 2.9.5 binaries (mips64 only) later.  The
worarounds
for this bug have been removed from the CVS archive that is updating is
required for building a current 2.4 kernel.

  Ralf


- compiler

Subject:            New crosscompilers
Date:            Wed, 18 Apr 2001 18:42:07 -0300
From:            Ralf Baechle <ralf@oss.sgi.com>
To:            linux-mips@oss.sgi.com, linux-mips@fnet.fr

I've uploaded new egcs 1.1.2 based crosscompiler to oss.sgi.com into
/pub/linux/mips/crossdev/.  The only change for version 1.1.2-4 affects
mips64-linux and mips64el-linux targets where asking for alignments
larger than 8 bytes was ignored with a warning message.  This did
possibly result in some performance penalty for mips64 kernels.

  Ralf


The faq does mention this toolchain still.

Ralf, are you going to announce new toolchain given the lastest kernel
can't be compiled with old one? Or shall we change back the sources?

Regards,
Gleb.
