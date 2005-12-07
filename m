Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 17:46:34 +0000 (GMT)
Received: from web86306.mail.ukl.yahoo.com ([217.12.12.65]:26015 "HELO
	web86306.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133530AbVLGRqQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Dec 2005 17:46:16 +0000
Received: (qmail 32142 invoked by uid 60001); 7 Dec 2005 17:45:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=talk21.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=f8w8oUgJ1MajttCnuZg+zwt+IDANK9gKrn6VMmPuS8CAINAfP6yRf7peqX4SZ0VSpMw4L90BCx9eg3C1ZIPcaPe4Mc/DHS8fTFs2VqDTnf5xdTRkX3PihJyZk9z3K8CaVEhLVMr/kNurE7KoltvUYgT3V/AYH144yAk+dxJLyxY=  ;
Message-ID: <20051207174559.32140.qmail@web86306.mail.ukl.yahoo.com>
Received: from [132.146.82.240] by web86306.mail.ukl.yahoo.com via HTTP; Wed, 07 Dec 2005 17:45:59 GMT
Date:	Wed, 7 Dec 2005 17:45:59 +0000 (GMT)
From:	Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: Re: pci_iomap issues?
To:	Mark Mason <mason@broadcom.com>
Cc:	Scott Ashcroft <scott.ashcroft@talk21.com>,
	linux-mips@linux-mips.org
In-Reply-To: <43961DC1.80405@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <scott.ashcroft@talk21.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: scott.ashcroft@talk21.com
Precedence: bulk
X-list: linux-mips


--- Mark Mason <mason@broadcom.com> wrote:
> 
> Any system based on BCM1480s could have multiple pci
> busses (one PCI-X
> directly, and additional busses through HT/PCI-X
> bridges).  For the
> BCM91480B board, we had to turn on PCI_DOMAINS to
> get this to work
> correctly.

I understand that there are machines with multiple PCI
busses out there but comparing the ppc64 code with the
proposed mips patches I don't see much difference.
Are the ppc64 people just breaking multiple PCI bus
machines, did something happen in the generic PCI code
which fixed the issue or is there just a difference I
can't see?

Cheers,
Scott
