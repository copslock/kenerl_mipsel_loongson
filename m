Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 16:18:55 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.192]:49796 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133474AbVJDPSi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 16:18:38 +0100
Received: by zproxy.gmail.com with SMTP id j2so185772nzf
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2005 08:18:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dYStpcyIUwIWUsQTElWd8e+TncQNQmdpKN9VuLdj/q9EfLiUmXiyjRt3x/0HPa3SiLVWsIdNpYKc2tog7EscYXfdE7byLy1WzVBGMzEcMDdf7WZzqQa2uWws2mMZQCC0WRl8sdqnBROiPrm1r/hX/qU5ZvzvdzEQ6nWn40ASlyY=
Received: by 10.36.224.42 with SMTP id w42mr309975nzg;
        Tue, 04 Oct 2005 08:18:26 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Tue, 4 Oct 2005 08:18:26 -0700 (PDT)
Message-ID: <cda58cb80510040818v6d93fe53w@mail.gmail.com>
Date:	Tue, 4 Oct 2005 17:18:26 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <434289A7.50007@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <434277D5.1090603@mips.com>
	 <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
	 <434289A7.50007@mips.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/4, Kevin D. Kissell <kevink@mips.com>:
> >  Well, the patch asked GCC to use the instruction set of the "4kec" CPU
> > for both (and also the "mips32r2" ISA, but that's overridden by the
> > former), so it must have been incorrect in the first place
>
> Which was sort-of why I replied.  In particular, the MIPS32R2 bitfield
> instructions will probably cause a reserved instruction fault on a 4KSc.
>

should I pass these options to GCC for 4KSc ?

cflags-$(CONFIG_CPU_4KSC)      += \
                       $(call set_gccflags,4kc,mips32r1,r4600,mips3,mips2) \
                       -msmartmips -Wa,--trap

Thanks
--
               Franck
