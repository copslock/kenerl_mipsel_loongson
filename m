Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2005 09:08:17 +0000 (GMT)
Received: from web30904.mail.mud.yahoo.com ([68.142.200.157]:21613 "HELO
	web30904.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133547AbVKEJH7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 5 Nov 2005 09:07:59 +0000
Received: (qmail 27446 invoked by uid 60001); 5 Nov 2005 09:08:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NcNDkKSeuO+yGsnfhyQI0Ju77DUIGl6fkNLzMgx1IJKZ6WvTVdwYy4J7gtsB/Rg9+NfcvZH6Bys81CcE6WIu4J3R6LusL3ZPzZsnHtJhkG7jhzC43R7k9xANb4tnlwsODFjgQd4SyBN/tRkI7J2z0MqkkIMMshRDLsH8jBVAp48=  ;
Message-ID: <20051105090852.27444.qmail@web30904.mail.mud.yahoo.com>
Received: from [12.65.150.231] by web30904.mail.mud.yahoo.com via HTTP; Sat, 05 Nov 2005 01:08:52 PST
Date:	Sat, 5 Nov 2005 01:08:52 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Booting with NFS fails
To:	Nguyen Thanh Binh <n_tbinh@yahoo.com>, linux-mips@linux-mips.org
Cc:	mlachwani@mvista.com
In-Reply-To: <20051105071303.60438.qmail@web30705.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Can you please post the complete boot log?

Thanks
Manish Lachwani

--- Nguyen Thanh Binh <n_tbinh@yahoo.com> wrote:

> Hello all,
> 
> I have installed Red Hat Enterprise 3 on the host
> (x86) and MontaVista Linux (previewkit) on the
> target
> (memec virtex-4 Fx12 LC board). When booting the
> target using NFS from the host, the following error
> appeared:
> 
>    eth0: Link carrier lost.
>    eth0: Could not read PHY control register; error
> 1003
>    eth0: Terminating link monitoring.
> 
> It is very strange, because ethernet does not work
> as
> the error shows but I can ping the target from the
> host with the IP got with DHCP.
> 
> Your help or experience would be appreciated.
> 
> Thank you.
> 
> Nguyen Binh
> 
> 
> 
> 		
>
___________________________________________________________
> 
> How much free photo storage do you get? Store your
> holiday 
> snaps for FREE with Yahoo! Photos
> http://uk.photos.yahoo.com
> 
> 
