Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARDVM416648
	for linux-mips-outgoing; Tue, 27 Nov 2001 05:31:22 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARDUqo16631
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 05:30:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA01293;
	Tue, 27 Nov 2001 13:07:10 +0100 (MET)
Date: Tue, 27 Nov 2001 13:07:09 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Florian Lohoff <flo@rfc822.org>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
In-Reply-To: <20011127115903.E27987@paradigm.rfc822.org>
Message-ID: <Pine.GSO.3.96.1011127125241.440B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 27 Nov 2001, Florian Lohoff wrote:

> Ok - this fixes the problem by not only ignoring "length 0" sections but
> also sections with address 0 

 Huh?  You should be dealing with segments and not sections (as you are
loading and not linking the image) and then only LOADable ones.  I believe
there is no segment mapped at zero for the current kernel.  If a segment
has a null load address then it still have to be loaded -- you may
consider placing part of it away for the time being or just relocating the
loader.

$ mipsel-linux-objdump -p vmlinux-mips-2.4.14-20011123

vmlinux-mips-2.4.14-20011123:     file format elf32-tradlittlemips

Program Header:
0x70000000 off    0x0028e2e0 vaddr 0x802ce2e0 paddr 0x802ce2e0 align 2**2
         filesz 0x00000018 memsz 0x00000018 flags r--
    LOAD off    0x00001000 vaddr 0x80040000 paddr 0x80040000 align 2**12
         filesz 0x002744a8 memsz 0x002744a8 flags r-x
    LOAD off    0x00276000 vaddr 0x802b6000 paddr 0x802b6000 align 2**12
         filesz 0x0004c000 memsz 0x0006a890 flags rwx
private flags = 10000001: [no abi set] [mips2] [not 32bitmode]

There are only two LOADable segments, at 0x80040000 and at 0x802b6000.
None is at zero. ;-)

 If in doubt, just see how I'm loading ELF images in mopd.  Or ask me a
question. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
