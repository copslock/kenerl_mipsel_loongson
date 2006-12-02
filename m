Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 05:46:43 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.25]:14302 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20038453AbWLBFqi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 2 Dec 2006 05:46:38 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB25kVjQ014700
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 1 Dec 2006 21:46:31 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id kB25kRlr009054;
	Fri, 1 Dec 2006 21:46:27 -0800
Date:	Fri, 1 Dec 2006 21:46:26 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Jeff Garzik <jgarzik@pobox.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.18] declance: Support the I/O ASIC LANCE w/o
 TURBOchannel
Message-Id: <20061201214626.1c50dd38.akpm@osdl.org>
In-Reply-To: <45710CFE.5090007@pobox.com>
References: <Pine.LNX.4.64N.0611301306460.1757@blysk.ds.pg.gda.pl>
	<45710CFE.5090007@pobox.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Sat, 02 Dec 2006 00:19:58 -0500
Jeff Garzik <jgarzik@pobox.com> wrote:

> Maciej W. Rozycki wrote:
> >  The onboard LANCE of I/O ASIC systems is not a TURBOchannel device, at 
> > least from the software point of view.  Therefore it does not rely on any 
> > kernel TURBOchannel bus services and can be supported even if support for 
> > TURBOchannel has not been enabled in the configuration.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
> can you (or Andrew) please resend your patches against 2.6.19?
> 

I have then all (I think) queued up.  Will send once I've done a round
of build-testing.
