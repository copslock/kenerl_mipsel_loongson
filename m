Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 00:20:35 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.239]:24669 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038925AbXBTAUa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 00:20:30 +0000
Received: by wr-out-0506.google.com with SMTP id i21so1530934wra
        for <linux-mips@linux-mips.org>; Mon, 19 Feb 2007 16:19:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Wti+9oZMvD/6/rEQqhVS2eaO5IG03X/lzNNOP4mOH7WECYrlziXgPFIY60BbsOYGHk+Y4H3c3EgGTeQ1nd9ACH253KJC+awq5/Aj/4l9oAcKFR2ffHT3cIrU8Awh00l5BkW0dtaHKnPAn7x757XWw+IOEsptRYs56kwNG5wxYd0=
Received: by 10.114.13.1 with SMTP id 1mr3142490wam.1171930768365;
        Mon, 19 Feb 2007 16:19:28 -0800 (PST)
Received: by 10.114.74.12 with HTTP; Mon, 19 Feb 2007 16:19:28 -0800 (PST)
Message-ID: <825284a90702191619q627310e7x957a9d4807746fbb@mail.gmail.com>
Date:	Mon, 19 Feb 2007 16:19:28 -0800
From:	"Woodrow Tree" <tigerand@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] Clean up serial console support on Sibyte 1250 duart
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070220000608.GB14034@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_58771_6485207.1171930768309"
References: <20070219234816.GA12092@onstor.com>
	 <20070220000608.GB14034@linux-mips.org>
Return-Path: <tigerand@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_58771_6485207.1171930768309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/19/07, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Mon, Feb 19, 2007 at 03:48:24PM -0800, Andrew Sharp wrote:
>
> Patch looks reasonable at a quick glance.  I'll review it for real
> later, just wanted to mention that the drivers/char/ Sibyte serial
> driver is really a dead end of the evolution.  The driver should
> be replaced with a new driver based on the the new drivers/serial/
> infrastructure.
>
>   Ralf
>


That explains the "shouldn't there be a general frame work for all this?"
itch in the back of my neck the whole time I was hacking on it.

a

------=_Part_58771_6485207.1171930768309
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 2/19/07, <b class="gmail_sendername">Ralf Baechle</b> &lt;<a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Mon, Feb 19, 2007 at 03:48:24PM -0800, Andrew Sharp wrote:<br><br>Patch looks reasonable at a quick glance.&nbsp;&nbsp;I&#39;ll review it for real<br>later, just wanted to mention that the drivers/char/ Sibyte serial<br>driver is really a dead end of the evolution.&nbsp;&nbsp;The driver should
<br>be replaced with a new driver based on the the new drivers/serial/<br>infrastructure.<br><br>&nbsp;&nbsp;Ralf<br></blockquote></div><br><br>That explains the &quot;shouldn&#39;t there be a general frame work for all this?&quot; itch in the back of my neck the whole time I was hacking on it.
<br><br>a<br>

------=_Part_58771_6485207.1171930768309--
