Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 00:22:57 +0100 (BST)
Received: from ik-out-1112.google.com ([66.249.90.182]:33137 "EHLO
	ik-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S28580015AbYHRXWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Aug 2008 00:22:49 +0100
Received: by ik-out-1112.google.com with SMTP id b32so2413127ika.0
        for <linux-mips@linux-mips.org>; Mon, 18 Aug 2008 16:22:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=f6EMGe3+QDaXNeszJzVpXb8KrK4xkEcNLLyQoNA8RXE=;
        b=TCmh5q2ONuOz52DFhBaXyvauO0bUpPkJw4DhcvUk4bCZGdCslA82lHfMCLoPqzb7o/
         EJN+zJzpAKSq3FgJpjLP9kQg/pFOffzqD9rF7nsM4lM+Fx0dL/C1cVbwvGir4VjIw58H
         2aq4AAo2ykqr1ufcwJyQTGkNvyh1GSnF/0sxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=KsVhc5KXAN3qLw2ZaANqZE6APs4RFh2oaKzx7JnF5rA7/MC7Mc5v79YZcMeorP4r/N
         pUZ5ml/VYV0ailBW7jM5NGuStCSI5lvYyAdAjroCEe8b8zOCrpxF9ooLgUk/O0F6CyzK
         H3YrHcgrLimXbXpX4pE9Zj+TMboVpHO3sU3o0=
Received: by 10.210.28.4 with SMTP id b4mr8766735ebb.138.1219101768392;
        Mon, 18 Aug 2008 16:22:48 -0700 (PDT)
Received: by 10.210.23.7 with HTTP; Mon, 18 Aug 2008 16:22:48 -0700 (PDT)
Message-ID: <b2b2f2320808181622i4cea479eved37d3e30e903eac@mail.gmail.com>
Date:	Mon, 18 Aug 2008 17:22:48 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Patrick Glass" <Patrick_Glass@pmc-sierra.com>
Subject: Re: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <16B817FC3FB4A540BD8003EA6004CE7101A9FDD8@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_27878_33418594.1219101768384"
References: <E1KUmPs-0005uZ-Du@localhost>
	 <20080818212812.GA28692@linux-mips.org>
	 <16B817FC3FB4A540BD8003EA6004CE7101A9FDD8@BBY1EXM09.pmc_nt.nt.pmc-sierra.bc.ca>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_27878_33418594.1219101768384
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Patrick:

  I'm good with replacing the msp_setup patch that I had I submitted.

  Do you also have a patch to replace the plat_timer_setup function
definition in msp_time.c?  If these two problems are resolved, the
msp71xx_defconfig will finally compile.

Shane McDonald

On Mon, Aug 18, 2008 at 5:11 PM, Patrick Glass <Patrick_Glass@pmc-sierra.com
> wrote:

> >On Sun, Aug 17, 2008 at 11:51:48AM -0600, Shane McDonald wrote:
> >> From: Shane McDonald <mcdonald.shane@gmail.com>
> >> Date: Sun, 17 Aug 2008 11:51:48 -0600
> >> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> >> Subject: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
> >>
> >> The msp71xx_defconfig has never compiled in a kernel release.  This
> is
> >> because the file msp_setup.c relies on some definitions from the
> >> PMCMSP GPIO driver, which has not yet been accepted into the kernel.
> >> This patch checks for the existence of the PMCMSP GPIO driver; if it
> >> doesn't exist, no GPIO functions are referenced.
> >>
> >> This patch will continue to work after the GPIO driver has been
> >> accepted, so no changes will be necessary when that happens.
> >
> >Has the driver actually been submitted?  In its current form I doubt
> it'll be accepted since
> >there is now a generic GPIO framework so there should be no more new
> drivers/char/ GPIO
> >drivers.
> >
> >  Ralf
>
> Hi,
> I have attempted to submit a new patch for msp71xx which enables gpio
> access through the new gpio framework. Hopefully it should propogate
> throught the list soon... if I have not messed up (It's my first patch
> for linux-mips). Also we have a newer msp_setup that removes the gpio
> calls altogether. I will cleanup our msp_setup.c file and create a new
> patch that can replace this patch if that's ok with you.
>
> Thanks,
> Patrick Glass
>
>

------=_Part_27878_33418594.1219101768384
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi Patrick:<br><br>&nbsp; I&#39;m good with replacing the msp_setup patch that I had I submitted.<br><br>&nbsp; Do you also have a patch to replace the plat_timer_setup function definition in msp_time.c?&nbsp; If these two problems are resolved, the msp71xx_defconfig will finally compile.<br>
<br>Shane McDonald<br><br><div class="gmail_quote">On Mon, Aug 18, 2008 at 5:11 PM, Patrick Glass <span dir="ltr">&lt;<a href="mailto:Patrick_Glass@pmc-sierra.com">Patrick_Glass@pmc-sierra.com</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">&gt;On Sun, Aug 17, 2008 at 11:51:48AM -0600, Shane McDonald wrote:<br>
&gt;&gt; From: Shane McDonald &lt;<a href="mailto:mcdonald.shane@gmail.com">mcdonald.shane@gmail.com</a>&gt;<br>
&gt;&gt; Date: Sun, 17 Aug 2008 11:51:48 -0600<br>
&gt;&gt; To: <a href="mailto:linux-mips@linux-mips.org">linux-mips@linux-mips.org</a>, <a href="mailto:ralf@linux-mips.org">ralf@linux-mips.org</a><br>
&gt;&gt; Subject: [MIPS] msp71xx: resolve compilation problem in msp_setup.c<br>
&gt;&gt;<br>
&gt;&gt; The msp71xx_defconfig has never compiled in a kernel release. &nbsp;This<br>
is<br>
&gt;&gt; because the file msp_setup.c relies on some definitions from the<br>
&gt;&gt; PMCMSP GPIO driver, which has not yet been accepted into the kernel.<br>
&gt;&gt; This patch checks for the existence of the PMCMSP GPIO driver; if it<br>
&gt;&gt; doesn&#39;t exist, no GPIO functions are referenced.<br>
&gt;&gt;<br>
&gt;&gt; This patch will continue to work after the GPIO driver has been<br>
&gt;&gt; accepted, so no changes will be necessary when that happens.<br>
&gt;<br>
&gt;Has the driver actually been submitted? &nbsp;In its current form I doubt<br>
it&#39;ll be accepted since<br>
&gt;there is now a generic GPIO framework so there should be no more new<br>
drivers/char/ GPIO<br>
&gt;drivers.<br>
&gt;<br>
&gt; &nbsp;Ralf<br>
<br>
</div></div>Hi,<br>
I have attempted to submit a new patch for msp71xx which enables gpio<br>
access through the new gpio framework. Hopefully it should propogate<br>
throught the list soon... if I have not messed up (It&#39;s my first patch<br>
for linux-mips). Also we have a newer msp_setup that removes the gpio<br>
calls altogether. I will cleanup our msp_setup.c file and create a new<br>
patch that can replace this patch if that&#39;s ok with you.<br>
<br>
Thanks,<br>
<font color="#888888">Patrick Glass<br>
<br>
</font></blockquote></div><br></div>

------=_Part_27878_33418594.1219101768384--
