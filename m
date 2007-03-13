Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 08:45:09 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.172]:56087 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022215AbXCMIpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 08:45:05 +0000
Received: by ug-out-1314.google.com with SMTP id 40so202702uga
        for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 01:44:02 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=sxGukbo+DPKXTrDGHOfhF46GLyTbE1G4AVM1sRf0eTaeViLLVi1omYI7cfFLDuSdPdFnFnEhr8r0ZwyJ/+5CGv8kd4vg7Mk8dzOfrRcPMvAr9t2589S3kU8h3fXK6A8LvYivxz/HOelkZru/2t6oSYV4km6RzPOfZX4drRW4VOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=q1u/IW96R7Fc4jA3LNcWSfBknHYNYcuM8Lg5l69W+qV87XuBMZuU2pb168aVV4Z32rZcNqAA8J6R21H23N2sWTkQMk+8EOPG9ipQDJXYcZoqwHVHmchPerp2BbZV8dqoSa2JlgOOMr32u6+wAsXN3jKGLQpvtkL1d4D/HGWb6Zo=
Received: by 10.114.135.1 with SMTP id i1mr2270606wad.1173775441840;
        Tue, 13 Mar 2007 01:44:01 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Tue, 13 Mar 2007 01:44:01 -0700 (PDT)
Message-ID: <d459bb380703130144q519a1760p81aae999ec59fa4f@mail.gmail.com>
Date:	Tue, 13 Mar 2007 09:44:01 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
In-Reply-To: <20070313010955.GA27567@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_23672_21893911.1173775441796"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <45F350E9.3020208@cooper-street.com>
	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
	 <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
	 <20070312103927.GC14658@moe.telargo.com>
	 <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com>
	 <45F57328.8000606@ru.mvista.com>
	 <20070313004315.GA26119@linux-mips.org>
	 <45F5F7CA.3000503@righthandtech.com>
	 <20070313010955.GA27567@linux-mips.org>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14446
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_23672_21893911.1173775441796
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,

2007/3/13, Charles Eidsness <charles@cooper-street.com>:
>
> I wonder if the AC'97 Controller has to be up for at least one frame
> before issuing the cold reset. Each frame is 20.8us, you could try
> setting that delay to 25us instead of 500ms.


I've tested this. I've changed my delay to a "udelay(25)". It didn't work.

Sergei on the mailing list had a good suggestion as well. You could try
> replacing every udelay with an au_sync_udelay, and each mdelay with an
> au_sync_delay.


I've done this too. Still no success.


> You could even try dropping in an au_sync at the end of
> the snd_au1000_ac97_new function.


No success, but I've found that I can reduce the delay to at least 200ms.
I'll try with lower values.

I hope that my inexperience (and perhapes errors while testing) don't lead
you to wrong conclusions, but from the trials I've done the only change that
at the moment works for me is the 200ms delay.

------=_Part_23672_21893911.1173775441796
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everyone,<br><br>2007/3/13, Charles Eidsness &lt;<a href="mailto:charles@cooper-street.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">charles@cooper-street.com</a>&gt;:<span class="q"><span class="gmail_quote">

</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
I wonder if the AC&#39;97 Controller has to be up for at least one frame<br>before issuing the cold reset. Each frame is 20.8us, you could try<br>setting that delay to 25us instead of 500ms.</blockquote></span><div><br>I&#39;ve tested this. I&#39;ve changed my delay to a &quot;udelay(25)&quot;. It didn&#39;t work.
<br><br></div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Sergei on the mailing list had a good suggestion as well. You could try
<br>replacing every udelay with an au_sync_udelay, and each mdelay with an
<br>au_sync_delay.</blockquote></span><div><br>I&#39;ve done this too. Still no success.<br>&nbsp;<br></div><span class="q"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


 You could even try dropping in an au_sync at the end of<br>the snd_au1000_ac97_new function.</blockquote></span><br>No success, but I&#39;ve found that I can reduce the delay to at least 200ms. I&#39;ll try with lower values.
<br><br>I hope that my inexperience (and perhapes errors while testing)
don&#39;t lead you to wrong conclusions, but from the trials I&#39;ve done the
only change that at the moment works for me is the 200ms delay.

------=_Part_23672_21893911.1173775441796--
