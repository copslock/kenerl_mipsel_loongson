Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2009 13:32:39 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:65346 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492581AbZKUMcc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 21 Nov 2009 13:32:32 +0100
Received: by pxi3 with SMTP id 3so2999253pxi.22
        for <multiple recipients>; Sat, 21 Nov 2009 04:32:26 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Pw+OpAa6DrEfd1+u+aBeeEt+TGTAg56VMNVUcO2U6IY=;
        b=cvtMSqv6EEQLYdUwoa26f6tTmSS0kj2wRQ7eTpdqmkZ89oRB6CtZaxzCXnlj0VAzdj
         F5TOc7S4zmnRh8icTnvEhvTA0SL63d9youUvXgboTlh97JoAu5R07mHnAD/3Tn/YkBiP
         vPgbuz77TZma1Cy20+wFvZl0ouxkNYujJx6sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=V8l4yNCJVIKS9hgivwI9admt5//uIT7vPLHQm/ugvaAXTwrv46Y3iVznwabZCQH3t6
         bqIQFaNmB534Ig8+m793LEJQZHxyGun4alYnxgK5QklXwwNLDDIaRNRuBco/24GAoQjr
         JtbyXPce8QkV6RROR5H0QgpOK+JH9GH9TSU2o=
Received: by 10.115.86.3 with SMTP id o3mr3653943wal.206.1258806746018;
        Sat, 21 Nov 2009 04:32:26 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1545499pxi.4.2009.11.21.04.32.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 04:32:25 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fixups of ALSA memory maps
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Takashi Iwai <tiwai@suse.de>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <s5hskcbbu80.wl%tiwai@suse.de>
References: <9cbcd06037c18288a6493459b8f3a6e1562eca77.1258389992.git.wuzhangjin@gmail.com>
	 <s5hd43iiebt.wl%tiwai@suse.de> <20091116174324.GA17748@linux-mips.org>
	 <s5hhbst4hzt.wl%tiwai@suse.de> <20091118142056.GB6615@linux-mips.org>
	 <s5hskcbbu80.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sat, 21 Nov 2009 20:31:41 +0800
Message-ID: <1258806701.5752.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-18 at 18:47 +0100, Takashi Iwai wrote:
[...]
> 
> Well, we haven't reached the consensus.  The discussion faded away
> somehow mainly because I had too little time to update and ping people
> again.
> 
> In Tokyo, I talked with some guys regarding this.  Ben agreed to take
> this approach for ppc, and David said that he doesn't mind for sparc
> part.   Fujita-san mentioned it's no big problem to add one op from
> the generic dma_ops.
> 
> So, maybe somehow need to convince James in the end (and ask Paul to
> check SH part, too), then it'll be all up... theoretically :)
> 
> Anyway, I'm going to raise the discussion again on linux-arch.
> I'm afraid it's a bit too late game for 2.6.33, but starting now is
> better than too late again.

Hi, Takashi Iwai

Before the API stuff going into the mainline(2.6.33), can we apply this
"[PATCH] MIPS: Fixups of ALSA memory maps"(This is the minimal
necessares) as a current fixup. and then we will not get a broken sound
support for MIPS, and also the support to the latest Loongson2F family
machines will benefit from it.

and Ralf, what about your suggestion?

Thanks & Best wishes,
	Wu Zhangjin
