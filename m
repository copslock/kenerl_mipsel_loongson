Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2005 07:12:30 +0000 (GMT)
Received: from web30705.mail.mud.yahoo.com ([68.142.200.138]:44625 "HELO
	web30705.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133547AbVKEHML (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Nov 2005 07:12:11 +0000
Received: (qmail 60440 invoked by uid 60001); 5 Nov 2005 07:13:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pR4pF1rVZVSO1228gmAxk3TSAjggEaQioFdCwCvo2s+woEwneg7wyHbB6AbH4YgMC/Nl0svaumjmy71bgwv4nSul0rhImd/L4UliJdT5dawUkHFZ6qfcw+FajprKK9HMtgbybjW1e0eMYzhxEi2AKzhdJ1xwDhaW3yIZTW/ddVk=  ;
Message-ID: <20051105071303.60438.qmail@web30705.mail.mud.yahoo.com>
Received: from [203.190.168.9] by web30705.mail.mud.yahoo.com via HTTP; Sat, 05 Nov 2005 07:13:03 GMT
Date:	Sat, 5 Nov 2005 07:13:03 +0000 (GMT)
From:	Nguyen Thanh Binh <n_tbinh@yahoo.com>
Subject: Booting with NFS fails
To:	linux-mips@linux-mips.org
Cc:	mlachwani@mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <n_tbinh@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n_tbinh@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello all,

I have installed Red Hat Enterprise 3 on the host
(x86) and MontaVista Linux (previewkit) on the target
(memec virtex-4 Fx12 LC board). When booting the
target using NFS from the host, the following error
appeared:

   eth0: Link carrier lost.
   eth0: Could not read PHY control register; error
1003
   eth0: Terminating link monitoring.

It is very strange, because ethernet does not work as
the error shows but I can ping the target from the
host with the IP got with DHCP.

Your help or experience would be appreciated.

Thank you.

Nguyen Binh



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
