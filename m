Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Apr 2009 08:20:11 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:59508 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021767AbZD0HUG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Apr 2009 08:20:06 +0100
Received: by ewy22 with SMTP id 22so1969558ewy.0
        for <linux-mips@linux-mips.org>; Mon, 27 Apr 2009 00:19:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:reply-to:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=bUEt2hoeZibzPa+g196oZ0b3blL7JgU0WW4oHHGgmL4=;
        b=TJ1YfXokMi8XmALtjxwcgUXY7Hh+0aB3R0fkV8szjHbMEhbBS95x+XCIV3yeRtmZju
         3PhbDolw9HUtyuWaY62c4RMVfg9bXlkLoaH4RkCe4F2u79basxQc/TBm7Cabxu/N0Yv1
         Fi6C0b7thv9Ds5bCCac2g3RuDZNoEbS8L7Iag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:reply-to:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=oyTK2B0dS90kldcN3ICvv/MF9/Bgu1yjiuEhVswidXB14egAaSzomu4VPa1YpX5agx
         HpRDoBCsj9s1s9UFmzpDiH4Si/gyKdcomtjlv0dp0T/a97+fzamGkplYz91XGKGCIAXR
         ZE+HacC6puuh8c4I0eQYYS0iUCwq+SN49EVrc=
Received: by 10.210.61.2 with SMTP id j2mr565270eba.65.1240816799464;
        Mon, 27 Apr 2009 00:19:59 -0700 (PDT)
Received: from innova-card.com (LRouen-152-82-23-47.w80-13.abo.wanadoo.fr [80.13.118.47])
        by mx.google.com with ESMTPS id 7sm5597315ewy.58.2009.04.27.00.19.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 00:19:58 -0700 (PDT)
From:	Brian Foster <brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
Date:	Mon, 27 Apr 2009 09:19:00 +0200
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; x86_64; ; )
Cc:	"Kevin D. Kissell" <kevink@paralogos.com>,
	linux-mips@linux-mips.org
References: <49EE3B0F.3040506@caviumnetworks.com> <49F16F38.8060009@paralogos.com> <49F1DB1B.2060209@caviumnetworks.com>
In-Reply-To: <49F1DB1B.2060209@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904270919.00761.brian.foster@innova-card.com>
Return-Path: <blf.ireland@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian.foster@innova-card.com
Precedence: bulk
X-list: linux-mips

On Friday 24 April 2009 17:30:35 David Daney wrote:
> Kevin D. Kissell wrote:
> > Brian Foster wrote:
> >> On Wednesday 22 April 2009 20:01:44 David Daney wrote:
> >>> Kevin D. Kissell wrote:
> >>>> David Daney wrote:
> >>>>> This is a preliminary patch to add a vdso to all user processes.
> >>>>>[ ... ]
> >>>> Note that for FPU-less CPUs, the kernel FP emulator also uses a user
> >>>> stack trampoline to execute instructions in the delay slots of emulated
> >>>> FP branches.  [ ... ]
> >>
> >>    As David says, this is a Very Ugly Problem.  Each FP trampoline
> >>   is effectively per-(runtime-)instance per-thread [ ... ]
> > 
> > I haven't reviewed David's code in detail, but from his description, I 
> > thought that there was a vdso page per task/thread.  If there's only one 
> > per processor, then, yes, that poses a challenge to porting the FPU 
> > emulation code to use it, since, as you observe, the instruction 
> > sequence to be executed may differ for each delay slot emulation.  It 
> > should still be possible, though.  [ ... ]
> 
> Kevin is right, this is ugly.
> 
> My current plan is to map an anonymous page with execute permission for 
> each vma (process) and place all FP trampolines there.  Each thread that 
> needs a trampoline will allocate a piece of this page and write the 
> trampoline.  We can arrange it so that the only way a thread can exit 
> the trampoline is by taking some sort of fault (currently this is true 
> for the normal case), or exiting.

David,

   The above is the bit which has always stumped me.
  Having a per-process(or similar) page for the FP
  trampoline(s) is the “obvious” approach, but what
  has had me going around in circles is how to know
  when an allocated slot/trampoline can be freed.
  As you imply, in the normal case, it seems trivial.
  It's the not-normal cases which aren't clear (or at
  least aren't clear to me!).

   You say (EMPHASIS added) “We can arrange it so
  that the ONLY way a thread can exit the trampoline
  is by taking some sort of fault ... or exiting”,
  which if true, could solve the issue.  Could you
  elucidate on this point, please?

  Thanks for your time, effort, and patience.
cheers!
	-blf-

>                                    Then we free the trampoline for other 
> threads to use.  If all the slots in the trampoline page are in use, a 
> thread would block until there is a free one, rarely, if ever would this 
> happen.
>[ ... ]

-- 
“How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.” |      http://www.stopesso.com
