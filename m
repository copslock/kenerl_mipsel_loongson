Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2005 00:23:58 +0000 (GMT)
Received: from web86303.mail.ukl.yahoo.com ([217.12.12.62]:25955 "HELO
	web86303.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133730AbVLFAXi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Dec 2005 00:23:38 +0000
Received: (qmail 60359 invoked by uid 60001); 6 Dec 2005 00:23:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=talk21.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EgIW6LWrQGJWCrMHUvcTQDDrLD4DqHVr/b86DzBTYI+8lZB2rzaVg29DovTgcPaN8Et/G76brqm1LjGcVQvfqjTHaiIHQL49vC/lLjQM36e4xUyvc7uDXdiAkDliq7BmeJEQpIWWZo7GiLRL2oQmyDJF6ZUnjsNzDDCW/qL+G1Y=  ;
Message-ID: <20051206002312.60357.qmail@web86303.mail.ukl.yahoo.com>
Received: from [62.190.246.49] by web86303.mail.ukl.yahoo.com via HTTP; Tue, 06 Dec 2005 00:23:12 GMT
Date:	Tue, 6 Dec 2005 00:23:12 +0000 (GMT)
From:	Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: pci_iomap issues?
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <scott.ashcroft@talk21.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scott.ashcroft@talk21.com
Precedence: bulk
X-list: linux-mips

What will it take to get a pci_iomap implementation
into the kernel.
Looking back in the list archives I've seen comments
that the patches posted to the list don't support
multiple PCI busses.
I can't see any difference between the patches and the
support in other archs.
Are the other archs broken or am I missing something?

Cheers,
Scott
