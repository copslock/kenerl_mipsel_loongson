Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 21:43:49 +0100 (BST)
Received: from n1b.bullet.mail.ac4.yahoo.com ([76.13.13.71]:31730 "HELO
	n1b.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20023485AbZD3Uno (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 21:43:44 +0100
Received: from [76.13.13.25] by n1.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 20:43:37 -0000
Received: from [76.13.10.162] by t4.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 20:43:37 -0000
Received: from [127.0.0.1] by omp103.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 20:43:37 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 609047.66002.bm@omp103.mail.ac4.yahoo.com
Received: (qmail 69353 invoked by uid 60001); 30 Apr 2009 20:43:37 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1241124217; bh=lkOW0LWhHP+63+DOvDWs4m07ks5p2K5RuOtHwmmc/jA=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type; b=QHlObrBxoqem8IMy27+mUo4Xd67S1NtohIyIHROEoDPC08Fbj9M0L75CD6d59bIeJ6aCavu49kgilSm3asHa+Qra1Gf+PjTRojLXhARXyXyPfEbcP7jzAxXa/eHi1iXMonpTqNpeH/FUvJUL9fgp3MtxaYUztgtIL96i62kErbs=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
  b=06G6qtH3z4UOXCQmGiRusltSogLHAU9w1ZzaP3e007a711t0DoxNrADnAG7CWpdTRDXmWdDpY7NByaN/jhx5f0rwPBnxiOY5W47Y17mgxyUUvvEta0HO1IN5EQc+DP48SLI6quOPNpIZl6VYHQqpnzJq3M4HVgphr8qMwqHbfyM=;
Message-ID: <211264.67202.qm@web59810.mail.ac4.yahoo.com>
X-YMail-OSG: 9XM4j7oVM1nbxfqoYUX3RNDsbQiafB01VW46NSkhpZM76ZGuMrCmf4qCucwBIdn2AmC.TAS8R8vYpC10Bvj44WCWJPCVWp0sEj4sHuuMvf1.LYxG.iBRBoOBdeLLLCNee11CtduCA4q1OiviRKYW7ny0ocishq4p4dNfe4NOnqBpYuKOZPWqPMukaYK5XD_Ah.29yTLqNtY6hCDj6Zn7TZOsszPoQ5abDfg2JKljdEIX0fZQmLusDVy2RLVQ.0pF_2hFubgnh_hfQZS68mvK.Lqx0fzvUWqdFPI8zfI9q4KoPD_NDTwcQAY7p6onRNWIAW5gkz.lsLjHsgrtsmssh.HLN0SQcwm9cpLMTUjldjpRE_8-
Received: from [91.196.252.17] by web59810.mail.ac4.yahoo.com via HTTP; Thu, 30 Apr 2009 13:43:33 PDT
X-Mailer: YahooMailWebService/0.7.289.1
Date:	Thu, 30 Apr 2009 13:43:33 -0700 (PDT)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: Re: [PATCH] 0002-sgi-o2-gbe-mte-init.diff
To:	linux-mips@linux-mips.org
In-Reply-To: <49FA0831.8060406@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips





--- On Thu, 4/30/09, David Daney <ddaney@caviumnetworks.com> wrote:

> From: David Daney <ddaney@caviumnetworks.com>
> Subject: Re: [PATCH] 0002-sgi-o2-gbe-mte-init.diff
> To: randrik_a@yahoo.com
> Cc: linux-mips@linux-mips.org
> Date: Thursday, April 30, 2009, 8:21 PM
> Andrew Randrianasulu wrote:
> > Very simple test patch, broke nothing for me.
> > 
> > diff --git a/drivers/video/gbefb.c
> b/drivers/video/gbefb.c
> > index ed732a8..1d3b599 100644
> > --- a/drivers/video/gbefb.c
> > +++ b/drivers/video/gbefb.c
> 
> Are all these patch passing checkpatch.pl?  I see no
> Signed-off-by: headers.

No :( I mean i not even run checkpatch.pl on them .... sorry.
If my 'work' too premature here - i can move to another mail-list. Thanks anyway.

> 
> David Daney


      
