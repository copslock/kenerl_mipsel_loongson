Received:  by oss.sgi.com id <S553805AbQLLMFn>;
	Tue, 12 Dec 2000 04:05:43 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:24739 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553750AbQLLMFW>;
	Tue, 12 Dec 2000 04:05:22 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA10843;
	Tue, 12 Dec 2000 12:58:19 +0100 (MET)
Date:   Tue, 12 Dec 2000 12:58:18 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Jun Sun <jsun@mvista.com>
cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: Should /dev/kmem support above 0x80000000 area?
In-Reply-To: <3A35C2CE.2CF718D6@mvista.com>
Message-ID: <Pine.GSO.3.96.1001212121526.9082A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 11 Dec 2000, Jun Sun wrote:

> I see.  It is funny that you cannot read/write memory beyond high_memory
> through /dev/mem, but you can re-map it and then read/write through the
> remapped region.

 I see it consistent.  The system memory can be treated like a stream of
bytes.  That's much like any random-access file.  Other devices do not
necessarily exhibit this behaviour.  They may implement side effects,
values read may be different from what was written previously.  You may
even achieve different effects by performing transfers of different
widths. 

> How do you control the width of bus transfers?  If you have direct access to
> the device memory, the userland "drivers" should be able to deal with the bus
> access width correctly.

 If you declare a location int32_t, gcc will perform a 32-bit access on
assignment (lw/sw for MIPS).  If you declare a location int16_t, gcc will
perform a 16-bit access (lh/sh for MIPS).  Ditto for int8_t (and for
int64_t for 64-bit configurations).  Names of types do not matter, of
course, sizeof -- does.  I just used the ISO C portable names for
fixed-size types.  Please note you might need to use the "volatile" 
keyword or gcc might reorder or even optimize out certain accesses. 

> kseg0 and kseg1 are part of kernel virtual memory space.  If we implement
> /dev/kmem correctly, one should be able to directly read/write those area by
> specifying 0x80000000 or 0xa0000000 offsets through /dev/kmem.

 But this is highly unportable.  MIPS has trivially mapped virtual memory
areas but many (most?) architectures do not.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
