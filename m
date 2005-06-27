Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 23:53:02 +0100 (BST)
Received: from web40904.mail.yahoo.com ([IPv6:::ffff:66.218.78.201]:17332 "HELO
	web40904.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225995AbVF0Wwn>; Mon, 27 Jun 2005 23:52:43 +0100
Received: (qmail 53429 invoked by uid 60001); 27 Jun 2005 22:52:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=gmJfD+G4A//zmNe7n6/N+i5qHKarUddVTi6hE6MRpVLcBEQ6ccm0Bg06K8j5pWnWF69CffEDA82pQdl6zeY5NWOftH+NICe8qNcKLcckJWdCYvgGVqQafB7UhuTUXGIfKqZCjXeLQ5xU1phI9B6mMAUxcmrk+sTBbu+eXr8IK8E=  ;
Message-ID: <20050627225203.53423.qmail@web40904.mail.yahoo.com>
Received: from [65.205.244.66] by web40904.mail.yahoo.com via HTTP; Mon, 27 Jun 2005 15:52:03 PDT
Date:	Mon, 27 Jun 2005 15:52:03 -0700 (PDT)
From:	Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: crosstool (glibc based toolchain for MIPS)
To:	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
In-Reply-To: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4356@miles.echelon.echcorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <bkuschak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkuschak@yahoo.com
Precedence: bulk
X-list: linux-mips

686 -> mipsel cross works with the following:

crosstool-0.27
binutils-2.14
gcc-3.3.2
glibc-2.3.2
glibc-linuxthreads-2.3.2
 
-Brian

> Has anybody been able to build a toolchain for MIPS
> using crosstool
> successfully? And if so, could you please reply to
> me with the configuration
> used (gcc, glibc, binutils, etc).



		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 
