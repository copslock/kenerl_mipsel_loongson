Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2007 08:05:29 +0000 (GMT)
Received: from wr-out-0506.google.com ([64.233.184.226]:3187 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021406AbXCOIFZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 Mar 2007 08:05:25 +0000
Received: by wr-out-0506.google.com with SMTP id 25so77313wry
        for <linux-mips@linux-mips.org>; Thu, 15 Mar 2007 01:04:23 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=ZkToqLJ+Y2Ym4RFfoicUEpUYw+1Y3DsPW5wmh9Co9d5ONWQV+I/cy6DMROPDnWxO87rwpluslA4HUio8z+8S/R9d/j2f0gLokBqICN4hkkGXz++w3hMTk/Ruqo9UlAoGCCVvW62tYhYWQtSPu+FMQoohjS/1PvVJyp1kaO3sY2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=HnYNKzF44/vT774oZ3inWSHo8lUfezrvo1ydNx2qJC8bNJwFM8UZP63gq+ee1nIrmNBow3oLqE5yxnSQIxBa1WeKnJuR0YYOB21P+cZdCXNCR0UflGN2zcY5Uuo6MIS5+v0G8c+VgAbKXEWLs/Vsh6fvIdcu4LFauGtzuOWNM5U=
Received: by 10.114.204.3 with SMTP id b3mr120557wag.1173945863166;
        Thu, 15 Mar 2007 01:04:23 -0700 (PDT)
Received: by 10.114.159.16 with HTTP; Thu, 15 Mar 2007 01:04:23 -0700 (PDT)
Message-ID: <d459bb380703150104ge21f2a0u71fe634cf3719612@mail.gmail.com>
Date:	Thu, 15 Mar 2007 09:04:23 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
In-Reply-To: <d459bb380703131612m36c70ecaka83175b3d8a30bc5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_78189_19426648.1173945863058"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
	 <45F350E9.3020208@cooper-street.com>
	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
	 <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
	 <45F5DC73.9060004@cooper-street.com>
	 <d459bb380703130143w7c98e1cchdbdae6cb9a7ac7ce@mail.gmail.com>
	 <45F71FFD.202@cooper-street.com>
	 <d459bb380703131612m36c70ecaka83175b3d8a30bc5@mail.gmail.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_78189_19426648.1173945863058
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As promised, this is my change:

linux/sound/mips/au1x00.c, function "snd_au1000_ac97_new":

...
    /* Initialise Au1000's AC'97 Control Block */
    au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
    udelay(10);
    au1000->ac97_ioport->cntrl = AC97C_CE;

    /* Original delay 10us */
    /* udelay(10); */

    /* New delay 200ms */
    mdelay(200);

    /* Initialise External CODEC -- cold reset */
    au1000->ac97_ioport->config = AC97C_RESET;
    udelay(10);
    au1000->ac97_ioport->config = 0x0;
    mdelay(5);
...

------=_Part_78189_19426648.1173945863058
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As promised, this is my change:<br><br>linux/sound/mips/au1x00.c, function &quot;snd_au1000_ac97_new&quot;:<br><br>...<br>&nbsp;&nbsp;&nbsp; /* Initialise Au1000&#39;s AC&#39;97 Control Block */<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;cntrl = AC97C_RS | AC97C_CE;
<br>&nbsp;&nbsp;&nbsp; udelay(10);<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;cntrl = AC97C_CE;<br><br>&nbsp;&nbsp;&nbsp; /* Original delay 10us */<br>&nbsp;&nbsp;&nbsp; /* udelay(10); */<br><br>&nbsp;&nbsp;&nbsp; /* New delay 200ms */<br>&nbsp;&nbsp;&nbsp; mdelay(200);<br><br>&nbsp;&nbsp;&nbsp; /* Initialise External CODEC -- cold reset */
<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;config = AC97C_RESET;<br>&nbsp;&nbsp;&nbsp; udelay(10);<br>&nbsp;&nbsp;&nbsp; au1000-&gt;ac97_ioport-&gt;config = 0x0;<br>&nbsp;&nbsp;&nbsp; mdelay(5); <br>...<br><br><br>

------=_Part_78189_19426648.1173945863058--
