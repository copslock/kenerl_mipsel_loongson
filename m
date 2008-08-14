Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 12:42:18 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.153]:13389 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20031740AbYHNLmM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 14 Aug 2008 12:42:12 +0100
Received: by fg-out-1718.google.com with SMTP id d23so340046fga.32
        for <linux-mips@linux-mips.org>; Thu, 14 Aug 2008 04:42:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=8M0Ed9dTtT9AnY6ARNc7G9hHJrAOjjzBTRg/4fIGXKQ=;
        b=wGUECT5rdVwz3ikfxQKEIY2xOWtUZ/tCYDOaydluiz0bSSKu8EsyDU1WlLotSgg/5q
         S4QAbkO1VzcRtNT9QXe277QGabINiN95Q07uWWKHtwBjHOk1WzMpOVOVo8XgMoyL7oHz
         7DfbuAmmGxctk4WVEZ2u+lOIm+Lzjo9tcFhJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=FUEeU2FKS+msRW00T4HIUFsZTSY9jMrusnwmmYDhstankAedj/tWWjjhYujjIpSxzC
         g/ts/JYSTxV3xYJ3lpSq/jU99x5Ws923TRIs8UV9rD6hljsPK7JdnbYqBn2trTfGdtAR
         RcVhR8s2IUVMYylIxAn0l9SoNRrQ4QCazqTHM=
Received: by 10.86.72.3 with SMTP id u3mr143750fga.62.1218714129933;
        Thu, 14 Aug 2008 04:42:09 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id e20sm4310846fga.1.2008.08.14.04.42.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 04:42:09 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: Debugging the MIPS processor using GDB (and FS2 EJTAG probe breakpoint issues)
Date:	Thu, 14 Aug 2008 13:42:20 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
References: <18944199.post@talk.nabble.com> <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl> <200808131707.30570.brian.foster@innova-card.com>
In-Reply-To: <200808131707.30570.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808141342.20496.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 13 August 2008 17:07:30 Brian Foster wrote:
>[ ... ]
>   On Wed, 13 Aug 2008, Brian Foster wrote:
>   >   Re the FS²:  [ ... ]  at least one thing doesn't work
>   >  reliably for me [ ... ]:  Breakpoints in the Linux kernel.
>   >  They do detonate.  Then, sometimes, I can ‘c’(ontinue) or
>   >  ‘s’(tep) Ok.  But other times, when I ‘c’ or ‘s’, the
>   >  breakpoint detonates again and I'm stuck.  [ ... ]
>[ ... ]
>   I'm using the most recent FS² (2.4.4) with the most recent
>  SDE-Lite from MIPS (V6.06.01).  Older versions of FS²/SDE
>  had the same(?) issue.  (This is with a 4KSd core, running
>  Little Endian.)
>[ ... ]
>   The behavior [ is ]:
> 
>    s1. gdb     b xxx_open
>    s2. target  cat /dev/xxx
>    s3. (breakpoint detonates)
>    s4. gdb     x/i $pc     (all is Ok)
>    s5. gdb     c           (Ok)
>    s6. target  cat /dev/xxx
>    s7. (breakpoint detonates)
>    s8. gdb     x/i $pc     (wrong! instruction is ‘sdbbp’.)
> 
>   I'm now stuck.  Any attempt to ‘c’ or ‘s’ just hits the
>  breakpoint again.
>[ ... ]
>  ( I seem to recall also having an issue with hardware
>   breakpoints, but cannot recall for certain ATM; tests
>   will have to wait until later ....  ;-\  )

Hello!

 Just in case someone recognizes these symptoms (or has
 any ideas) ....

  I tried hardware breakpoints from ‘gdb’ and got:

     h1. gdb     hb xxx_open
     h2. gdb says:
           warning: Cannot query hardware breakpoint/watchpoint resources.
           warning: Available functionality may be limited.
     h3. target  cat /dev/xxx
     h4. Nothing happens!  (The breakpoint does not detonate.)

 The warnings from ‘sde-gdb’ (h2) have me puzzled.  As I read
 the VHDL synthesis definitions for our implementation of the
 4KSd core — an advantage of working for a HW company! — we
 should have 4 I and 2 D hardware breakpoints in Debug (EJTAG)
 Mode.   Related, and maybe significantly, ‘info reg’ from
 ‘sde-gdb’ reports “xxxxxxxx” for the ‘debug’ register (WTF?).

  I also tried the ‘sysnav’ command ‘bkpt’ (via the ‘monitor’
 command in ‘gdb’).   It works!   ‘set’, ‘setsw’, and ‘sethw’
 all work as expected in my simple test (below, 0xVIRTUAL is
 the virtual address of xxx_open()):

     m1. gdb     monitor bkpt set 0xVIRTUAL
     m2. target  cat /dev/xxx
     m3. (breakpoint detonates)
     m4. gdb     x/i $pc     (all is Ok)
     m5. gdb     c           (Ok)
     m6. target  cat /dev/xxx
     m7. (breakpoint detonates)
     m8. gdb     x/i $pc     (all is Ok)
     m9. gdb     c           (Ok)
     (... and repeat ad infinitum (‘s’ also works) ...)

 I presume I can cook up some ‘gdb’ macros to can (simplify)
 those horrible ‘monitor bkpt ...’ commands, but I shouldn't
 have to do that, should I?  ;-\ 

  Any ideas?  (And yes, I'm attempting to pursue this with
 FS²/MIPS, but .... .)

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
