Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2005 13:22:59 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:32183 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8225346AbVIIMWo>; Fri, 9 Sep 2005 13:22:44 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id j89CsvQ3017226;
	Fri, 9 Sep 2005 13:54:58 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id j89Csr1a017225;
	Fri, 9 Sep 2005 13:54:53 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: scheduling with irqs disabled: init
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Vadivelan@soc-soft.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902CD345ED@soc-mail.soc-soft.com>
References: <4BF47D56A0DD2346A1B8D622C5C5902CD345ED@soc-mail.soc-soft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 09 Sep 2005 13:54:52 +0100
Message-Id: <1126270492.3182.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-09-09 at 10:25 +0530, Vadivelan@soc-soft.com wrote:
> hi,
> 	I'm porting MVL4.0 kernel on to a mips board. I've been getting
> a call trace as follows.

You should report vendor kernel bugs to the vendor really. I've not seen
an equivalent report for the base kernel and looking at the code the
base kernel appears to correctly drop the lock before calling the wait
for chars level.
