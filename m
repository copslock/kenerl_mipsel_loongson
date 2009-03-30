Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 09:39:57 +0100 (BST)
Received: from mail-qy0-f103.google.com ([209.85.221.103]:8387 "EHLO
	mail-qy0-f103.google.com") by ftp.linux-mips.org with ESMTP
	id S20035989AbZC3Ijw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2009 09:39:52 +0100
Received: by qyk1 with SMTP id 1so3645225qyk.22
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2009 01:39:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LPcS0K3eD+zgazAhJM2fx9e6ihLwRLynwFs/bJwz7mo=;
        b=WL93GxRuw98levMCno0QlMMYqfBOm6RhXH30D0npLUrWSdT0rH02inJTYuqvSlZdhL
         NN0zA5qFceV6JQ5gtH81fBPRdp/oJaHyhjBebb1vvIdMDP4bqtx3guY9JSn5jqN5LHo6
         pAmKTo8Iyys+G3MNSpI2VgKaeICi5LtvIBo5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AzWEny8J3iIHVZXEs3+THRKBKSr92kI93XlmOrYXjA09rb8dXqe6rjIntVZaFTo1gE
         PHjAzBHKpmU94OP88hUXf/eusNO5w3l28Obut4OvwrCm8qSUebQy0xo3+4Zji715DqKU
         c+Ey9VJdele30XtrYKsOwsQSY2FTALfbfHPDw=
Received: by 10.224.67.206 with SMTP id s14mr5741114qai.289.1238402385885;
        Mon, 30 Mar 2009 01:39:45 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 9sm3762913yws.5.2009.03.30.01.39.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 01:39:45 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH 0/3] Alchemy: platform updates
Date:	Mon, 30 Mar 2009 10:39:40 +0200
User-Agent: KMail/1.9.9
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <1238318822-4772-1-git-send-email-mano@roarinelk.homelinux.net> <1238340466.28598.4.camel@kh-d820> <20090329175243.04ebfd56@scarran.roarinelk.net>
In-Reply-To: <20090329175243.04ebfd56@scarran.roarinelk.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200903301039.41398.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Manuel, Kevin,

Le Sunday 29 March 2009 17:52:43 Manuel Lauss, vous avez écrit :
> On Sun, 29 Mar 2009 10:27:46 -0500
>
> Kevin Hickey <khickey@rmicorp.com> wrote:
> > On Sun, 2009-03-29 at 17:03 +0400, Sergei Shtylyov wrote:
> > >   Single kernel binary? If it's at all possible, I am all for it.
> >
> > On some level, I agree but not at the expense of a larger kernel or
> > longer boot times.  Maybe I'm just not following how your implementation
> > works but it seems to me that runtime checks will add to boot time.
> > More importantly it adds to the kernel memory footprint as the tables of
> > constants for multiple CPUs will have to be compiled in.  If I'm
> > designing a board with an Au1250 in it, I don't care about the interrupt
> > numbers for Au1100 or Au1500.  This problem compounds when we introduce
> > Au1300 - several of its subsystems (like the interrupt controller) are
> > new requiring not only a new table of constants but a new object as
> > well.  In the desktop space I can understand this approach, but in the
> > embedded space it seems like an unnecessary resource burden.
> >
> > Please enlighten me :)
>
> You're right, from a single-cpu-board POV it doesn't make sense.
> However if you have a few boards which mostly differ in the Alchemy
> chip used (and not much else difference in board support code), I find
> this to be highly beneficial.  If I can have a single binary for the
> folks testing these boards, all the better!

I definitively agree, from a distribution point of view, that's even better.  
For instance Maxime did an excellent job with bcm63xx [1] which has both 
different base addresses for the SoC registers and even different offsets for 
the same things inside those registers. Resulting kernel is not that slower 
even though I do not have figures to show. Additionnaly you can still choose 
which BCM63xx SoC you are compiling for.

>
> Yes, increased binary size is to be expected, but I don't expect it to
> be in the megabyte range.
>
> I'm primarily doing this for company-internal purposes; I just thought
> I'd share the final result, maybe someone else might find it useful.

[1] : 
http://www.linux-mips.org/git?p=linux-bcm63xx.git;a=blob;f=arch/mips/bcm63xx/cpu.c;h=0a403dd07cf48109c904486cc1106d99ce036aad;hb=30c20e2899bbf31069aee0bdc4258c211f7a3d0f
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
