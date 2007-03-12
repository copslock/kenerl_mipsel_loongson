Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2007 10:00:19 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.190]:46637 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021564AbXCLKAM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 Mar 2007 10:00:12 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1864522nfc
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2007 02:59:11 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=C6lKQpHSGshHgMFxoUuwLUByQlLqik0HMgDRwRurNU+bL78XJuhDYUtOQ0PaYGPPJQVRprecmt6pI3/d3FWlRp/C8FKGvrMuvTeU5ZF6VqOI3ib2ArnxCLBZoRcxRRJs28RywGulR5ktQQkCFCgmL0pn+kswtS8UUr/zRbqyQe8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ClT/M8xYnu2IgFW2tlJhw5yOAJWmXfWIjN3MOFAbBmlQp4+YEXp2lixy+J4n2i90A4OC+cDHkq/QIWMMzWulLrN7U/bduxhdl2g2462JwHmBJhMsNahytTsA8AKSv3iWhHuuWNb2fKmBet9RPNbkBKlPBirMI+Iirw3KOe3y8AU=
Received: by 10.115.78.1 with SMTP id f1mr1196399wal.1173693549659;
        Mon, 12 Mar 2007 02:59:09 -0700 (PDT)
Received: by 10.114.80.18 with HTTP; Mon, 12 Mar 2007 02:59:09 -0700 (PDT)
Message-ID: <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com>
Date:	Mon, 12 Mar 2007 10:59:09 +0100
From:	"Marco Braga" <marco.braga@gmail.com>
To:	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
Cc:	charles@cooper-street.com,
	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
In-Reply-To: <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24595_18868734.1173693549516"
References: <20070307104930.GD25248@dusktilldawn.nl>
	 <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com>
	 <45F350E9.3020208@cooper-street.com>
	 <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com>
Return-Path: <marco.braga@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marco.braga@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_24595_18868734.1173693549516
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I've added to: "snd_au1000_ac97_new" the lines:

au1000->ac97_ioport->config = AC97C_SG | AC97C_SYNC;
udelay(100);
au1000->ac97_ioport->config = 0x0;

after the cold reset, as you suggested. Sadly this did not solve the
problem.

It seems that the only solution I have at the moment is to add a longer
delay between hard reset and warm reset. I've changed the "udelay(10)" to a
"mdelay(250)" (I know, it is a huge delay) but now the module is loaded
perfectly every time. Now I'll try to reduce the delay and find the min.
I don't know if this issue is related to our board or if you can explain it.

What about the spin_lock_irqsave stuff? Do you suggest to leave them in or
it is better to return to the old simple spin_lock?


2007/3/12, Marco Braga <marco.braga@gmail.com>:
>
> Hi Charles, just a quick note: the "spin_lock_irqrestore" should be
> "spin_unlock_irqrestore". Anyway, the changed does not solve my problem
> (I've also tried the change in au1000_ac97_write).
> As you see in the logs at the end of the email, it seems that module
> loading has random results. I've managed to follow the problem to line 606,
> when it calls "snd_ac97_mixer". This call often returns an error.
>
> I'll try with the resets now..
>
>
> -- LOG: ------------------------------------------------
>
> # modprobe snd_au1x00
> [  584.704000] AC'97 0 does not respond - RESET
> [  584.717000] AC'97 0 access error (not audio or modem codec)
> insmod: cannot insert '/lib/modules/2.6.17.14/kernel/sound/mips/snd-
> au1x00.ko':
> Success (13): Success
> modprobe: failed to load module snd_au1x00
>
> # modprobe snd_au1x00
> [ 1345.967000] AC'97 0 does not respond - RESET
> [ 1345.980000] AC'97 0 access error (not audio or modem codec)
> insmod: cannot insert '/lib/modules/2.6.17.14/kernel/sound/mips/snd-
> au1x00.ko':
> Success (13): Success
> modprobe: failed to load module snd_au1x00
>
> # modprobe snd_au1x00
> [ 1351.211000] AC'97 0 does not respond - RESET
> [ 1351.224000] AC'97 0 access error (not audio or modem codec)
> insmod: cannot insert '/lib/modules/2.6.17.14/kernel/sound/mips/snd-
> au1x00.ko':
> Success (13): Success
> modprobe: failed to load module snd_au1x00
>
> # modprobe snd_au1x00
> [ 1355.471000] AC'97 0 analog subsections not ready
> [ 1355.497000] ALSA AC97: Driver Initialized
>
> # modprobe snd_au1x00
> [ 1361.837000] ALSA AC97: Driver Initialized
>
> # modprobe snd_au1x00
> [ 1365.403000] AC'97 0 analog subsections not ready
> [ 1365.428000] ALSA AC97: Driver Initialized
>
> # modprobe snd_au1x00
> [ 1369.037000] ALSA AC97: Driver Initialized
>
> # modprobe snd_au1x00
> [ 1372.374000] ALSA AC97: Driver Initialized
>
>
>

------=_Part_24595_18868734.1173693549516
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I&#39;ve added to: &quot;snd_au1000_ac97_new&quot; the lines:<br><br>au1000-&gt;ac97_ioport-&gt;config = AC97C_SG | AC97C_SYNC;<br>udelay(100);<br>au1000-&gt;ac97_ioport-&gt;config = 0x0;<br><br>after the cold reset, as you suggested. Sadly this did not solve the problem.
<br><br>It seems that the only solution I have at the moment is to add a longer delay between hard reset and warm reset. I&#39;ve changed the &quot;udelay(10)&quot; to a &quot;mdelay(250)&quot; (I know, it is a huge delay) but now the module is loaded perfectly every time. Now I&#39;ll try to reduce the delay and find the min.
<br>I don&#39;t know if this issue is related to our board or if you can explain it.<br><br>What about the spin_lock_irqsave stuff? Do you suggest to leave them in or it is better to return to the old simple spin_lock?<br>
<br><br><div><span class="gmail_quote">2007/3/12, Marco Braga &lt;<a href="mailto:marco.braga@gmail.com">marco.braga@gmail.com</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Charles, just a quick note: the &quot;spin_lock_irqrestore&quot; should be &quot;spin_unlock_irqrestore&quot;. Anyway, the changed does not solve my problem (I&#39;ve also tried the change in au1000_ac97_write).<br>As you see in the logs at the end of the email, it seems that module loading has random results. I&#39;ve managed to follow the problem to line 606, when it calls &quot;snd_ac97_mixer&quot;. This call often returns an error.
<br><br>I&#39;ll try with the resets now..<br><br><br>-- LOG: ------------------------------------------------<br><br># modprobe snd_au1x00<br>[&nbsp; 584.704000] AC&#39;97 0 does not respond - RESET<br>[&nbsp; 584.717000] AC&#39;97 0 access error (not audio or modem codec)
<br>insmod: cannot insert &#39;/lib/modules/2.6.17.14/kernel/sound/mips/snd-au1x00.ko&#39;:<br>Success (13): Success<br>modprobe: failed to load module snd_au1x00<br><br># modprobe snd_au1x00<br>[ 1345.967000] AC&#39;97 0 does not respond - RESET
<br>[ 1345.980000] AC&#39;97 0 access error (not audio or modem codec)<br>insmod: cannot insert &#39;/lib/modules/2.6.17.14/kernel/sound/mips/snd-au1x00.ko&#39;:<br>Success (13): Success<br>modprobe: failed to load module snd_au1x00
<br><br># modprobe snd_au1x00<br>[ 1351.211000] AC&#39;97 0 does not respond - RESET<br>[ 1351.224000] AC&#39;97 0 access error (not audio or modem codec)<br>insmod: cannot insert &#39;/lib/modules/2.6.17.14/kernel/sound/mips/snd-
au1x00.ko&#39;:<br>Success (13): Success<br>modprobe: failed to load module snd_au1x00<br><br># modprobe snd_au1x00<br>[ 1355.471000] AC&#39;97 0 analog subsections not ready<br>[ 1355.497000] ALSA AC97: Driver Initialized
<br><br># modprobe snd_au1x00<br>[ 1361.837000] ALSA AC97: Driver Initialized<br><br># modprobe snd_au1x00<br>[ 1365.403000] AC&#39;97 0 analog subsections not ready<br>[ 1365.428000] ALSA AC97: Driver Initialized<br><br>

# modprobe snd_au1x00<br>[ 1369.037000] ALSA AC97: Driver Initialized<br><br># modprobe snd_au1x00<br>[ 1372.374000] ALSA AC97: Driver Initialized<br><br><br>
</blockquote></div><br>

------=_Part_24595_18868734.1173693549516--
