Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 17:28:07 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:61940 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023184AbYHLQ2B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Aug 2008 17:28:01 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m7CGRsRb026962;
	Tue, 12 Aug 2008 18:27:54 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m7CGRgn3026952;
	Tue, 12 Aug 2008 17:27:46 +0100
Date:	Tue, 12 Aug 2008 17:27:42 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
cc:	linux-mips@linux-mips.org,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
Subject: Re: Debugging the MIPS processor using GDB
In-Reply-To: <200808121637.42148.brian.foster@innova-card.com>
Message-ID: <Pine.LNX.4.55.0808121720370.24222@cliff.in.clinika.pl>
References: <18944199.post@talk.nabble.com> <48A19ABE.5060104@alpha-bit.de>
 <200808121637.42148.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 12 Aug 2008, Brian Foster wrote:

>   I'm using the commercial FS² (First Silicon Systems, now owned
>  by MIPS) EJTAG probe.  The local ‘gdb’ on the workstation talks
>  to the local FS² software on the workstation, which talks to the
>  probe (in my case, over USB, but there is also an Ethernet model).
>  There is no ‘gdbserver’ in this setup per se, albeit I suppose
>  the protocol between ‘gdb’ and the FS² software (which is called
>  something like ‘jnetserver’?) might be similar/identical (I have
>  no idea!).

 Not really -- it uses a C API called MDI -- the spec is available from
MIPS Technologies.  I am happy to read somebody finds it useful. :)  
Debugging the Linux kernel with GDB and this piece of hardware is
certainly a lot of fun.

  Maciej
