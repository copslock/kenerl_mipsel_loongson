Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2006 22:35:53 +0100 (BST)
Received: from web31502.mail.mud.yahoo.com ([68.142.198.131]:52849 "HELO
	web31502.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20039657AbWJHVft (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Oct 2006 22:35:49 +0100
Received: (qmail 84377 invoked by uid 60001); 8 Oct 2006 21:35:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F6+WsDKojuSCM1VKIXBoDNg57wVGXgl5jR7reDRqJHVZhySdX3Mt865+ExGY/h9GtVM6KNJoBbsIDwA9ovMkjhMsgi7dmSygAU6QgqcNNzT0ZzRJ3vepU/PZwUjCQy9DoDBugdOINyly0AB+RLLGMQm0Bf6AXdNLaK+7hJZvlDI=  ;
Message-ID: <20061008213538.84372.qmail@web31502.mail.mud.yahoo.com>
Received: from [65.102.0.10] by web31502.mail.mud.yahoo.com via HTTP; Sun, 08 Oct 2006 14:35:37 PDT
Date:	Sun, 8 Oct 2006 14:35:37 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: CFE problem: starting secondary CPU.
To:	girish <girishvg@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc:	Jonathan Day <imipak@yahoo.com>,
	Kaz Kylheku <kaz@zeugmasystems.com>, linux-mips@linux-mips.org
In-Reply-To: <9D189830-9D85-4360-BEEE-72A3D5510D77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

--- girish <girishvg@gmail.com> wrote:
> would it be reasonable to choose couple of
> bootmonitors and support  
> them under MIPS/Linux umbrella. even bootable linux
> would be a good  
> choice.

I can't see why not. For that matter, I can't imagine
it would be too hard to write the necessary flash
support to get LinuxBIOS working.

It does puzzle me, though, that the kernel seems to
get a lot of data from CFE rather than using the
probes it already has. Whether it's a built-in BIOS
(as on the PC), ACPI, CFE, or some other external
table of what is present, the one thing experience has
taught is that these tables cannot (and should not) be
trusted. Kernel discovery, although unsafe for some
hardware*, generally produces more accurate and
reliable results.

*Of course, that's a killer. There is an unfortunately
large amount of hardware in the world that cannot be
used safely in conjunction with probes. Other hardware
will respond incorrectly, screw up the machine, play
all your MP3's backwards, ...


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
