Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 09:42:40 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.159]:43211 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20027444AbYFRImd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2008 09:42:33 +0100
Received: by fg-out-1718.google.com with SMTP id d23so77941fga.32
        for <linux-mips@linux-mips.org>; Wed, 18 Jun 2008 01:42:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=ZooI+/Lk0/XVgAQrSPYivlaorS+GQn/XGOZePEcVT3I=;
        b=uqRhCIDfU0yZmz+2PN2O05ZsR2+2gcaLqpPcCn5P4fFOdp2cgOqMPclAkquSHweUer
         NCTqk7W5FtzzxyPZ1RVy86Spcflqhy2XNuqWWAICrXpP11jhf02lDaRokwZN2l903/Rt
         esI5uvJcaSk/kgncjy/xRhAx1eNpDZNjMvOaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=FA3vSutB3ep74/1yAbALa8PIxspblqDKP50N35M/6kHDs/1sm7CbLcotVwedGNKS2k
         K6aexWEaasMYXq8EqE5e8tn4LRZkhnbTSvlW2dhXdiS1F/4/eLa1NvcxY66BTIASktdJ
         c1VZSh7XirWjAunpqrk0l6AoxyVXkmERC+mJs=
Received: by 10.86.66.11 with SMTP id o11mr443015fga.43.1213778550865;
        Wed, 18 Jun 2008 01:42:30 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 12sm14867171fgg.0.2008.06.18.01.42.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 01:42:28 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: Re: Adding(?) XI support to MIPS-Linux?
Date:	Wed, 18 Jun 2008 10:42:12 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	David Daney <ddaney@avtrex.com>, Thiemo Seufer <ths@networkno.de>,
	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Andrew Dyer <adyer@righthandtech.com>
References: <200806091658.10937.brian.foster@innova-card.com> <484EAA16.80903@avtrex.com> <200806111516.57406.brian.foster@innova-card.com>
In-Reply-To: <200806111516.57406.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200806181042.12911.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Wednesday 11 June 2008 15:16:56 Brian Foster wrote:
>[ ... ]
>  It's [ ... ] the trampoline that has “something to do with
>  FPU emulation”, which has me concerned ATM.  [ ... ]
> 
>  The quick summary [ ... ] is the FP trampoline, which is pushed
>  on the user-land stack is, unlike sigreturn, not fixed code.
>  It varies on a per-instance per-thread basis.  Hence the
>  simple ‘vsyscall’ mechanism ((to be?) used for sigreturn)
>  is inappropriate.
> 
>  The trampoline is only used to execute a non-FP instruction
>  (<instr>) in the delay slot of an FP-instruction:
> 
      [ point A "before" <instr> ]
>      <instr>  # Non-FP instruction to execute in user-land
      [ point B "after" <instr> "before" BADINST ]
>      BADINST  # Bad instruction forcing return to FP emulator
>      COOKIE   # Bad instruction (not executed) for verification
>      <epc>    # Where to resume execution after <instr>
      [ user-land stack-pointer points here(-ish) ]

 Whilst thinking about the problem and possible solutions,
 it occurred to me there could be a defect in the current
 trampoline:  Suppose there is a signal, either at point A,
 due to <instr> itself, or at point B, which is caught on
 this stack, and the user-land signal-handler ‘return’s.

 Doesn't the signal-handler/sigreturn stack-frame overwrite
 the FP trampoline?   In which case, when the signal-hander
 returns, more-or-less anything could happen.  (And very
 unlikely to be what's wanted!)

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
