Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 18:33:35 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.206]:54191 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133479AbVJDRdT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 18:33:19 +0100
Received: by zproxy.gmail.com with SMTP id j2so212696nzf
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2005 10:33:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YTCE7NtIAtCUlUAX/vxctv2AshU52Bl2yi4+eppALyhlYD0ojQnDKX5N007+S9HhTGIpnppSNNoie0Qfy2r7IVfDHEPDK6MDrMBrJmHFx4UOM/4tqzJ6xlV1prMJz5WDesW2Az2m/oDgtpxl8X0FfvPD7d9mHxqQuqGxP+lP1b4=
Received: by 10.36.97.9 with SMTP id u9mr459211nzb;
        Tue, 04 Oct 2005 10:33:13 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Tue, 4 Oct 2005 10:33:13 -0700 (PDT)
Message-ID: <cda58cb80510041033h2a67f072s@mail.gmail.com>
Date:	Tue, 4 Oct 2005 19:33:13 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0510041651150.10696@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <434277D5.1090603@mips.com>
	 <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
	 <434289A7.50007@mips.com>
	 <cda58cb80510040818v6d93fe53w@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041651150.10696@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/4, Maciej W. Rozycki <macro@linux-mips.org>:
> On Tue, 4 Oct 2005, Franck wrote:
>
> > should I pass these options to GCC for 4KSc ?
> >
> > cflags-$(CONFIG_CPU_4KSC)      += \
> >                        $(call set_gccflags,4kc,mips32r1,r4600,mips3,mips2) \
> >                        -msmartmips -Wa,--trap
>
>  s/mips32r1/mips32/, otherwise OK.
>
>  But since you seem to use SDE, you may as well just use "4ksc" (and
> possibly skip "-msmartmips" as it's implied); similarly for "4ksd".
> Unfortunately documentation on what CPU types are accepted seems to be
> incomplete -- use `gcc -v --help' to see which ones are actually
> available.
>

maybe something like these are better (I removed last parameter since
it's no more used) ?

cflags-$(CONFIG_CPU_4KSC)       += \
                        $(call set_gccflags,4ksc,mips32,4kc,mips32) \
                        -Wa,--trap

cflags-$(CONFIG_CPU_4KSD)       += \
                        $(call set_gccflags,4ksd,mips32r2,4kec,mips32r2) \
                        -Wa,--trap

Thanks
--
               Franck
