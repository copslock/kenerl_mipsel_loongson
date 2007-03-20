Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2007 16:09:44 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.234]:49236 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022198AbXCTQJl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Mar 2007 16:09:41 +0000
Received: by wr-out-0506.google.com with SMTP id i31so1856039wra
        for <linux-mips@linux-mips.org>; Tue, 20 Mar 2007 09:08:33 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=eBfW388xh3lrU9zr7sZH9Qfw3mBGD6sQBVJyf3QRlanfDQtnoLhvQsWnnf+3HFBv46k17T+Nhq42Hg20ijxjelHX/nDr9LyIwlHCdgIULFJAiby2BIx1//MbJvud9xYGAseQ+lrA21i3AqiFozKSeLUcEf4azzz1DuqKPsdkXsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=gsWugOCBoaFRVDXwmbEkosqJ2gjWQE6v1cA7CWuWyfNxC+nnEIXzH23N2Mzo2OiAUqq+5SJDf11E5cg0FOP7A7zzw0HoIFzYG9boWbMqpMATL/YC3pNwI30uzdXjUlmVtMBZ/17t7+MK+LjPbOZNvh4tRnEqvfsE9rdVVV7QLSI=
Received: by 10.100.31.2 with SMTP id e2mr5158451ane.1174406913094;
        Tue, 20 Mar 2007 09:08:33 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 20 Mar 2007 09:08:32 -0700 (PDT)
Message-ID: <d459bb380703200908t2ab759f0u352dc0014ebe0b17@mail.gmail.com>
Date:	Tue, 20 Mar 2007 17:08:32 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: Au1500 and TI PCI1510 cardbus
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4600052B.40901@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_185181_6413699.1174406912790"
References: <d459bb380703190755n3f05b8e1v850bb8347e574d68@mail.gmail.com>
	 <200703200204.l2K24WgH020041@centurysys.co.jp>
	 <45FFEDED.6060708@ru.mvista.com>
	 <d459bb380703200747y13ba427ek83cc32b503c33bc7@mail.gmail.com>
	 <45FFFE8B.1010806@ru.mvista.com>
	 <d459bb380703200850m1077be9cnecb8283750763a4f@mail.gmail.com>
	 <4600052B.40901@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_185181_6413699.1174406912790
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/20, Sergei Shtylyov <sshtylyov@ru.mvista.com>:
>
> > I think I'm beginning to make a lot of confusion. Is the problem that
> the
> > PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 acts
> as
> > a bridge, so cardbus cards cannot work?
>
>     The second.


Ok, at the risk of appearing totally dumb, I'll double check.. If the second
ic correct, PCI1510 is a bridce, a cardbus card cannot work.


    You can see yourself that PCI1510 is a bridge (Cardbus-to-PCI bridge is
> largely the same as PCI-to-PCI bridge).


Ok.


> So it seems that the 3Com card is behind a bus. Should this work? From
> what
> > I've understood, it should now work..
>
>     Think again. :-)


Ok, that's a typo :-) It should NOT work. Is this better?

   Sounds like what's been told in the errata 32.


It seems that  Au1500 slowly faded into the shadows. Now it is owned by
Raza, but there is no sign of an errata document, perhaps I've lost the
magic moment when a lot of documentation was available.

But still, the question remains: how can Takeyoshi's "Ricoh CardBus Bridge"
work with a cardbus card if bridges cannot work with Au1500's PCI?

Scrub scrub..

------=_Part_185181_6413699.1174406912790
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/20, Sergei Shtylyov &lt;<a href="mailto:sshtylyov@ru.mvista.com">sshtylyov@ru.mvista.com</a>&gt;:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; I think I&#39;m beginning to make a lot of confusion. Is the problem that the<br>&gt; PCI1510 must NOT be behind a bridge, or the problem is that PCI1510 acts as<br>&gt; a bridge, so cardbus cards cannot work?<br><br>
&nbsp;&nbsp;&nbsp;&nbsp;The second.</blockquote><div><br>Ok, at the risk of appearing totally dumb, I&#39;ll double check.. If the second ic correct, PCI1510 is a bridce, a cardbus card cannot work.<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;&nbsp;&nbsp; You can see yourself that PCI1510 is a bridge (Cardbus-to-PCI bridge is<br>largely the same as PCI-to-PCI bridge).</blockquote><div><br>Ok.<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; So it seems that the 3Com card is behind a bus. Should this work? From what<br>&gt; I&#39;ve understood, it should now work..<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Think again. :-)</blockquote><div><br>Ok, that&#39;s a typo :-) It should NOT work. Is this better?
<br><br></div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&nbsp; Sounds like what&#39;s been told in the errata 32.</blockquote><div><br>It seems that&nbsp; Au1500 slowly faded into the shadows. Now it is owned by Raza, but there is no sign of an errata document, perhaps I&#39;ve lost the magic moment when a lot of documentation was available.
<br><br>But still, the question remains: how can <span class="sg">Takeyoshi&#39;s</span> &quot;Ricoh CardBus Bridge&quot; work with a cardbus card if bridges cannot work with Au1500&#39;s PCI?<br><br>Scrub scrub..<br><br>
<br></div><br></div><br>

------=_Part_185181_6413699.1174406912790--
