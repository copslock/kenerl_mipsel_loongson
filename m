Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 21:43:54 +0100 (BST)
Received: from web40914.mail.yahoo.com ([IPv6:::ffff:66.218.78.211]:23680 "HELO
	web40914.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224920AbVDGUni>; Thu, 7 Apr 2005 21:43:38 +0100
Received: (qmail 51805 invoked by uid 60001); 7 Apr 2005 20:43:29 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=q6JxWqdT3s6sZ1pKsID379kO74F+SYB+HjcYz34S/IZq7z/pDIDdKVovSXTcLg+SMsXRtIJ+KHPlpu4zQyY6UBNItGxsuUNNd4V3sSPLCkD5cF8VcIN5u+4NiSLX2e96a8OQQ78+2ny3Bh0JVkD4YHqd3NZAWwSiN7FB0MX2XuQ=  ;
Message-ID: <20050407204329.51803.qmail@web40914.mail.yahoo.com>
Received: from [65.205.244.66] by web40914.mail.yahoo.com via HTTP; Thu, 07 Apr 2005 13:43:29 PDT
Date:	Thu, 7 Apr 2005 13:43:29 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: gdb backtrace with core files
To:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips


> > OK, tried again with version (GNU gdb
> > 6.3.50.20050407-cvs.)  Same result.
> > 
> > I'm running gdb on x86 host, debugging a binary
> for a
> > MIPS target.  I configured gdb as
> > ./configure --target mipsel-linux-gnu
> --enable-shared
> > --enable-threads 
> > 
> > Perhaps gdb isn't getting the right kernel headers
> > when built?  I added the configure options
> > --includedir and --oldincludedir to point to my
> > linux-mips kernel tree, but that didn't help
> either.  
> 
> It does not use the kernel headers to work out the
> layout.  Are you
> using a current kernel?  I tested core dump support
> only a couple weeks
> ago.

I'm using a 2.4.25 vendor-patched kernel from
Broadcom.  I can poke around and compare the
core-dumping code to the latest mips-linux tree to see
if anything is different.

Brian
 


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
