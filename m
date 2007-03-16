Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2007 18:30:55 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.224]:10500 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022581AbXCPSav (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Mar 2007 18:30:51 +0000
Received: by wr-out-0506.google.com with SMTP id i31so623782wra
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2007 11:29:49 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=ST4SQswzXAVXgWb8gFJ1UAFzSI+KtwnHf4ZevU91zdK3ml1BprN2u0LpZrlqcGbl2S4CtfLzcmNe0eV8KlqlED3kp9eQTvzUMRboGqUsJm16eyo9oJ1UPg59BfsxBRSy7lTa0JaOLy1tZruRUWCnLI7Fj5vvJGnZKxOT6QpGga8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=ikF1W4PEnFqF3GZXT2JiuIR1Eq4ISaslJYokwrNzCCJCb5CQ47kdp0moyqKqTfBvxpjv/kgtRpngZk7WSh+RA//yn1j3wOverCkD/RJXZnKUoWKTeHcoUzcjtc2ZWDd7XB0JbrHZtB2KNTwa/ZVBMLYaFIJZXuIlAPIwV4scj54=
Received: by 10.115.54.1 with SMTP id g1mr831324wak.1174069788968;
        Fri, 16 Mar 2007 11:29:48 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Fri, 16 Mar 2007 11:29:48 -0700 (PDT)
Message-ID: <d459bb380703161129l769d3f48w744ba0bfdf04fc91@mail.gmail.com>
Date:	Fri, 16 Mar 2007 19:29:48 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Au1500 and TI PCI1510 cardbus
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_115067_5159854.1174069788931"
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_115067_5159854.1174069788931
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

my Au1500 based board has a PCI1510 cardbus controller connected to the PCI
bus. So far the kernel 2.6.17 supports it as a "yenta_socket". The cardbus
is correctly seen and configured, and if I insert a wifi card in the slot I
can configure it.

The problem is that when I transfer a file, the transfer interrupts and the
system does not respond anymore to the serial console or ethernet pings. The
only way to revive it is to remove the wifi card.

I've managed to follow the problem, it seems that at some point during the
transfer "something breaks in the PCI". The effect is that no read or write
involving the PCI work anymore, So when the wifi card rises an interrupt,
the driver tries to read a register on the card to know the cause of the
interrupt but instead it reads 0xFFFFFFFF. As a test I've inserted a
"pci_read_config_dword" in the interrupt handler. Normally it reads the
correct value, but when the problem happens it reads 0xFFFFFFFF instead.

I've noticed that config_access returns 0xFFFFFFFF in case of an error, but
actually the 0xFFFFFFFF is not caused by any of those error conditions. The
pci_read_config_dword returns 0 and the 0xFFFFFFFF value is a genuine value.

Any advice on this problem?
Thanks a lot!

------=_Part_115067_5159854.1174069788931
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>my Au1500 based board has a PCI1510 cardbus controller connected to the PCI bus. So far the kernel 2.6.17 supports it as a &quot;yenta_socket&quot;. The cardbus is correctly seen and configured, and if I insert a wifi card in the slot I can configure it.
<br><br>The problem is that when I transfer a file, the transfer interrupts and the system does not respond anymore to the serial console or ethernet pings. The only way to revive it is to remove the wifi card.<br><br>I&#39;ve managed to follow the problem, it seems that at some point during the transfer &quot;something breaks in the PCI&quot;. The effect is that no read or write involving the PCI work anymore, So when the wifi card rises an interrupt, the driver tries to read a register on the card to know the cause of the interrupt but instead it reads 0xFFFFFFFF. As a test I&#39;ve inserted a &quot;pci_read_config_dword&quot; in the interrupt handler. Normally it reads the correct value, but when the problem happens it reads 0xFFFFFFFF instead.
<br><br>I&#39;ve noticed that config_access returns 0xFFFFFFFF in case of an error, but actually the 0xFFFFFFFF is not caused by any of those error conditions. The pci_read_config_dword returns 0 and the 0xFFFFFFFF value is a genuine value.
<br><br>Any advice on this problem?<br>Thanks a lot!<br><br>

------=_Part_115067_5159854.1174069788931--
