Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 16:07:35 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.154]:24346 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28593481AbYHMPH1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 16:07:27 +0100
Received: by fg-out-1718.google.com with SMTP id d23so39780fga.32
        for <linux-mips@linux-mips.org>; Wed, 13 Aug 2008 08:07:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=kUoGw88q050d3HOoa9ATJERfvra1w79e+irsG6UUEcg=;
        b=qCVD7YKcRiJYNh8fULi7tgy7nwtOcOVXWtzpdlZTgyizQoio4rGChWoCG5ZBOy/28l
         nxiJJGOrqUL88Ow4PEU/3hVvw28nx+nKsVanjKHTEscbAUtDdAlvFxIJQS7f7d3lck2R
         K15mMRuozzsWH4NKwmiVdbGAPY9C47QuYEBd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=RGCe3DSBOM2jZLbTywMRHpQ6SkEmx2frsuD0YuHW0WV5hgwS7UgCVtFzn4IpKGdMYs
         gLeQZ1SRTmBIo5h65q0EQ/9me7+LtqSDnWL/5ollsBvQJfSUpjHV5KN+UbJcaNivazeV
         NHmcRB3pNaG5avTynp+Od503Er+UnTCu2BeKk=
Received: by 10.86.52.6 with SMTP id z6mr134884fgz.18.1218640045636;
        Wed, 13 Aug 2008 08:07:25 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id d4sm1172063fga.8.2008.08.13.08.07.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 08:07:24 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Debugging the MIPS processor using GDB
Date:	Wed, 13 Aug 2008 17:07:30 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	linux-mips@linux-mips.org,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
References: <18944199.post@talk.nabble.com> <200808130905.53671.brian.foster@innova-card.com> <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl>
In-Reply-To: <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808131707.30570.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 13 August 2008 15:49:39 Maciej W. Rozycki wrote:
> On Wed, 13 Aug 2008, Brian Foster wrote:
> 
> >   Re the FSÂ²:  [ ... ]  at least one thing doesn't work
> >  reliably for me [ ... ]:  Breakpoints in the Linux kernel.
> >  They do detonate.  Then, sometimes, I can ‘c’(ontinue) or
> >  ‘s’(tep) Ok.  But other times, when I ‘c’ or ‘s’, the
> >  breakpoint detonates again and I'm stuck.  [ ... ]
> 
>  Hmm, odd.  It looks like a cache coherence issue.

Maciej,

  That would be my guess also.

>  It could be a bug in your version of FS2 software -- did you raise the issue with them?  

  I've been trying to.  (I cannot say more on this ATM, sorry!)

  I'm using the most recent FS² (2.4.4) with the most recent
 SDE-Lite from MIPS (V6.06.01).  Older versions of FS²/SDE
 had the same(?) issue.  (This is with a 4KSd core, running
 Little Endian.)

  What _might_ be an issue/cause is we're using our own
 home-grown ‘gdb’ scripts (to init the memory, load the
 kernel, etc.).  I didn't write them, but I have looked
 them over, and they _look_ Ok to me.


> Anyway, as a workaround try setting "coherent=on" (quoting from memory)
> in fs2.ini (just an idea -- it may not work and you will lose some
> performance though) or use hardware breakpoints.

  As it turns out, I _have_ been running Coherent On!
 So I tried turning if Off, just to see what would happen.
 No difference.

  The behavior I saw was:

    1. gdb     b xxx_open
    2. target  cat /dev/xxx
    3. (breakpoint detonates)
    4. gdb     x/i $pc     (all is Ok)
    5. gdb     c           (Ok)
    6. target  cat /dev/xxx
    7. (breakpoint detonates)
    8. gdb     x/i $pc     (wrong! instruction is ‘sdbbp’.)

  I'm now stuck.  Any attempt to ‘c’ or ‘s’ just hits the
 breakpoint again.

  I tried some “mdi cacheflush” at some plausible-seeming
 points, all to no effect.  I also tried deleting the
 breakpoint (after step 8), which was a disaster:  (From
 memory) when I then ‘c’(ontinued), ‘gdb’ hung, and the
 ‘sysnav’ went into an infinite loop of reporting a
 breakpoint.  ;-(

 ( I seem to recall also having an issue with hardware
  breakpoints, but cannot recall for certain ATM; tests
  will have to wait until later ....  ;-\  )

  All ideas and suggestions are very welcome!

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
