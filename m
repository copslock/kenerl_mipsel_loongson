Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Oct 2007 14:24:24 +0100 (BST)
Received: from smtp104.plus.mail.re1.yahoo.com ([69.147.102.67]:54104 "HELO
	smtp104.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20028989AbXJQNYO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Oct 2007 14:24:14 +0100
Received: (qmail 218 invoked from network); 17 Oct 2007 13:23:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=BxlCIPSxmWYroWFJvf6aVplGYTXYWUxHfyjQLmKgkFlF61/zSGlqPJmv8UdOgw9aoTjAGRqAoi2AN+dLVQ56xgXxQCrN5zqZuzSDD6CXKuVCwUtDvnWJ/Qg1/5F9DfebOWI2apz0VXdkw8gjUl8T5hP15hGVcOHsN5vQ4oFUo0g=  ;
Received: from unknown (HELO ?192.168.254.6?) (jscottkasten@72.185.69.24 with login)
  by smtp104.plus.mail.re1.yahoo.com with SMTP; 17 Oct 2007 13:23:08 -0000
X-YMail-OSG: 52SaslcVM1nvF060jCkmltVZdYRytQHZ14vy3qMc4X52GwgOJ_2ivBuwHiFQnw8sqrFFqVDqWQ--
Date:	Wed, 17 Oct 2007 09:14:08 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@pixie.tetracon-eng.net
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
cc:	linux-mips@linux-mips.org
Subject: Re: Problems writing to USB devices
In-Reply-To: <20071017100803.7794bb87.giuseppe@eppesuigoccas.homedns.org>
Message-ID: <Pine.LNX.4.64.0710170853090.22402@pixie.tetracon-eng.net>
References: <20071017100803.7794bb87.giuseppe@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


On Wed, 17 Oct 2007, Giuseppe Sacco wrote:

> Hi all, I am still testing new kernels on the ip32 platform (and 
> learning kernel structure :-)). Currently I found problems in writing to 
> USB block devices. I may read from a pendrive without problem, but when 
> I try to write the process stop. This is the last part of a transcript 
> of strace output for "pvcreate /dev/sdc" command:
>

A few questions...

* Which USB card, or more precisely, which chipset is on the USB card you 
picked?

I've had great luck with NEC and ALI chips thus far.

* Which driver was loaded for the USB controller, OHCI, UHCI, EHCI?

If you have a USB 2.0 controller, the system will probably try to load 
both EHCI and UHCI.  I did run into problems there, for one, the system 
crashed when I pulled the thumb drive out.  It sometimes behaved strangely 
when it was in.  I eventually figured out that removing UHCI and running 
EHCI only was the solution for me.  The UHCI module seemed to be probing 
the hardware incorrectly.  It was reporting 6 ports on the bridge when 
there were only 2.  The EHCI module was reporting the correct number as I 
recall.  Once it was EHCI only, I've never had a problem since.

That was originally under 2.6.17 from gentoo.  I've since been using the 
debian patched 2.6.18.  I'm afraid I haven't yet reached sufficient 
motivation to move into the 20's like the rest of you.  I tend to like my 
box working...  :)  Just joking.....it's on the todo list.

-S-
