Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 13:58:16 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:40646 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037484AbXCEN6O (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 13:58:14 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1416182uga
        for <linux-mips@linux-mips.org>; Mon, 05 Mar 2007 05:57:14 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=kqfrB3KGWkPdKLIU3njbopvqM/tBBHEf3w747IZGY98jzG3eRQWsV9HxSIxvlcRfPyOXGlCdkcTbwnoUzGpmkjAhdmUFxA//+BO7ww3OpPQLvUMHbs+liur1OtdNJj8r3xZBGFxJt2w59klCa0RmF3D4PfCbEC9346mwBONAIMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=mWyaWfwouY348mSX0YROEDtBwDuJG+Hc35kJZzq4w1J0eAfo8th/MVPuAHVkz61A1VD0W9GFVvQ+PXbrRJgDfvxYxTSOlyD5tmfbk00NNUhtKo9Qy0sk+ICSmMlkOKa0BURH9rELafILhX/U0H9Ns9zxo4Isl2Jl00T1upA87ck=
Received: by 10.115.77.1 with SMTP id e1mr1233585wal.1173103032690;
        Mon, 05 Mar 2007 05:57:12 -0800 (PST)
Received: by 10.114.80.18 with HTTP; Mon, 5 Mar 2007 05:57:12 -0800 (PST)
Message-ID: <d459bb380703050557o4dea6fs5fa3b336d37b9f@mail.gmail.com>
Date:	Mon, 5 Mar 2007 14:57:12 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Linux kernel 2.6.20, PCI and hpt266
In-Reply-To: <45EC101D.8050600@ru.mvista.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_134094_29693496.1173103032644"
References: <d459bb380703040427g4a8cad08kd8e3190f7d109c86@mail.gmail.com>
	 <45EC101D.8050600@ru.mvista.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_134094_29693496.1173103032644
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/5, Sergei Shtylyov <sshtylyov@ru.mvista.com>:

> Hello, I am trying to run kernel 2.6.20 on an Au1500 based board. Versions
> > 2.4.x of the kernel are correctly working.
>
>     How could they work I wonder? :-O


Eheheh :-)


> > Problem: on the board there is a HighPoint 371N ATA controller. At the
>
>     There's *no* proper support for HPT371N in 2.4.x.


We've modified them to work. We fixed the "first channel disabled" problem
and the "set pll with a wrong algorithm", etc. :-)


> Details:
> > The driver I use is "drivers/ide/pci/hpt266.c". I've already fixed the
>
>     I guess you mean hpt366.c. :-)


Whoops. Right. I'm using hpt366.c. I'd also like to try the nel libata
drivers.


> > timing problems and PLL configuration that afflict this controller, and
> > removed RESOURCE_64BIT to fix problems with the PCI bus on mips and
> > resource_size_t casts.
>
>     Erm, does it indeed fix the problem I wonder?


Well, at least this change removed the "skipping PCI config due to resource
conflict" error.


>     The PCI config. space accesses use completely different meachanism
> form
> I/O and memory accesses.


I suspected this, but sadly I am novice to PCI. Thank you very much, Sergei.

Today I've done another test: dumping I/O ATA registers, and the results are
puzzling:

The format is:

[hw->io_ports index] [I/O port addr] [I/O port value]

[17179571.588000] 0 addr: 0x1408  val: 0x08
[17179571.596000] 1 addr: 0x1409  val: 0x09
[17179571.608000] 2 addr: 0x140a  val: 0x0a
[17179571.620000] 3 addr: 0x140b  val: 0x0b
[17179571.632000] 4 addr: 0x140c  val: 0x0c
[17179571.644000] 5 addr: 0x140d  val: 0x0d
[17179571.656000] 6 addr: 0x140e  val: 0xa0
[17179571.668000] 7 addr: 0x140f  val: 0x0f
[17179571.680000] 8 addr: 0x1416  val: 0x0a
[17179571.692000] 9 addr: 0x00  val: 0x48

The values seem wrong to me..

Bye!

------=_Part_134094_29693496.1173103032644
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/3/5, Sergei Shtylyov &lt;<a href="mailto:sshtylyov@ru.mvista.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">sshtylyov@ru.mvista.com</a>&gt;:<br><br><span class="q"><span class="gmail_quote">
</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt; Hello, I am trying to run kernel 2.6.20 on an Au1500 based board. Versions<br>&gt; 2.4.x of the kernel are correctly working.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;How could they work I wonder? :-O</blockquote></span><div><br>Eheheh :-)<br>&nbsp;<br>
</div><span class="q">
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Problem: on the board there is a HighPoint 371N ATA controller. At the<br><br>&nbsp;&nbsp;&nbsp;&nbsp;There&#39;s *no* proper support for HPT371N in 
2.4.x.</blockquote></span><div><br>We&#39;ve modified them to work. We fixed the &quot;first channel disabled&quot; problem and the &quot;set pll with a wrong algorithm&quot;, etc. :-)<br><br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

&gt; Details:<br>&gt; The driver I use is &quot;drivers/ide/pci/hpt266.c&quot;. I&#39;ve already fixed the<br><br>&nbsp;&nbsp;&nbsp;&nbsp;I guess you mean hpt366.c. :-)</blockquote></span><div><br>Whoops. Right. I&#39;m using hpt366.c. I&#39;d also like to try the nel libata drivers.
<br>&nbsp;<br></div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; timing problems and PLL configuration that afflict this controller, and
<br>
&gt; removed RESOURCE_64BIT to fix problems with the PCI bus on mips and<br>&gt; resource_size_t casts.<br><br>&nbsp;&nbsp;&nbsp;&nbsp;Erm, does it indeed fix the problem I wonder?</blockquote></span><div><br>Well, at least this change removed the &quot;skipping PCI config due to resource conflict&quot; error.
<br>&nbsp;<br></div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&nbsp;&nbsp;&nbsp; The PCI config. space accesses use completely different meachanism form
<br>
I/O and memory accesses.</blockquote></span><br>I suspected this, but sadly I am novice to PCI. Thank you very much, Sergei.<br><br>Today I&#39;ve done another test: dumping I/O ATA registers, and the results are puzzling:
<br>
<br>The format is: <br><br>[hw-&gt;io_ports index] [I/O port addr] [I/O port value]<br><br>[17179571.588000] 0 addr: 0x1408&nbsp; val: 0x08<br>[17179571.596000] 1 addr: 0x1409&nbsp; val: 0x09<br>[17179571.608000] 2 addr: 0x140a&nbsp; val: 0x0a
<br>[17179571.620000] 3 addr: 0x140b&nbsp; val: 0x0b<br>[17179571.632000] 4 addr: 0x140c&nbsp; val: 0x0c<br>[17179571.644000] 5 addr: 0x140d&nbsp; val: 0x0d<br>[17179571.656000] 6 addr: 0x140e&nbsp; val: 0xa0<br>[17179571.668000] 7 addr: 0x140f&nbsp; val: 0x0f
<br>[17179571.680000] 8 addr: 0x1416&nbsp; val: 0x0a<br>[17179571.692000] 9 addr: 0x00&nbsp; val: 0x48<br><br>The values seem wrong to me..<br><br>Bye!

------=_Part_134094_29693496.1173103032644--
