Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 23:48:15 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:29831
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8224772AbVGVWr5>; Fri, 22 Jul 2005 23:47:57 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id j6MNEc4I015565;
	Sat, 23 Jul 2005 00:14:38 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id j6MNEbeT015564;
	Sat, 23 Jul 2005 00:14:37 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Battery status
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Clark Williams <williams@redhat.com>,
	Rodolfo Giometti <giometti@linux.it>, linux-mips@linux-mips.org
In-Reply-To: <20050722221608.GF3770@linux-mips.org>
References: <20050722142205.GE21044@enneenne.com>
	 <1122044036.10743.5.camel@riff> <20050722191732.GB3770@linux-mips.org>
	 <1122066616.10743.33.camel@riff> <20050722212357.GE3770@linux-mips.org>
	 <1122070078.10743.35.camel@riff>  <20050722221608.GF3770@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 23 Jul 2005 00:14:34 +0100
Message-Id: <1122074074.9478.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-07-22 at 18:16 -0400, Ralf Baechle wrote:
> Well, and on Monday Linus said about ACPI BIOS writers in front of 80
> kernel developers and an Intel guy on stage "BIOS writers are morons".
> Nobody did object and 30s later that was /topic on the #kernel irc
> channel ...

That would be because the BIOS writers don't get invited. From some of
the BIOS people I've talked to I'd say that

a) They are not morons they just work in ridiculous situations and
timescales
b) They don't neccessarily like ACPI either
c) Linus attitude is not helpful

What I will say from the non x86 end of things is that ACPI is vastly
inferior IMHO to things like OpenFirmware, but its Intel and Intel don't
seem to like standards they didn't invent.

Alan
