Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Apr 2009 08:12:23 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:34203 "EHLO
	mail-ew0-f174.google.com") by ftp.linux-mips.org with ESMTP
	id S20030464AbZDJHMQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Apr 2009 08:12:16 +0100
Received: by ewy22 with SMTP id 22so1046748ewy.0
        for <linux-mips@linux-mips.org>; Fri, 10 Apr 2009 00:12:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=/eZ462DLizl9npbYKS2uD1v1cMRw6kVzMHAa8IiRavI=;
        b=Uue/08WKCnLYOOjA7oHhAQMDvv6hqDt3REDwcc5IvBcFg3Ea2C+/cne05ref9E6CyO
         3KUNpTW11w8hM+vQ4XnXz6NaKMBxHhag0ryQ9oAUQeb+BJnKuEr35I4N1M+9Z3KYRzuA
         CLz/vbXwQc5DVYMX3uEi+NU/5oAreqcnCsI+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TOc1ufeBt8n74tHeZJUALdG3sF6cqvYBkQsmsiRd+0iTC2x8fkPf7Gy65QNIjWxWhi
         nvlOACV2A9P+jz0DejOVptFHKkokhDlQkvzB9qWCbrYt1IC7J5Qmw8l043v60eRm3Ddb
         ABU8MCp0BDQlN41Ofmr82kXqSy9RzprW10Pio=
Received: by 10.210.137.14 with SMTP id k14mr2759510ebd.23.1239347529746;
        Fri, 10 Apr 2009 00:12:09 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 4sm1315308ewy.80.2009.04.10.00.12.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Apr 2009 00:12:08 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Wuertele <dave+gmane@wuertele.com>
Subject: Re: What is the right way to setup MIPS timer irq in 2.6.29?
Date:	Fri, 10 Apr 2009 09:11:37 +0200
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	linux-mips@linux-mips.org
References: <loom.20090408T165537-312@post.gmane.org> <loom.20090409T195344-317@post.gmane.org>
In-Reply-To: <loom.20090409T195344-317@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904100911.37788.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Thursday 09 April 2009 22:01:43 David Wuertele wrote:
> I wrote:
> 
> > Has the system timer paradigm changed between 2.6.18 and 2.6.29?
> > I'm trying to update my Broadcom-based embedded system to 2.6.29,
> > and I'm running into problems getting the system timer to run.
> 
> I solved my problem, though I'm still a little unclear about the reasoning.
> 
> The solution was to enable these:
> CONFIG_CEVT_R4K=y
> CONFIG_CSRC_R4K=y
> 
> I also had to define get_c0_compare_int() to return the system timer
> interrupt.  Once I had done these things, start_kernel() calls time_init(),
> which calls mips_clockevent_init() and init_mips_clocksource().
> init_mips_clocksource() calls the init_r4k_clocksource() that was
> enabled with the new config options.  Now my system clock runs like
> I think it should.

   Yep!  That's the bunny.  I do wish it was documented
  someplace in a useful fashion.  In my case, since all
  of our interrupts are routed through an our SoC's PIC,
  I also had to back-port compare_change_hazard() from
  8531a35e5e275b17c57c39b7911bc2b37025f28c plus some
  other changes specific to our SoC and its PIC (we're
  currently moving to 2.6.24, hence the back-porting).

> I think I might not need the CEVT components... I'm going to look into that
> next.  But I wish there was some easy to find documentation about why this
> code had to be moved into the arch/mips/cevt-*.c and arch/mips/csrc-*.c
> libraries.

   You “need” them if you use the core's counter for
  jiffies and want “tickless idle” (which you have to
  enable (with CONFIG_NO_HZ or something like that
  (I don't recall))), or at least that's my current
  understanding.  If you do happen to find some doc
  about the API changes, I'd love to see/read it.

cheers!
	-blf-

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
