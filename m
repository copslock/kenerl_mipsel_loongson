Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g28AxKT22791
	for linux-mips-outgoing; Fri, 8 Mar 2002 02:59:20 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g28Ax8922779;
	Fri, 8 Mar 2002 02:59:09 -0800
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [62.254.210.251])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g289wp211314;
	Fri, 8 Mar 2002 09:58:51 GMT
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id JAA27320;
	Fri, 8 Mar 2002 09:58:47 GMT
Date: Fri, 8 Mar 2002 09:58:47 GMT
Message-Id: <200203080958.JAA27320@mudchute.algor.co.uk>
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Marc Karasek <marc_karasek@ivivity.com>,
   Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: Questions?
In-Reply-To: <20020307140754.A1817@dea.linux-mips.net>
References: <1015435541.3714.33.camel@MCK_Linux>
	<20020307140754.A1817@dea.linux-mips.net>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Ralf Baechle (ralf@oss.sgi.com) writes:

> The MIPS ABI only covers big endian systems - every "real" MIPS UNIX
> system is big endian.

Except Decstations.  And Sony NeWS (remember that one).  And anything
running on those NEC Vr41xx systems which were designed for WinCE and
don't run big-endian at all.  There never was a consensus...

Mapping the MIPS ABI to little-endian presents no problems, as far as
I know: obviously since it's a binary compatibility standard it has to
make a choice...

> There is hardly any reason to choose a particular byteorder as
> usually endianess swapping takes so little CPU time that it isn't
> even meassurable but so I'm told there are exceptions.

I think it's often done for software-portability reasons; sometimes
because some hardware works both ways but has some irritating flaw in
its less-favoured organisation.

System software (kernels, libraries) tends to work both ways, because
it's written by people who thought about it.  Huge applications which
have only ever run on x86 and friends often don't work.

Finding the problems faster is a counsel of perfection: in practice, a
lot of us just want something that works, tomorrow.

Swapping probably is an unmeasurable load: even if it takes 8-10
instructions per word on a 500MHz CPU that's 200Mbytes/s.  But it is
ugly, particularly when it's required to restore correct byte sequence
because of a naive hardware interface (one, for example, which
connects the MIPS CPU data lines to the same-numbered PCI ones...)

So there are arguments on both sides, and players in both camps.  I
believe it's too late to corral all MIPS/Linux activity into one
endianness or the other.

Embrace bi-endianness!

-- 
Dominic Sweetman, 
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / direct: +44 1223 706205
http://www.algor.co.uk
