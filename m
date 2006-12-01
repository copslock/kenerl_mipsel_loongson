Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2006 10:19:40 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:15324 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037861AbWLAKTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Dec 2006 10:19:35 +0000
Received: by ug-out-1314.google.com with SMTP id 40so2568997uga
        for <linux-mips@linux-mips.org>; Fri, 01 Dec 2006 02:19:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b8XbmV27V8DNGeeoN4tB3lu2Z2RD53fzWn/cHEc2MkPN+RyJ/nEqFCO08tMR/TR+B7r/sjtH6JOfM/GKbBQ9pgnNETEWzvDPo4w2b4JXROcw70f6hPusY0IatcgulJT8Z0U6qhdC5bCRJ+fkW/ezyPJhn1DSp1EZHIsz/9KAibA=
Received: by 10.78.204.20 with SMTP id b20mr4669601hug.1164968374207;
        Fri, 01 Dec 2006 02:19:34 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Fri, 1 Dec 2006 02:19:34 -0800 (PST)
Message-ID: <cda58cb80612010219p50334a6cj4a797dcd608376ed@mail.gmail.com>
Date:	Fri, 1 Dec 2006 11:19:34 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Is _do_IRQ() not needed anymore ?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80612010140y5a95faceybffedbd4dd9900db@mail.gmail.com>
	 <20061201.185740.03976990.nemoto@toshiba-tops.co.jp>
	 <cda58cb80612010206r51d319a1x72105981d900068a@mail.gmail.com>
	 <20061201.191049.63741937.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/1/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Fri, 1 Dec 2006 11:06:44 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > If _all_ irq chip were converted to use flow handler,
> > > GENERIC_HARDIRQS_NO__DO_IRQ will be good.  But we have i8259...
> >
> > That's why in my example I made GENERIC_HARDIRQS_NO__DO_IRQ config
> > default to 'n' and selected by a irq chip that doens't use __do_IRQ()
> > anymore, well I think...
>
> You can use both irq_cpu and i8259 same time. :)
>

ok bad example. Why not making the select thing part of the platform
config like this ?

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5ff94e5..8565533 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -233,6 +233,7 @@ config LASAT
        select SYS_SUPPORTS_32BIT_KERNEL
        select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
        select SYS_SUPPORTS_LITTLE_ENDIAN
+       select GENERIC_HARDIRQS_NO__DO_IRQ

 config MIPS_ATLAS
        bool "MIPS Atlas board"
@@ -913,6 +914,10 @@ config SYS_SUPPORTS_BIG_ENDIAN
 config SYS_SUPPORTS_LITTLE_ENDIAN
        bool

+config GENERIC_HARDIRQS_NO__DO_IRQ
+       bool
+       default n
+
 config IRQ_CPU
        bool

-- 
               Franck
