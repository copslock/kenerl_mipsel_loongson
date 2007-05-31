Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2007 13:41:18 +0100 (BST)
Received: from smtp105.plus.mail.mud.yahoo.com ([68.142.206.238]:46168 "HELO
	smtp105.plus.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20025511AbXEaMlQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 31 May 2007 13:41:16 +0100
Received: (qmail 90931 invoked from network); 31 May 2007 12:40:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=iz1/ODxDKY+CKccfq4rZMoCujts+HU7U3T/S8J0VgsM1iJTKK/vbvMeurTO/XNU4nZEv8KSQi6MqvpNr74uap0M1CgY3oIRa2mvQnmOGD+d9AjVuGUKah6XFL+iEIx5OKmHfanzvKJs/zLkODX+wMWybyoUvjnJWPBcY2/3i2FQ=  ;
Received: from unknown (HELO ?192.168.254.7?) (jscottkasten@72.185.69.24 with login)
  by smtp105.plus.mail.mud.yahoo.com with SMTP; 31 May 2007 12:40:08 -0000
X-YMail-OSG: IFveO48VM1nbgUO.qvUm1uPhqcd5OAsnBiRCLlMoKhBrWzi6D68dg3bfyem68GsD0gjLh7brOg--
Date:	Thu, 31 May 2007 08:38:59 -0400 (EDT)
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@bluefang.tetracon-eng.net
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	debian-mips@lists.debian.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Several packages whose page size is 4k.
In-Reply-To: <20070528131703.GA10298@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0705310834040.26620@bluefang.tetracon-eng.net>
References: <464A7C53.3010309@lemote.com> <464A805C.5020606@ict.ac.cn>
 <20070516081555.GA22169@networkno.de> <464AC466.4000907@lemote.com>
 <20070516085737.GD22169@networkno.de> <20070516094617.GJ19816@deprecation.cyrius.com>
 <464ADF9B.6050602@lemote.com> <464AE59E.2070004@ict.ac.cn>
 <20070528131703.GA10298@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


Ralf, could you please elaborate on the "generic ALSA/MIPS" issue?

My interest is that there's a marginally functional IP32 sound driver 
floating around that I'm trying to find the time to fix up and get in 
tree.  Anything ALSA/MIPS is of interest right now.

Thanks,

-Scott-

On Mon, 28 May 2007, Ralf Baechle wrote:

>
> The ALSA patch solves a generic ALSA/MIPS issue, so independent of the
> rest.  So I suggest we tackle the rest of the Fulong patchset separately.
> Just resend the Fulong patchset once the issues I raised have been resolved.
>
>  Ralf
