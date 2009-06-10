Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 15:12:23 +0100 (WEST)
Received: from mail-ew0-f224.google.com ([209.85.219.224]:60366 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022047AbZFJOMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 15:12:16 +0100
Received: by ewy24 with SMTP id 24so754888ewy.0
        for <linux-mips@linux-mips.org>; Wed, 10 Jun 2009 07:12:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5XqtoF11msMVWZaZXz/iCIfPkhrhU7XlcttZMYog/2s=;
        b=Jbi8H2kwUyy9RxRHmrUo31ag1zF5vSYyMDkW5ddvnPyChLxm8CnMR1mc2OUAd+t5Y1
         rBx/P7tdyzLxxKMaYLUFA8Fjf5RkDN9axU306ktUM0wsez70u30GgjQl9HXnw5P4HLO5
         yjvULUF5LhWwO+hiNXFwwRXD2rzf3uitXs38A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XM2SZEJ4CWNlenq6Skncwfhw9i7fySfMaddWzppxb9uy/EB76nUCOVEEYxX/M+1jFK
         6Az14p/3oocpONmk/KQyAa2Ln5y6Z3cE6oUOIrLLaM2ZoBeByIOvz00ocpocXUX55e4F
         5n8pJRY4XHfDfCx8z/jSiTl9xDssR9qgQkahk=
Received: by 10.210.141.19 with SMTP id o19mr1687703ebd.54.1244643127859;
        Wed, 10 Jun 2009 07:12:07 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 7sm180137eyg.7.2009.06.10.07.12.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 07:12:06 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Glyn Astill <glynastill@yahoo.co.uk>
Subject: Re: Qube2 slowly dies
Date:	Wed, 10 Jun 2009 16:12:00 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <137040.69938.qm@web23605.mail.ird.yahoo.com>
In-Reply-To: <137040.69938.qm@web23605.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906101612.02025.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Glyn,

Le Wednesday 10 June 2009 16:04:03 Glyn Astill, vous avez écrit :
> Hi people,
>
> I've been directed here from the Debian lists by Martin Michlmayr. I'm
> running lenny on a qube2 128mb ram / 40gb disk.
>
> I've tried kernels 2.6.26 and 2.6.30~rc8 and the issue I'm about to
> describe is present in both, I haven't tried any other kernels - but I will
> try 2.6.22 when I can.
>
> Essentially the machine gets more and more sluggish until it finally dies.
> I've had a quick look in meminfo and I can't see that it's running out of
> memory, and I'm not sure what else to check?

Determine which process consumes all that memory. Can you describe which 
programs you are running on your Qube2 ?

>
> I find it hard to describe what's going off, but here's a scenario I hope
> illustrates the problem. The configure script is just an example of doing
> something - I could easily have extracted an archive with tar or something
> for the same results;
>
> - I start 2 ssh sessions and in one start configure for the postgres
> source, in the other I just started top.
>
> - And for a while all seems fine; configure ticks away and top refreshes
> every second.
>
> - Then top stops ticking over - but it'll refresh with a keypress. Anyway I
> exit top and try to run it again... nothing. I hit ctrl-c which brings me
> back to the prompt and I try again... nothing.
>
> - The configure script is still ticking over slowly.
>
> - I try "ps ax" - it works; so I try it again... nothing.
>
> - I try "ipcs" and "lsof" they both work and seem to keep working.
>
> - I try "ps ax" again... nothing. I hit ctrl-c and now it doesn't come back
> to the command prompt for a while.. say 5 minutes and eventually it's back.
>
> - It's still going. Some commands still work, some just do nothing.
> proc/meminfo shows it's not eaten all the memory.
>
> - If I try to start another ssh session I can log in, I get the motd, but I
> don't get to the shell.
>
> - Eventually the configure script ends, and all shells come back to the
> prompt. But it now seems totally braindamaged, I can run "ps ax" but "top"
> and other commands still do nothing. Heres strace attached to the top
> process:
>
> deb:~# strace -p 7228
> Process 7228 attached - interrupt to quit
> _newselect(0, NULL, NULL, NULL, {0, 500013}
>
> - Then after a little while the whole thing becomes unresponsive.
>
>
> Can anyone confirm they've seen the same behaviour or direct me what to
> look into?

I have been running linux-mips git builds for about a year and half now on my 
Qube2 without any troubles, the box serves as NFS/FTP server and works pretty 
well and sustains bandwidth.

My guess is that you are having a hardware problem or the box might not be 
cooled as it should be. If you want, you can test the following kernel which 
I have been running on this qube2 for some months: 
http://alphacore.org/~florian/linux-mips/qube/

Hope that helps.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
