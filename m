Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 14:47:20 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.245]:3792 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022077AbXCTOrS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 14:47:18 +0000
Received: by an-out-0708.google.com with SMTP id c8so1571309ana
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 07:47:11 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=Wda+DhpvdkVxKnx6woLUwvbBHuGZtaZLABmdYiDIgHU8E2VQuJyBXqqtOc91pF+LUnixXySxm++zuc+wFvQMT628b7PVTjJLFkiUZyxfEKEPUtp7kuO2MZ5CSehN3uQDDJzb3Q7CtU1rZxJOD8WgFUu990yBaXeS33KDv2O6Fns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=iN6CsL7915z3dRPzpSFFupS5XIWnUg7uaTziux51pxFaOB0V34io5U6Muz9yCWe1F2fODe1n3IwWMGQOo+KxNsHBEIEFn8TJm2Hk7m+gktmm8eQZ2ZRK6f829MddrGBaKtF18qc+x2cVM5d8Gowp0m4NfcsVJ/1goMEnbASb0hw=
Received: by 10.100.133.9 with SMTP id g9mr5031532and.1174402030895;
        Tue, 20 Mar 2007 07:47:10 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 20 Mar 2007 07:47:10 -0700 (PDT)
Message-ID: <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
Date:	Tue, 20 Mar 2007 15:47:10 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Au1500 and TI PCI1510 cardbus
In-Reply-To: <45FFEDED.6060708@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_182445_9198083.1174402030334"
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	 <200703200204.l2K24WgH020041@centurysys.co.jp>
	 <45FFEDED.6060708@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_182445_9198083.1174402030334
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/20, Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>
>     What I don't understand is why use USB card on CardBus, if the Au1500
> datasheet clearly tells us (well, at least me :-) that this is *not* going
> to
> work?
>

I'll reply for my part: we need something hotswappable, and support for
wifi. The first idea was to use cardbus, so a board was built using PCI1510.
When the system was projected, USB2.0 was not easy to find (if even existed)
and almost every wifi card was PCMCIA or Cardbus. The PCI1510 never worked,
and it seems now that never will. So at the moment an alternative is to try
a wifi dongle on USB. USB 1.x was too slow, but USB 2.0 seems ok for our
application. Au1500 does not support USB2.0, so I am looking for a
PCI/USB2.0 controlles. Does something similar exist? Does it work on Au1500?

To make it short, we are NOT trying to make USB work on Cardbus, but to use
either cardbus OR usb. :-)

From what you've told me cardbus on PCI (being a bridge) cannot work with
AU1500's PCI device. So the next idea is to try an USB controller on PCI.
Will it work? Well, I'm hoping for some fresh hand advice on this.

Now Takeyoshi tells me that he's using both USB2.0 and Cardbus (not USB on
Cardbus), so this seems interesting. I still think that USB is the best way
to go, but still a working PCI to Cardbus controller can be interesting. But
I don't know how he's managed to make it work, since from what you have told
me it should not work. Perhaps he's not using Cardbus devices but PCMCIA.

------=_Part_182445_9198083.1174402030334
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/3/20, Sergei Shtylyov &lt;<a href="mailto:sshtylyov@ru.mvista.com">sshtylyov@ru.mvista.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;&nbsp;&nbsp; What I don&#39;t understand is why use USB card on CardBus, if the Au1500<br>datasheet clearly tells us (well, at least me :-) that this is *not* going to<br>work?<br></blockquote></div><br>I&#39;ll reply for my part: we need something hotswappable, and support for wifi. The first idea was to use cardbus, so a board was built using PCI1510. When the system was projected, 
USB2.0 was not easy to find (if even existed) and almost every wifi card was PCMCIA or Cardbus. The PCI1510 never worked, and it seems now that never will. So at the moment an alternative is to try a wifi dongle on USB. USB 
1.x was too slow, but USB 2.0 seems ok for our application. Au1500 does not support USB2.0, so I am looking for a PCI/USB2.0 controlles. Does something similar exist? Does it work on Au1500?<br><br>To make it short, we are NOT trying to make USB work on Cardbus, but to use either cardbus OR usb. :-)
<br><br>From what you&#39;ve told me cardbus on PCI (being a bridge) cannot work with AU1500&#39;s PCI device. So the next idea is to try an USB controller on PCI. Will it work? Well, I&#39;m hoping for some fresh hand advice on this.
<br><br>Now <span class="q">Takeyoshi tells me that he&#39;s using both USB2.0 and Cardbus (not USB on Cardbus), so this seems interesting. I still think that USB is the best way to go, but still a working PCI to Cardbus controller can be interesting. But I don&#39;t know how he&#39;s managed to make it work, since from what you have told me it should not work. Perhaps he&#39;s not using Cardbus devices but PCMCIA.
<br><br></span>

------=_Part_182445_9198083.1174402030334--
