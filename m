Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2006 09:43:14 +0000 (GMT)
Received: from [81.2.110.250] ([81.2.110.250]:22931 "EHLO lxorguk.ukuu.org.uk")
	by ftp.linux-mips.org with ESMTP id S8133363AbWAGJm5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Jan 2006 09:42:57 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k079meLo010775;
	Sat, 7 Jan 2006 09:48:41 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k079md6L010774;
	Sat, 7 Jan 2006 09:48:39 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Almost 80% of UDP packets dropped
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <f69849430601062302if424acey70e98f86e0de36e6@mail.gmail.com>
References: <f69849430601062302if424acey70e98f86e0de36e6@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 07 Jan 2006 09:48:35 +0000
Message-Id: <1136627315.3748.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2006-01-06 at 23:02 -0800, kernel coder wrote:
> I noticed that user application started recieveing packets after
> Kernel had recieved all the UDP packets.

If your network chip/ram/processor combination is not fast enough to run
user space applications and handle a full speed network packet stream
then you either need to send more slowly, make the kernel network driver
more efficient or add some kind of interrupt/polling code to reduce
system load to avoid this. The NAPI layer in the networking code is
designed to make this possible.

Probably worth discussing further on netdev@oss.sgi.com

Alan
