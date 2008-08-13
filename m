Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 08:06:00 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.155]:14443 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20037176AbYHMHFz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 08:05:55 +0100
Received: by fg-out-1718.google.com with SMTP id d23so1455070fga.32
        for <linux-mips@linux-mips.org>; Wed, 13 Aug 2008 00:05:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=2GNKLrcW+kIAAi6ibQRaGJKcht0cF3WDmD4e2bTR3nk=;
        b=FOTgmWDKGW52EE5DtZNqi9dwt3VrUzxEJmg+5mAPFljTPMKqIHvqptOtx5pSOBe47l
         F+8L4RzYDQAly/rakSwg01uLF5W2DFavDmHCFbEqkwvLJ8EHzjQ+EnxyaTQrdYgR0OoR
         HTy9rAcuAdx4Qrmi6L941hbmfRsKWGnk4imH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=kBt+MB6XyOTRRCKQfwZsgahuVssPJU8CeUAws5Zi2CTg1YZvP9Ql7gXjETlvQzKTVO
         w02olGCtxtBbxCMxFHjAWblGo9CjiuqA7CpGhXmPw1iq6E5f8WT/7wvNAoB60D/Mhi+5
         EvtEDA3cV7tOg+ihoMyhwogJ3I9q8Y8UYF/o8=
Received: by 10.86.58.3 with SMTP id g3mr11811941fga.21.1218611153823;
        Wed, 13 Aug 2008 00:05:53 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 4sm7522754fgg.4.2008.08.13.00.05.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 00:05:52 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	linux-mips@linux-mips.org
Subject: Re: Debugging the MIPS processor using GDB
Date:	Wed, 13 Aug 2008 09:05:53 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
References: <18944199.post@talk.nabble.com> <200808121637.42148.brian.foster@innova-card.com> <Pine.LNX.4.55.0808121720370.24222@cliff.in.clinika.pl>
In-Reply-To: <Pine.LNX.4.55.0808121720370.24222@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200808130905.53671.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Tuesday 12 August 2008 18:27:42 Maciej W. Rozycki wrote:
> On Tue, 12 Aug 2008, Brian Foster wrote:
> >   I'm using the commercial FS² (First Silicon Systems, now owned
> >  by MIPS) EJTAG probe.  [ ... ]  There is no ‘gdbserver’ in this
> >  setup per se, albeit I suppose the protocol between ‘gdb’ and
> >  the FS² software [ ... ] might be similar/identical[?]
> 
>  Not really -- it uses a C API called MDI -- the spec is available from
> MIPS Technologies.  I am happy to read somebody finds it useful. :) 
> Debugging the Linux kernel with GDB and this piece of hardware is
> certainly a lot of fun.

Maciej,

  Thanks for the clarification.  I didn't know if MDI
 was related to the remote-‘gdbserver’ stuff or not.

  Re the FS²:  When it works, my (somewhat limited)
 experience to-date is it works Ok.  And the use of
 TCL on the Host workstation side allows some neat
 tricks.  However, at least one thing doesn't work
 reliably for me, albeit I've never investigated:
 Breakpoints in the Linux kernel.  They do detonate.
 Then, sometimes, I can ‘c’(ontinue) or ‘s’(tep) Ok.
 But other times, when I ‘c’ or ‘s’, the breakpoint
 detonates again and I'm stuck.  I cannot proceed.
 (The same breakpoint might even work once or twice
 and then fail.)   Any ideas?   AFAICR, this can also
 happen if I try to use the ‘sysnav’ console instead
 of ‘gdb’.

  I understand my predecessor in my job I gave up on
 the FS² (very possibly because of this breakpoint
 issue?) and used a competing (E?)JTAG probe.

  Weirdly, I've only seen this effect with the Linux
 kernel — other kernel-mode software (e.g., the trivial
 custom bootloader) — doesn't seem to suffer from these
 “flakey FS² breakpoints”?

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
